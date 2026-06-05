#### 原文献：

InsTag 的关键贡献是把“数据多样性”和“数据复杂度”从模糊经验变成可操作的标签指标，并证明这些指标可以指导 SFT 数据选择，用很少的数据训练出更强的对齐模型。它最适合用在大模型微调前的数据分析、筛选和构造阶段。

2023 InsTag: Instruction Tagging for Analyzing Supervised Fine-tuning of Large Language Models https://arxiv.org/abs/2308.07074



README.md和 InsTag_paper.pdf 从流程重建。

**复现计划**
https://huggingface.co/datasets/openchat/openchat_sharegpt4_dataset

1. **数据初始化**

   - 准备 SFT 数据池：`ShareGPT`。

   - 论文主实验数据池规模：`306,044` samples，归一化后 tag set size `6,398`，平均 tag 数 `4.48`。

   - 统一样本格式：

     ```json
     {
       "id": "...",
       "source": "sharegpt",
       "conversations": [...],
       "query": "当前 human turn",
       "response": "对应 assistant turn"
     }
     ```

2. **开放式标签生成**

   - 对每个 query 单独调用 ChatGPT/等价 LLM。

   - 使用论文 Table 4 的 prompt，要求输出：

     ```json
     [{"tag": "str", "explanation": "str"}]
     ```

   - 保存 raw tagging 结果：

     ```json
     {
       "sample_id": "...",
       "query": "...",
       "raw_tags": [{"tag": "...", "explanation": "..."}]
     }
     ```

3. **标签归一化**

   - **Frequency Filtering**：过滤全数据中出现次数 `< 20` 的长尾 tag。
   - **Rule Aggregation**：
     - 全部小写；
     - 特殊字符替换为空格；
     - 用 NLTK stemming 合并词形差异。
   - **Semantic Aggregation**：
     - 用 `PhraseBERT` 对 tag phrase 编码；
     - 用 `DBSCAN` 聚类；
     - 论文阈值：minimum semantic similarity `0.05`。
   - **Association Aggregation**：
     - 用 FP-Growth 挖 tag 共现规则；
     - minimum support `40`；
     - minimum confidence `99%`；
     - 递归合并高度关联 tag。
   - 论文规模参考：原始 unique tags 超过 `100K`，过滤后 `8,541`，规则聚合后 `7,157`，语义聚合后 `6,587`，关联聚合产生 `1,772` 条规则。

4. **指标计算**

   - **复杂度**：每个样本/session 的 tag 数；数据集复杂度为平均 tag 数。

   - **多样性**：tag coverage rate，即子集覆盖的 unique tags / 全局 tag set。

   - 产出分析表：

     ```text
     dataset, sample_count, unique_tag_count, avg_tag_count, coverage_rate
     ```

5. **复杂度优先的多样采样**

   - 目标：从 pooled dataset 中选 `6K` 条。
   - 按 tag 数降序排序。
   - 每轮从剩余样本中选择能扩展当前 tag set 的样本。
   - 如果覆盖已满但数量不足，继续重复遍历直到达到 `6K`。
   - 论文目标结果：平均 tag 数约 `16.56`，tag coverage `100%`。

6. **训练 TagLM**

   - 基座：
     - `TagLM-13B-v1.0`：LLaMA 13B；
     - `TagLM-13B-v2.0`：LLaMA-2 13B。
   - 训练框架：FastChat。
   - 模板：Vicuna v1.1 style template。
   - 超参：
     - epochs：`5`
     - batch size：`128`
     - learning rate：`2e-5`
     - SFT data：上一步选出的 `6K` 样本。
   - 验证：MT-Bench，用 GPT-4 judge，论文报告三轮均值和标准差。

7. **可选：训练本地 InsTagger**

   - 目的：不用 ChatGPT API，本地生成 tags。

   - 基座：LLaMA-2 7B。

   - 训练数据：InsTag 标注结果，`773,511` 条，随机 `1,000` 条验证。

   - 模板：

     ```text
     You are a helpful assistant. Please identify tags of user intentions...
     Query: <query-to-tag> Assistant: <tagging-results>
     ```

   - 超参：batch size `512`，`1 epoch`。论文说超过 1 epoch 容易过拟合。

   - 指标：

     - exact match F1：`31.8%`
     - PhraseBERT fuzzy match F1：`73.4%`
     - fuzzy match 阈值：cosine similarity `> 0.8`

**优先级建议**

先复现 “数据初始化 → 标签生成 → 标签归一化 → 6K 采样”，这是论文核心；模型训练成本最高，可以最后做。若资源有限，先用已有 InsTagger checkpoint 替代 ChatGPT 标注，跑通 selector，再训练小模型或 LoRA 验证趋势。





#### 2026.6.5 存在的问题（Private）

显然这种方法还是不够通用：

不同领域无法迁移，一些细微的差异难以被打标签；

tagging作用的对象是一个开放域，无法覆盖新知识的标签；

对于格式、情绪、风格、语气的多样化没有评判标准；

无法高效构造数据集，没有统一的数据集的标准；

无法判断泛化数据和领域数据的差异；

目前仅支持从大的数据集采样小数据集；无法做数据比例的增强（当然可以做重要性采样）；

无法增加一些自定义的指标；



还有一个大问题：

效率太低！打标签是用大模型对数据集进行打标，至少是N次的查询；再加上反思，一致性的考虑，效率非常低下（如果考虑到调用的是最先进的api，可能一个10w条的数据集就要至少花掉1000块去做打标）。


#### 无人工标注的情况下怎么构建DPO数据集

DPO 数据集最基本的格式是三元组：

```json
{
  "prompt": "问题 x",
  "chosen": "更好的回答 y_w",
  "rejected": "更差的回答 y_l"
}
```

DPO 原论文里的设定就是：给定同一个 prompt，数据里有一个 preferred response 和一个 dispreferred response；DPO 用这个偏好对直接优化模型，而不需要再显式训练 reward model 后用 PPO 做 RL。

------

## 方法一：用可验证任务自动构造

这是最可靠的“无人类 DPO 数据”。

适合：

```text
数学题
代码题
选择题
有标准答案的问答
格式转换
信息抽取
SQL 生成
工具调用
```

流程是：

```text
1. 准备 prompt x
2. 让模型生成多个回答 y1, y2, ..., yn
3. 用 verifier / 单元测试 / 标准答案检查每个回答
4. 正确的作为 chosen，错误的作为 rejected
5. 组成 DPO pair
```

例如数学题：

```json
{
  "prompt": "求解 23 * 47。",
  "chosen": "23 * 47 = 1081，所以答案是 1081。",
  "rejected": "23 * 47 = 1071，所以答案是 1071。"
}
```

代码题也类似。比如让模型写一个函数，然后跑测试：

```text
通过全部单元测试的回答 -> chosen
编译失败 / 测试失败的回答 -> rejected
```

这类数据的优点是：偏好标签来自客观验证，不依赖人类主观判断。缺点是：只适合结果可以自动检查的任务。

------

## 方法二：用 LLM Judge 构造

也就是 RLAIF / AI Feedback。如果任务没有明确标准答案，比如聊天、写作、解释、总结，就可以用更强的模型当 judge。

流程是：

```text
1. 准备 prompt x
2. 用一个或多个模型生成候选回答
3. 把多个回答交给 judge model
4. judge model 根据 rubric 判断哪个更好
5. 高分回答作为 chosen，低分回答作为 rejected
```

这就是 AI feedback 的思路。Anthropic 的 Constitutional AI 论文明确说，在 RL 阶段，他们让模型对两个回答进行比较，判断哪个更好，然后用这些 AI preference 训练 preference model；这类方法被称为 RLAIF。([arXiv](https://arxiv.org/abs/2212.08073))

一个 DPO 样本可以这样来：

```json
{
  "prompt": "请解释为什么 PPO 里要用 clipping。",
  "chosen": "PPO 使用 clipping 是为了限制新旧策略的概率比，避免一次更新让策略变化过大，从而提高训练稳定性。",
  "rejected": "PPO 使用 clipping 是因为它可以让模型更聪明。"
}
```

但是 LLM Judge 不是客观真理。它会有偏差，比如偏好更长、更自信、更像模板的回答。所以要加控制：

```text
随机打乱 A/B 顺序
要求 judge 先按明确 rubric 打分
最好使用 pairwise comparison，而不是只给一个总分
```

------

## 方法三：用“自我修订”构造 chosen/rejected

这适合安全、礼貌、格式、推理表达等任务。

流程：

```text
1. 让模型先生成一个初始回答 y_bad
2. 让模型根据规则或 constitution 批判这个回答
3. 让模型改写出更好的回答 y_good
4. 用 y_good 作为 chosen
5. 用 y_bad 作为 rejected
```

Anthropic 的 Constitutional AI 里就有类似流程：先从初始模型采样回答，再生成 self-critique 和 revision，然后用修订后的回答做监督学习；在 RL 阶段再用 AI 对回答对进行偏好比较。

样本类似：

```json
{
  "prompt": "帮我写一封拒绝合作的邮件。",
  "chosen": "谢谢你的邀请。经过认真考虑，我们目前无法参与这个项目，但很感谢你想到我们，也希望未来还有合作机会。",
  "rejected": "不行，我们不想合作。"
}
```

这个方法的优点是便宜、可扩展。缺点是 chosen 和 rejected 可能太容易区分，模型学到的只是“更礼貌、更长”，而不是更深层的偏好。

------

## 方法四：用已有 Reward Model 打分

如果你已经有 reward model，可以这样做：

```text
1. 对每个 prompt 采样多个回答
2. reward model 给每个回答打分
3. 最高分回答作为 chosen
4. 最低分回答作为 rejected
```

例如：

```text
prompt x
y1: reward = 0.82
y2: reward = 0.35
y3: reward = 0.77
```

构造成：

```json
{
  "prompt": "x",
  "chosen": "y1",
  "rejected": "y2"
}
```

------

## 实际 pipeline

```text
Step 1：准备 prompt 集合
```

prompt 要来自你真正想提升的任务分布。

```text
Step 2：每个 prompt 采样多个回答
```

每个 prompt 生成 4 到 8 个回答；采样模型可以是：

```text
当前 SFT model
更强 teacher model
多个不同模型
同一个模型不同 temperature

```

Step 3：自动评价

按任务选择评价器：

```text
数学：答案验证器 / symbolic checker / 多数投票 + verifier
代码：单元测试 / 编译器 / 静态检查
选择题：标准答案
工具调用：schema 校验 + 执行结果
聊天：LLM judge + rubric
安全：constitution / policy judge
总结：事实一致性检查 + 覆盖度 judge
Step 4：构造 pair
```

不要把所有高低分都粗暴配对，要把chosen 分数明显高于rejected的数据选出来。如果质量差别不大，要过滤掉。

------

## 哪些方式最可靠

按可靠性排序：

```text
1. 可执行验证器 / 单元测试 / 标准答案
最可靠，适合数学、代码、工具调用、结构化任务。

2. 强模型 judge + 明确 rubric + 多 judge 投票
可用于开放式任务，但有偏差。

3. Reward model 打分
方便，但会继承 reward model 的偏差。

4. 自我修订数据
适合安全、风格、格式，但容易让数据过于简单。

```

## DPO数据标准：

DPO数据的标准是：

```text
chosen 本身要高质量；
rejected 要代表模型真实可能犯的错；
二者差异要和你的训练目标一致；
偏好标签要尽量可靠。
```

如果没有人类，常用的路线是：

```text
可验证任务：用 verifier 构造 DPO 数据
开放式任务：用强 LLM judge + rubric + 多轮过滤构造 AI preference 数据
安全/风格任务：用 constitution + self-revision + judge 构造偏好对
```


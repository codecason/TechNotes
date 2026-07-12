对比学习在RLVR的应用



### 1. CLIPO：最直接的“对比学习 + LLM RLVR”

**CLIPO: Contrastive Learning in Policy Optimization Generalizes RLVR**，2026 年 3 月。

核心做法：

- 对同一个问题采样多个 reasoning rollout；
- 把多个正确轨迹视为正样本，错误轨迹视为负样本；
- 对序列 hidden state 做 pooling，再经过轻量 contrastive head；
- 用 InfoNCE/SupCon 得到稠密对比奖励；
- 将其与原来的可验证结果奖励共同用于策略优化：

\[ r_{\text{total}} = r_{\text{outcome}} -\lambda L_{\text{contrastive}} \]

它要解决的问题是：普通 RLVR 只看最终答案，可能奖励“过程错误但碰巧答对”的轨迹；CLIPO 则鼓励模型学习多个正确推理轨迹共同包含的结构。

论文报告它能一致改善多个 RLVR baseline，尤其是分布外数学题、扰动题和困难推理任务。官方实现基于 `verl 0.6 + SGLang`，支持 InfoNCE、SupCon 和 Soft-NN loss，默认对比奖励权重为 0.2。[论文](https://arxiv.org/abs/2603.10101)｜[代码](https://github.com/Qwen-Applications/CLIPO)

这是目前与你问题最匹配的一篇。

### 2. Co-rewarding：用“跨问题对比一致性”构造自监督奖励

**Co-rewarding: Stable Self-supervised RL for Eliciting Reasoning in Large Language Models**，ICLR 2026。

它不直接对 rollout embedding 做 InfoNCE，而是借用了对比学习的“多视图一致性”思想：

- 为原问题构造语义相近的对应问题；
- 分别 rollout 并投票得到伪标签；
- 让两个语义相近问题的答案交叉验证；
- 将跨问题的一致性作为 RL 奖励。

另一个版本维护慢更新 teacher，通过伪标签和自蒸馏避免 self-reward 模型陷入“自洽但错误”的奖励坍塌。

论文报告，相比其他 self-reward baseline 平均提升 3.31%，在部分设置下达到或超过使用真实答案标签的 RLVR。[论文](https://arxiv.org/abs/2508.00410)

适合没有可靠 verifier、又想做数学或复杂推理自监督 RL 的场景。

### 3. MIO：把 RLHF/DPO 理论统一成对比学习

**The Hidden Link between RLHF and Contrastive Learning**，ICML 2026。

这篇更偏理论与 preference optimization。它指出：

- RLHF 和 DPO 可以解释为正、负回答之间的对比学习；
- 本质上是在优化基于 Donsker–Varadhan/MINE 的互信息下界；
- 当一个好答案在基础模型中的概率极小时，现有目标可能给不出有效学习信号；
- 因此作者改用 Jensen–Shannon 互信息估计器，提出 **MIO**。

它对于理解“为什么 RL 往往只是放大基础模型已有能力，而不容易发现全新推理路径”很有价值。但 MIO 更接近 DPO 一类离线偏好优化，不是典型的在线 RLVR。[论文与 ICML 2026 信息](https://openreview.net/forum?id=MJ25gbGhPu)｜[arXiv](https://arxiv.org/abs/2506.22578)

### 4. 两篇较早但基础性很强的工作

- **Contrastive Policy Gradient（CoPG，2024）**：构造正负回答之间的对比 policy-gradient，可利用 off-policy 数据，不依赖重要性采样；理论上连接了普通 policy gradient 与 IPO。[论文](https://arxiv.org/abs/2406.19185)
- **Improving RLHF Using Contrastive Rewards（2024）**：先离线采样 baseline responses，再根据相对 baseline 的改善程度构造 contrastive reward，用于 PPO；主要作用是降低奖励不确定性和梯度方差、提升噪声鲁棒性。[论文](https://arxiv.org/abs/2403.07708)

### 如何理解这条研究线

目前“对比学习用于大模型 RL”大致有三种路径：

| 路径          | 对比什么                       | 代表工作                          | 主要作用                |
| ------------- | ------------------------------ | --------------------------------- | ----------------------- |
| 轨迹表示对比  | 正确 rollout vs 错误 rollout   | CLIPO                             | 改善推理过程和 OOD 泛化 |
| 奖励对比      | 当前回答 vs baseline／相似问题 | Co-rewarding、Contrastive Rewards | 构造更稳定、稠密的奖励  |
| 策略/偏好对比 | chosen vs rejected response    | MIO、CoPG、DPO                    | 对齐与离线策略优化      |







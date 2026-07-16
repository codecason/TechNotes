对比学习在RLVR的应用

### 1. CLIPO：最直接的“对比学习 + LLM RLVR”

**CLIPO: Contrastive Learning in Policy Optimization Generalizes RLVR**，2026 年 3 月。

### 2. Co-rewarding：用“跨问题对比一致性”构造自监督奖励

**Co-rewarding: Stable Self-supervised RL for Eliciting Reasoning in Large Language Models**，ICLR 2026。

### 3. MIO：把 RLHF/DPO 理论统一成对比学习

**The Hidden Link between RLHF and Contrastive Learning**，ICML 2026。

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



#### Thoughts
26.6 Rethinking Entropy Interventions in RLVR: An Entropy Change Perspective
问题: 论文的方法是通过修改token-level的clip的阈值和条件，观察产生的对熵的影响；根本上无论怎么做，都只是增高好token的概率，降低token概率；



#### References

https://github.com/OpenManus/OpenManus-RL

用在GAIA, AgentBench, WebShop, and OSWorld

格式 ToT

强化学习模型 PRM


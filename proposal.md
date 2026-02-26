# 从格点到连续 —— 面向量子多体和计算物理研究者的共形场论

## 1. 核心理念与目标受众

### 1.1 核心理念：逆传统的"Bottom-up"路径
传统CFT教学遵循高能物理范式：**QFT → 对称性 → CFT**。这对没有QFT基础的团队过于陡峭。

本讨论班采用理论计算双轨制，应用CFT于凝聚态/统计物理，结合半Bottom up和Top-down的方式：
从**格点模型（Ising, XXZ, 自由费米子）→ 临界现象（Scale Invariance）→ CFT作为普适类描述**，在尽量知道公式和原理所从来的基础上，学会应用和计算。哪怕最后结束没follow上推导，至少也要学会图像和计算。

### 1.2 受众优势转化
- **量子多体背景**：熟悉纠缠熵（Cardy公式）、配分函数、Transfer Matrix、能谱
- **张量网络背景**：熟悉MPS/PEPS、iTEBD、固定点张量（Fixed Point Tensors）
- **"劣势"转化**：不熟悉QFT意味着没有路径依赖，可以直接建立"格点-CFT"的直接对应

关键在于**利用现有优势作为跳板**，而非弥补QFT的"不足"。对于熟悉纠缠熵的人来说，Virasoro代数只是全息纠缠熵的生成元；对于熟悉张量网络的人来说，CFT就是RG流的固定点。从这个角度切入，CFT会变得更具体、更有计算性。


### 1.3 讨论班规则
- **"无推导焦虑"规则**：参与者不需要理解每一步推导，但必须能解释**最终结果**的物理意义
- **" host model"义务**：每周指定一人准备5分钟的"物理栖居地"介绍，将该周数学与具体格点模型联系
- **代码分享**：鼓励使用GitHub共享Mini-project代码，形成可复现的"数值CFT工具包"



### 1.4 预期成果

通过这个讨论班，参与者将能够：
1. **理解CFT语言**：能够阅读使用CFT描述的拓扑序/多体物理论文（如anyon凝聚、拓扑相变）
2. **进行数值CFT分析**：掌握从格点模型提取中心荷、标度维数、OPE系数的实用技能
3. **建立张量网络-CFT联系**：理解为什么张量网络的固定点"就是"CFT，并能进行基础计算
4. **完成一个可展示的项目**：拥有一个完整的"格点模型 → CFT数据"分析案例，可作为未来研究的模板


---

## 2. 三个核心问题的解决方案

### 问题1：如何处理QFT前置知识？
**方案：工具箱模式（Toolbox Approach）**
- **不设专门的QFT预备周**。将必要的QFT概念拆解为10-15分钟的"微讲座"，嵌入到每周内容中，并直接与统计力学类比：
- **关键桥梁**：强调**Transfer Matrix哈密顿量**与**CFT哈密顿量**（Virasoro算符 $L_0 + \bar{L}_0$）的对应关系。这是你们最熟悉的语言。
- 核心替代字典：

| CFT/场论语言 | 统计力学/多体语言 | 出现时机 |
|-------------|------------------|---------|
| 真空态 $\ket{0}$ | 基态 / 配分函数归一化 | Week 2 |
| 路径积分 | 配分函数 $Z = \text{Tr}(e^{-\beta H})$ | Week 2 |
| 插入算符 $\phi(z)$ | 关联函数 $\langle O_i O_j \rangle$ | Week 2 |
| 正规序 $:\phi^2:$ | Wick定理（减真空涨落） | Week 3 |
| 能动量张量 $T(z)$ | Hamiltonian密度 $h_j$ 的生成元 | Week 3 |
| 径向量子化 | Transfer Matrix本征值问题 | Week 2 |
| 散射振幅 | 线性响应理论 | 略去不讲 |

### 问题2：如何避免迷失在公式推导中？
**方案：双轨制 + 物理栖居地（Physical Habitat）**

**双轨制日程（每周2小时）：**
- **1.5h（理论轨）**：聚焦核心概念和关键结果，**跳过技术性证明**（如所有关于 descendents 的详细计算、复杂的共形块推导、Kac行列式的详细计算）
- **0.5h（应用轨）**：阅读具体论文/数值实践，将当周公式与可计算的量关联，Zou论文对应算法实现 + 具体数值计算

**物理栖居地策略：**
每章指定一个"宿主模型"，所有抽象概念都先在**Transverse Field Ising Model (TFIM)**中具象化，Week 5后引入**O'Brien-Fendley (OF) 模型**（三临界Ising）作为第二例子

### 问题3：如何增加实践动机？
**方案：贯穿式 Mini-Project + 两篇论文精读**

**Mini-Project 选项（从Week 3开始，持续7周）：**
在10周内，从TFIM的格点哈密顿量出发，完整提取Ising CFT ($c=1/2$)的全部共形数据（中心荷、3个初级场的$\Delta$、关键OPE系数），并验证与Ginsparg第5章理论预言的吻合

**论文精读安排（拟）：**
- **Week 4-5**：精读 *"Extraction of conformal data in critical quantum spin chains using the Koo-Saleur formula"* (arXiv:1706.01436)
  - 目的：理解如何从格点能谱 $\{E_n\}$ 提取 $c$ 和 $\Delta$，建立第5-6章与数值实验的联系
  
- **Week 8-9**：精读 *"Precision reconstruction of rational CFT from exact fixed point tensor network"* (arXiv:2311.18005)
  - 目的：理解张量网络的固定点与CFT数据的对应，特别是第11章（有限尺寸）和第12章（缺陷）在张量网络中的体现


---

## 详细日程安排

### **Week 1: 共形群与统计力学中的尺度不变性**
**理论阅读**: Ginsparg Ch. 1 (d维共形群 & 2维共形代数 pp.3-6)  
**数值参考**: Zou Ch. 2.1 (Universality and Phase Transitions)

**理论内容（讨论班）**:
- d维欧几里得空间中的共形变换：平移、转动、伸缩、特殊共形变换
- 2维的特殊性：共形代数分解为 $\text{Conf}_2 \cong \text{Virasoro} \times \text{Virasoro}$（全纯×反全纯）
- 生成元 $L_n, \bar{L}_n$ 的代数关系预览

- **关键联系**：RG固定点处的统计力学系统具有共形不变性（ scaling invariance + translation/rotation invariance $\to$ conformal invariance via Polyakov's argument）**
- **统计力学翻译（微讲座）**:
> "在临界点，关联长度$\xi \to \infty$，系统失去特征尺度。此时系统不仅具有尺度不变性，还保持了角标度（angle-preserving）变换下的不变性，这就是统计力学中的共形不变性。"

**迷你讲座（15分钟）**: 
> "从Transfer Matrix视角看共形生成元：在1+1D量子链中，$L_0 + \bar{L}_0$ 对应哈密顿量，$L_0 - \bar{L}_0$ 对应动量。"

**课后实践（Zou Ch. 2.1）**:
- 理解TFIM在临界点 ($h=1$) 的能谱与尺度不变性的关系
- 准备数值环境：安装`ITensor.jl`或`puMPS.jl`(Provided by yijian Zou)

**作业**: 推导2D共形代数$[L_m, L_n] = (m-n)L_{m+n}$（无中心项）的交换关系

---

### **Week 2: 2D CFT基础 —— Primary Fields与Radial Quantization**
**理论阅读**: Ginsparg Ch. 2.1-2.2 (Primary fields关联函数 & Radial Quantization pp.12-15)  
**数值参考**: Zou Ch. 4.1.1 (Scaling dimensions and conformal spins)

**理论内容**:
- **Primary Fields的定义**: $[L_n, \phi(z,\bar{z})] = z^{n+1}\partial\phi + \Delta(n+1)z^n\phi$（共形维数$\Delta = h + \bar{h}$，自旋$s = h - \bar{h}$）
- **关联函数的约束**: 共形不变性固定了两点、三点函数的形式
  $$\langle \phi_i(z_1)\phi_j(z_2)\rangle = \frac{\delta_{ij}}{|z_1-z_2|^{2\Delta_i}}$$
- **Radial Quantization**: 将复平面视为欧几里得时间-空间，原点为过去无穷远，无穷远为未来无穷远
  - **翻译**: 这等价于统计力学中的圆柱几何（Transfer Matrix演化）

**计算环节（30分钟）**:
- 验证Ising模型的两点函数在临界点确为幂律衰减 $\langle \sigma_i\sigma_j\rangle \sim |i-j|^{-\eta}$，并提取$\eta = 2\Delta_\sigma$

**课后实践（Zou Ch. 4.1.1）**:
- **数值实验**：使用ED（精确对角化）计算TFIM基态
- 计算能量密度$e_0(N)$，拟合Casimir能量$E_0 = \epsilon_0 L - \frac{\pi c}{6L}$，提取中心荷$c$的数值估计（目标：$c \approx 0.5$）
- 计算$N=16-20$的TFIM两点关联函数
- 对数坐标下拟合幂律指数，提取$\eta = 2\Delta_\sigma$的数值估计
- 对比Ginsparg第5章预言的$\Delta_\sigma = 1/8$

**关键联系**: 
> "Radial quantization中的'真空'就是Transfer Matrix的最大本征值对应的基态。'态-算符对应'中的态$|\phi\rangle$就是通过在$t=0$插入算符$\phi(0)$作用于真空产生的。"

**统计力学翻译**:
> "$c$是普适类的重要标签。对于Ising模型，$c=1/2$可以通过计算基态能量的Casimir项$E_0 = \epsilon_0 L - \pi c/6L$来数值验证。"

---

### **Week 3: Virasoro代数与中心荷的物理意义**
**理论阅读**: Ginsparg Ch. 3.1, 3.3, 3.5 (Central charge, Mode expansions, Highest weight states pp.26-30, 36)  
**数值参考**: Zou Ch. 4.1.2 (Koo-Saleur lattice Virasoro generators)

**理论内容**:
- **中心荷$c$的起源**: Virasoro代数的中心扩张 $[L_m, L_n] = (m-n)L_{m+n} + \frac{c}{12}m(m^2-1)\delta_{m+n,0}$
- **物理诠释**: 
  - $c$是共形异常（Weyl anomaly），反映真空能量密度（Casimir效应）
  - $c$是"软模式"的计数：统计力学中$N$个自由度的格点模型，临界时退化为少数几个共形自由度
- **模式展开**: $T(z) = \sum z^{-n-2}L_n$，$L_n$作为Fourier模式
- **Highest Weight States**: 被所有$L_{n>0}$湮灭的态（初级态），$L_0$的本征值为共形维数


**关键联系（Zou Ch. 4.1.2）**:
> "Koo-Saleur的晶格Virasoro生成元：在格点模型中，$H_n = \frac{N}{2\pi v}\sum_j e^{inj2\pi/N} h_j$ 在 $N\to\infty$ 时趋于$L_n + \bar{L}_{-n}$"

**课后实践**:
- 实现格点$H_n$算符（Zou公式4.1）
- 在TFIM低能谱（第一激发态）上测试$H_1$和$H_2$的作用
- **观察关键现象**：某些态被$H_{1,2}$湮灭（Primary states candidates），某些态被提升（Descendants）

**Mini-project里程碑1**: 成功识别TFIM低能谱中的真空态和第一初级态（对应$\sigma$场）

---

### **Week 4: Kac行列式与幺正性 —— Minimal Models的数学**
**理论阅读**: Ginsparg Ch. 4.1-4.4 (Hilbert space, Kac determinant, Critical models pp.46-56)  
**数值参考**: Zou Ch. 4.2 (Conformal towers identification)

**理论内容**:
- **表示论问题**: Virasoro代数的张量表示（共形塔）何时出现零模（Null states）？
- **Kac公式**: 共形维数 $\Delta_{r,s} = \frac{(pr-qs)^2 - (p-q)^2}{4pq}$，其中$c = 1 - 6(p-q)^2/pq$
- **幺正性约束**: $c \geq 0$的离散序列 $c = 1 - 6/m(m+1)$ for $m=3,4,5,...$
- **物理意义**: Null states的存在意味着微分方程，完全确定关联函数

**统计物理对应**:
| m | c | CFT | 格点模型 |
|---|---|-----|---------|
| 3 | 1/2 | Ising | Transverse Field Ising |
| 4 | 7/10 | Tricritical Ising | Blume-Capel / O'Brien-Fendley |
| 5 | 4/5 | 3-state Potts | 3-state Potts |
| $\infty$ | 1 | Free boson | XXZ at $\Delta=1$ |

**课后实践（项目选择）**:
- **组1**: 研究Ising模型 ($m=3$，已掌握)
- **组2**: 研究Tricritical Ising ($m=4$，Zou thesis Ch. 6)
- 目标：从数值光谱中识别$\Delta_{r,s}$的排列模式
- 构建$(\Delta, s)$图，与Ginsparg Fig. 4.2 (m=3的共形网格)对比

**作业**: 画出Ising CFT ($m=3$)的共形塔结构至level 3（包含$\mathbf{1}, \sigma, \epsilon$的所有后代）

---

### **Week 5: Ising CFT的完整识别（理论高峰周）**
**理论阅读**: Ginsparg Ch. 5 (m=3与临界Ising模型 pp.58-69)  
**数值参考**: Zou Ch. 4.2.2 (Conformal data extraction for Ising)

**理论内容**:
- **m=3 Minimal Model**: 只有三个初级场
  - Identity $\mathbf{1}$ ($\Delta=0$)
  - Spin $\sigma$ ($\Delta=1/8$)
  - Energy $\epsilon$ ($\Delta=1/2$)
- **Fusion Rules**: $\sigma \times \sigma = \mathbf{1} + \epsilon$，$\epsilon \times \epsilon = \mathbf{1}$，$\sigma \times \epsilon = \sigma$
- **临界指数**: 从CFT预言 $\eta = 2\Delta_\sigma = 1/4$，$\nu = 1/(2-2\Delta_\epsilon) = 1$
- **四点函数**：利用共形块的分解和交叉对称性验证Ising代数


**统计力学翻译**:
> "Fusion rule $\sigma \times \sigma = \mathbf{1} + \epsilon$对应于Ising模型中两个自旋关联的短程展开：主导项是常数（identity），修正项是能量密度。"

**物理深度讨论**:
> "为什么Ising模型只有一个relevant operator ($\epsilon$) 和一个marginal operator？这与RG流的维度有关。"


**课后实践（Zou Ch. 5）**:
- **算符识别**: 确定格点算符$X_i \sim \sigma$，$Z_iZ_{i+1} \sim \epsilon$的精确对应
- 计算OPE系数$C_{\sigma\sigma\epsilon} = 1/2$的数值验证

**Mini-project里程碑2**: 提交Ising CFT的完整"数值识别报告"（包含$c$、3个$\Delta$值、共形塔图）

---

### **Week 6: 自由玻色子与费米子 —— CFT的建造模块**
**理论阅读**: Ginsparg Ch. 6-7.1 (Free bosons/fermions, Mode expansions, Twist fields pp.71-80)  
**数值参考**: Zou Ch. 6 (Free fermion techniques, APBC)

**理论内容**:
- **自由玻色子** ($c=1$): 能动量张量 $T = -:\partial\phi\partial\phi:$，紧致化半径$R$，初级场$V_\alpha = :e^{i\alpha\phi}:$ 的维数$\Delta = \alpha^2/2$
- **玻色化**: 费米子场$\psi$与玻色子$\phi$的等价（Jordan-Wigner在 continuum 极限）
- **自由费米子** ($c=1/2$): Majorana fermion作为Ising CFT的fermionic表示
  - 自旋场$\sigma$是twist field（旋量场的分支切割，改变边界条件的场，与拓扑缺陷相关）
  - 能量场$\epsilon = i:\psi\bar{\psi}:$

**格点对应**:
- XY模型/XXZ链在$\Delta=0$处的自由玻色子描述（Luttinger液体）
- **Jordan-Wigner变换的连续极限**：格点自旋$\to$费米子场

**课后实践**:
- 使用Zou的方法提取TCI模型 ($c=7/10$) 的共形数据
- 验证自由费米子理论的Virasoro特征标与格点能谱计数吻合
- 实现反周期边界条件（APBC）下的TFIM计算（Zou Ch. 6）
- 对比周期边界（Ramond sector）与反周期边界（Neveu-Schwarz sector）的能谱差异
- 观察NS sector中$\Delta_\sigma = 1/16$的缺失（与Ginsparg第7章的理论一致）

**讨论**: 
>   "为什么张量网络研究者关心费米子？因为Majorana零模是拓扑量子计算的基石，而Ising CFT描述了这些零模的普适行为。"
---

### **Week 7: 环面上的CFT与模不变性（拓扑序联系）**
**理论阅读**: Ginsparg Ch. 7.2-7.5 (Toroidal partition function, Modular group, Ising on torus pp.85-95)  
**数值参考**: Zou Ch. 5.2 (Entanglement and partition functions)

**理论内容**:
- **环面几何**: 周期边界条件 $(\sigma_1, \sigma_2) \sim (\sigma_1 + 2\pi, \sigma_2) \sim (\sigma_1 + 2\pi\tau, \sigma_2 + 2\pi\text{Im}\tau)$
- **配分函数**: $Z(\tau) = \text{Tr}(q^{L_0 - c/24}\bar{q}^{\bar{L}_0 - c/24})$，其中$q = e^{2\pi i\tau}$，
- **模群**: $PSL(2,\mathbb{Z})$ generated by $S: \tau \to -1/\tau$ and $T: \tau \to \tau + 1$，$S$变换（高能-低能对偶）与$T$变换（拓扑缠绕）
- **模不变性要求**: 物理CFT的配分函数必须在模变换下不变
- **Ising模型的特征标**：$\chi_0, \chi_{1/2}, \chi_{1/16}$及其在$S$变换下的行为

**量子多体联系（重点）**:
- **Entanglement entropy与Cardy公式**: 环面上的CFT计算Rényi熵等价于在复环面上插入twist operators，子系统$A$的纠缠熵$S_A \sim \frac{c}{3}\log \frac{L}{\pi}\sin(\frac{\pi\ell}{L})$
- **拓扑序联系**: Modular $S$矩阵编码了anyon的编织统计
  
**课后实践**:
- 计算具有周期性边界条件的Ising链的低能谱
- 构建配分函数的数值近似：$Z \approx \sum_n e^{-\beta E_n}$，验证其在$\tau \to -1/\tau$下的行为
- 提取$c$的数值（目标：$c \approx 0.5$），与Week 5的Casimir能量方法互验
- **高级任务**：计算Rényi熵$S_n$（$n=2,3$），验证与Ising CFT的twist field维数关系

---

### **Week 8: 仿射Kac-Moody代数与陪集构造**
**理论阅读**: Ginsparg Ch. 9.1-9.5 (Affine Kac-Moody algebras, Coset construction pp.136-152)  
**数值参考**: Zou Ch. 6.6-6.7 (Superconformal symmetry in OF model)

**理论内容**:
- **电流代数**: Kac-Moody代数 $\hat{g}_k$ 作为WZW模型的对称性
- **Sugawara构造**: 从电流模式$J_n^a$构建Virasoro生成元
  $$L_n = \frac{1}{2(k+g)}\sum_{m,a}:J_m^a J_{n-m}^a:$$
- **Coset构造**: $G/H$陪集理论给出新的CFT（如$SU(2)_k/SU(2)_{k-1}$给出Minimal Models）
- **超对称性**：$N=1$超共形代数作为Coset的例子
- **物理应用**: Wess-Zumino-Witten模型描述拓扑绝缘体边缘态

**拓扑序联系**:
> "Kac-Moody当前代数描述了gapped topological order的gapless edge excitations（如FQHE的边缘）。"

**课后实践**:
- 识别Zou论文中研究的有超对称性的O'Brien-Fendley模型作为Coset理论的格点实现
- 计算当前算符$J_n$在格点模型中的矩阵元（比Virasoro生成元更基础）
- 研究OF模型在三临界点 ($c=7/10$) 的能谱
- 识别超Virasoro生成元（Zou Ch. 6.6）
- 观察超对称性对能级简并度的影响（相邻能级成对出现）

**讨论**: 
> "Coset构造是现代CFT分类的基石，也是理解拓扑序边缘态（如FQHE）的语言。Ginsparg第9章看似抽象，实则是连接拓扑序与CFT的桥梁。"


---

### **Week 9: 缺陷、边界与高级主题**
**理论阅读**: Ginsparg Ch. 10选段（Boundary CFT），补充Cardy (1989) boundary conditions paper  
**数值参考**: Zou Ch. 6.1-6.2 (APBC and boundary states)


**理论内容（选择2-3个主题）**:
- **共形缺陷（Conformal Defects）**: 缺陷线处的能量动量张量连续性
- **边界CFT**: 
  - Cardy条件：边界态$|B\rangle$满足$(L_n - \bar{L}_{-n})|B\rangle = 0$
  - Affleck-Ludwig边界熵：$g = \langle 0|B\rangle$ 
- **Disorder operators**: Kramers-Wannier对偶性作为$\mathbb{Z}_2$对称性的defect

**数值项目展示准备**:
- 各组整理数据：能谱图、Virasoro tower识别、OPE系数收敛性分析、RG流可视化

---

### **Week 10: 项目展示与现代应用**
**阅读**: 无新内容，讨论前沿论文

**理论总结（30分钟）**:
- Bootstrap方法回顾：共形对称性+Unicity → 确定CFT数据
- 从CFT到TQFT：RG流与Topological phase的关系（$c$定理与entanglement）

**项目展示（90分钟）**:
每组20分钟展示+10分钟问答：

1. **Ising CFT的完整数值重构**（基于Zou Ch. 4-5）
   - 展示能谱的共形塔结构
   - 展示OPE系数$C_{\sigma\sigma\epsilon}$的收敛性

2. **RG流的谱研究**（基于Zou Ch. 4.3，O'Brien-Fendley模型）
   - 展示从TCI (UV) 到 Ising (IR) 的crossover
   - 能级 avoided crossing的物理诠释

3. **反周期边界与超对称性**（Zou Ch. 6）
   - 展示APBC下Ramond sector的谱
   - 验证超Virasoro代数关系

4. **边界CFT与纠缠熵**（可选）
   - 开边界链的边界熵计算
   - 边界初级场的识别

**讨论（30分钟）**:
- 如何将所学应用于你们的研究方向（拓扑序分类、张量网络算法优化）
- 推荐阅读：贞义与后续发展（TFT, 3D CFT等）

---

## 关键技术工具链

### 1. 软件环境（建议）
| 工具 | 用途 | 学习资源 |
|------|------|---------|
| **Julia + TensorKit.jl** | 张量网络与MPS | https://github.com/Jutho/TensorKit.jl |
| **TeNPy (Python)** | 成熟的DMRG/时间演化 | https://tenpy.github.io/ |
| **Quimb (Python)** | 灵活的张量网络操作 | https://quimb.readthedocs.io/ |

### 2. 关键公式速查

**Koo-Saleur 格点Virasoro生成元**:
$$H_n = \frac{N}{2\pi v}\sum_{j=1}^N h_j e^{inj2\pi/N}, \quad v = \frac{NS}{2\pi}$$
其中$S$是基态能隙的线性外推，$h_j$是局域哈密顿量密度。

**中心荷提取**:
$$E_0(N) = \epsilon_0 N - \frac{\pi c}{6N} + O(N^{-3})$$

**初级场识别条件**:
$$H_1|\Delta\rangle = H_2|\Delta\rangle = 0$$

---

## 无QFT背景者的支持材料

**微讲座计划（穿插在前6周）**:

| 周次 | 主题 | 统计力学翻译 |
|------|------|-------------|
| 2 | Radial Quantization | Transfer Matrix的时间演化，圆柱几何的配分函数 |
| 3 | Normal Ordering | Wick定理相对于真空 expectation value |
| 4 | Virasoro代数 | 无穷小尺度变换的生成元，与RG方程的关系 |
| 5 | Fusion Rules | OPE的代数结构类比于算符乘积的短程展开 |
| 6 | Twist Fields | Jordan-Wigner弦的非局域性与任何子统计 |


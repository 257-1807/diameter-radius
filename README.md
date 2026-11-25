# 图的直径、半径与最优指数底数

给定至少两个顶点的有限连通无向简单图，记直径为 $D$、半径为 $r$。Duhamel–Cazenave 猜想语料中的第 790683 和 956425 号不等式均成立。更精确地，对所有这样的图，形如 $D\le b^{\sqrt r}$ 的上界所允许的最小非负实数底数恰为 $\sqrt8=2\sqrt2$。

图论输入是经典不等式 $D\le 2r$。本项目证明剩余的整数不等式，并用九个顶点的路径证明底数最优。两条语料原式、最优性和取等实例均经 Lean 4.36.0 内核核验。[逐条公理输出](audit/axioms.log) · [严格构建日志](audit/build.log)

## 问题出处与逐字引述

Élie Duhamel 与 Tristan Cazenave 在 *Spectral Graph Theory Conjecture Generation*（AAAI 2026 Workshop AI for Research）中介绍了生成方法。Tristan Cazenave 在 *Lemmas and Conjectures in Spectral Graph Theory*（2026，arXiv:2611.03879v1）第 1 节规定图的范围，第 8 节给出逐题状态档案。下面两个编号取自附件 `index_conjectures.csv` 的 `id` 列。正文第 7 节另列七条精选猜想。[生成论文](https://www.lamsade.dauphine.fr/~cazenave/papers/SpectralGraphTheoryConjectureGeneration.pdf) · [arXiv 原文](https://arxiv.org/abs/2611.03879v1) · [第 8 节与作者附件](https://arxiv.org/html/2611.03879v1#S8)

| 编号 | `enonce` 列逐字引述 | 作者档案状态 | 本项目定理 |
|---|---|---|---|
| 790683 | `diam ≤ ((1 + 2) ^ sqrt(rad))` | `ouverte`，Lean 栏 `non` | `RadiusBound.conjecture_790683` |
| 956425 | `diam ≤ ((2 * sqrt(2)) ^ sqrt(rad))` | `ouverte`，Lean 栏 `non` | `RadiusBound.conjecture_956425` |

较小的底数已经出现在第 956425 号。这里对这两个既有问题给出证明，并回答指数 $\sqrt r$ 固定时底数还能否再小。两个编号还可在原始生成语料的 `open.txt` 独立定位。[两行原始 CSV](audit/source-rows.csv) · [生成语料](https://www.lamsade.dauphine.fr/~cazenave/papers/Conjectures.zip) · [带证明状态的作者档案](https://www.lamsade.dauphine.fr/~cazenave/papers/preuves_spectrales.zip)

## 证明

对每个顶点 $v$，它的离心率是 $e(v)=\max_w d(v,w)$，其中 $d$ 按最短路上的边计数。于是 $D=\max_v e(v)$，$r=\min_v e(v)$。取离心率为 $r$ 的中心 $c$。任意两点 $u,v$ 都满足

$$
d(u,v)\le d(u,c)+d(c,v)\le 2r.
$$

**整数半径的估计。** 令 $B=\sqrt8$。要证 $2r\le B^{\sqrt r}$。当 $r\ge4$ 时，置 $t=\sqrt r/2\ge1$。用自然对数的标准不等式 $\log t\le t-1$。又有 $\log 8>2$，例如由 $\log 2=2\int_0^{1/3}(1-s^2)^{-1}\,ds>2/3$ 即得。因此

$$
\log(2r)=\log8+2\log t
\le \log8+2(t-1)
\le t\log8=\sqrt r\log B.
$$

取指数即得所需不等式。剩余的正整数半径可精确比较。

| $r$ | 验证 |
|---:|---|
| 1 | $2<\sqrt8$。 |
| 2 | $\sqrt2>4/3$，故 $B^{\sqrt2}>B^{4/3}=4$。 |
| 3 | $\sqrt3>19/11$。整数比较 $3^{22}=31\,381\,059\,609<34\,359\,738\,368=2^{35}$ 给出 $6^{22}<8^{19}$，于是 $6<B^{19/11}<B^{\sqrt3}$。 |

综上，$D\le2r\le(2\sqrt2)^{\sqrt r}\le3^{\sqrt r}$，同时得到两条原式。所有对数的真数均为正。原题假设 $n\ge2$ 使半径至少为一，Lean 中的标量引理还单独验证了 $r=0$。

**为什么底数最优。** 在路径 $P_9$ 上，把九个顶点依次标为 $0,\ldots,8$。中点 $4$ 到每个顶点至多走四步，所以 $r\le4$。每条边仅使标号改变一，两个端点间至少要走八步，所以 $D\ge8$。结合 $D\le2r$ 可知 $D=8$、$r=4$。任何对全部图有效的非负底数 $b$ 都要满足 $8\le b^{\sqrt4}=b^2$，因此 $b\ge\sqrt8$。这也给出了加强式实际取等的连通图。[路径与最优性的 Lean 证明](RadiusBound/Path.lean)

## 忠实性对照

| 原始定义或条件 | Lean 4 对应 | 核对要点 |
|---|---|---|
| 任意有限图，顶点数 $n\ge2$ | `{n : ℕ} (hn : 2 ≤ n)` 与 `Fin n` | 量化所有允许的阶数。任意 $n$ 元顶点集均可重编号为 `Fin n`。 |
| 简单、无向、连通 | `(G : SimpleGraph (Fin n)) (hc : G.Connected)` | 无自环、无重边与邻接对称由 `SimpleGraph` 提供；连通性是源文假设。 |
| 最短路距离、离心率和直径 | `G.edist`、`G.eccent`、`G.diam` | 距离计边。直径是最大离心率。有限连通图中所有距离有限。 |
| 半径是最小离心率 | `G.radius.toNat` | Mathlib 的 `G.radius` 取值于扩展自然数。证明用 `G.radius_ne_top_iff.mpr hc` 排除无穷，转换保持原值。 |
| `sqrt` 和 `^` | `Real.sqrt` 与实数上的 `Real.rpow` | 半径先转为实数再开方，指数保留实数值。 |
| 两个完整右式 | `(1 + 2 : ℝ) ^ Real.sqrt …` 与 `(2 * Real.sqrt 2) ^ Real.sqrt …` | 两个定理分别保留相应原始底数。图的量化、连通性和指数均相同。 |
| 附加结论：最小非负底数 | `sharp_bound`、`base_lower_bound` 与 `path_nine_invariants` | 同时证明该底数可用，以及每个对全部图有效的非负实数底数都不小于它。 |

正式声明见 [图论主定理](RadiusBound/Graph.lean) 和 [标量引理](RadiusBound/Scalar.lean)。Mathlib 中已存在的结果 `SimpleGraph.ediam_le_two_mul_radius` 负责三角不等式这一步。[固定版本的 Mathlib 源码](https://github.com/leanprover-community/mathlib4/blob/fc4f59e577feb1a4956671bc04ac18aaaf8cd842/Mathlib/Combinatorics/SimpleGraph/Diam.lean#L399)

## 查重与候选取舍

核查日期为 **2026-11-25**。作者的两份档案均能定位这两个编号。逐份搜索状态档案所附的 3,673 个 Lean 文件，未找到这两个定理名。检索覆盖 arXiv、可追踪的前向引文、MathOverflow、GitHub 公开仓库与议题、Lean Zulip 公开频道、固定版本及当日上游的 Mathlib。关键词包括 `790683`、`g956425`、`2611.03879`、`graph diameter radius optimal base` 及两条公式的原始写法。检出的相关证明涉及其他条目；已证的底数 $4$ 也比这里的两个底数大。[逐平台检索词、链接、结果与源码快照](audit/search.md)

Google Scholar 返回异常流量验证页，GitHub 全站代码搜索 API 对匿名请求返回 HTTP 401。公开记录支持“两条在作者档案中标为开放，在已核查来源中未发现此前的完整解答”。全球发表优先权仍未确认。

| 候选与原始出处 | 可攻克性与形式化可行性 | 处理 |
|---|---|---|
| B. Benfield、O. Lippard，*Integers that are not the sum of positive powers*，2024（v2，2025），arXiv:2404.08193，猜想 10.4 | 断言永久例外偏移的最大值与个数总为奇数。整数运算易形式化，精确证书有望判断奇偶。 | 查到对所有指数的公开证明后排除。[原题](https://arxiv.org/html/2404.08193v2#S10.SS1) · [已有证明](https://itsdavis.com/solved-conjectures/results/benfield-lippard-waring-gap-parity/proof/) |
| T. Cazenave，*Lemmas and Conjectures in Spectral Graph Theory*，2026，arXiv:2611.03879，§7 猜想 5（#239534） | 断言第二大拉普拉斯特征值加实邻接矩阵秩至多为边数的两倍。谱定义明确，但形式化成本高于距离不等式。 | 查到完整 Lean 结果后排除。[原题](https://arxiv.org/html/2611.03879v1#S7) · [已有证明与源码定位](https://www.trureturing.org/research/op-cazenave2611c5/) |
| H. Manabe，*Purely Periodic Three-move Subtraction Games*，2026，arXiv:2609.05358，§6 猜想 54 | 对满足 $2\le a<b<c$、$\gcd(a,b,c)=1$、$c\ne a+b$ 的三步减法游戏，若 Grundy 序列纯周期，最小周期是否属于 $\{a+b,a+c,b+c\}$？递推易编码，所有参数下的周期结构难以穷尽。 | 留作候选，未对其作解答或当日开放状态断言。[原题](https://arxiv.org/html/2609.05358v1#S6) |
| M. Przybylska、W. Szumiński、A. J. Maciejewski，*Destructive relativity*，2023，arXiv:2307.10070，§VI 式 (51) 后的无编号猜想 | 要求分类限制在 $J_+(k)\cup J_-(k)$ 中、满足倒数和为 $-1$ 的整数元组。单个有理解可精确核验，全称证明需控制无界 Pell 参数。 | 有限搜索仅回收到原文 $k=10$ 的解，无法推出唯一性，放弃该路线。[原文第 13 页](https://arxiv.org/pdf/2307.10070#page=13) |
| Duhamel–Cazenave 图论语料 #790683，Cazenave 2026，arXiv:2611.03879，§8 附件 | 原式只有图的直径和半径。Mathlib 已有两者的经典关系，余下的整数半径估计可单独证明。 | 选为主目标，等价式查重同时定位到同族的第 956425 号，两题一并验证。[原始数据行](audit/source-rows.csv) |

## 复现

安装 Elan 后，在项目根目录运行以下命令。工具链由 `lean-toolchain` 固定，Mathlib v4.36.0 及传递依赖的 Git 提交由 `lake-manifest.json` 固定。首次执行需要网络取得依赖。Python 脚本只用标准库。[Elan 安装说明](https://github.com/leanprover/elan)

```sh
lake exe cache get Mathlib.Combinatorics.SimpleGraph.Diam Mathlib.Combinatorics.SimpleGraph.Hasse Mathlib.Analysis.SpecialFunctions.Pow.Real Mathlib.Analysis.Complex.ExponentialBounds Mathlib.Tactic
lake build
lake --wfail build
lake env lean -DwarningAsError=true RadiusBound.lean
lake env leanchecker --verbose RadiusBound.Scalar
lake env leanchecker --verbose RadiusBound.Graph
lake env leanchecker --verbose RadiusBound.Path
python3 scripts/check_examples.py
```

已从无本项目构建产物的状态运行严格构建，公理清单由根模块末尾的 `#print axioms` 生成。主定理的实际输出如下。

```text
'RadiusBound.conjecture_956425' depends on axioms: [propext, Classical.choice, Quot.sound]
'RadiusBound.conjecture_790683' depends on axioms: [propext, Classical.choice, Quot.sound]
```

本项目的 Lean 源码没有 `sorry`、`admit` 或自定义公理。`leanchecker` 逐个重放三个含证明的模块。[公理日志](audit/axioms.log) · [构建日志](audit/build.log) · [内核重放日志](audit/kernel-replay.log)

独立 Python 程序用广度优先搜索枚举 2 至 6 个顶点的全部 **27,475** 张带标号连通简单图，另检查 2 至 65 个顶点的路径。开方使用整数平方根给出有理下界，再用整数幂比较，避免浮点舍入掩盖反例。全参数结论由上述 Lean 定理给出。[实验程序](scripts/check_examples.py) · [实验原始输出](audit/examples.log)

项目原创代码、证明与说明采用 Apache-2.0 许可证。原论文和数据摘录保留各自出处。[许可证](LICENSE)

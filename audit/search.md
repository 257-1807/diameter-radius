# 原始语料与公开查重记录

核查日期为 2026 年 11 月 25 日。检索对象是 Duhamel–Cazenave 语料 #790683，对所有至少两个顶点的连通有限无向简单图，有 $D\le 3^{\sqrt{r}}$。$D$ 和 $r$ 分别采用最短路径直径和半径。原作者在 2026 年 11 月 2 日预印本第 8 节链接了这份公开语料。[原论文与附件说明](https://arxiv.org/html/2611.03879v1#S8)

## 原始数据与既有数学

在下载的作者附件中，`preuves_spectrales/index_conjectures.csv` 共 305,755 条。#790683 的原文为 `diam ≤ ((1 + 2) ^ sqrt(rad))`，状态 `ouverte`，Lean 核验列 `non`，Lean 文件和定理名均为空。压缩包的 SHA-256 为 `aa113f4a64c0a05260e381987de19c8ad7d66f8c372639f2543f1dd08c6ed500`。[作者发布的 ZIP](https://www.lamsade.dauphine.fr/~cazenave/papers/preuves_spectrales.zip)

在同一档案的所有 3,673 个 Lean 源文件中搜索 `g790683`，返回零处。对全部 CSV 行检索同一右侧子式，发现 #1853598、#1853600、#2082672 已证明，但右侧分别是 $2\cdot3^{\sqrt r}$、$2^{3^{\sqrt r}}$ 和 $(3^{\sqrt r})^2$。#1809906、#1853596 的右侧分别额外加一、加二。对左侧为直径、右侧仅含半径和基础算术、平方根或对数的 3,807 条记录，额外比较 $r=1,2,3,4,7,15$ 的右侧数值，只有 #790683 同时匹配。此筛法用于查找可能的改写，无法覆盖涉及其他图不变量或不同左侧的所有逻辑等价式。[作者附件](https://www.lamsade.dauphine.fr/~cazenave/papers/preuves_spectrales.zip)

经典事实 $D\le2r$ 在档案中已作为 #759982 证明。Mathlib 也已有 `SimpleGraph.ediam_le_two_mul_radius`。因此这里的实质性额外步骤是标量比较 $2r\le3^{\sqrt r}$，从而封闭这条自动生成的开放记录。将结果描述为首个直径–半径上界或优于 $2r$ 会误报其数学意义。[固定版本的 Mathlib 源码](https://github.com/leanprover-community/mathlib4/blob/fc4f59e577feb1a4956671bc04ac18aaaf8cd842/Mathlib/Combinatorics/SimpleGraph/Diam.lean#L399)

## 学术出版物与引用

| 平台 | 实际检索词或接口 | 核查结果 |
|---|---|---|
| arXiv | `all:"790683" AND "Cazenave"`，完整论文标题 | 编号检索返回 0 条，标题精确检索返回原论文。arXiv 的元数据检索无法穷尽 PDF、补充数据和源码。[编号检索](https://export.arxiv.org/api/query?search_query=all:%22790683%22%20AND%20all:%22Cazenave%22) · [标题检索](https://export.arxiv.org/api/query?search_query=all:%22Lemmas%20and%20Conjectures%20in%20Spectral%20Graph%20Theory%22) |
| Google Scholar | `"790683" "Cazenave"`，完整题名，`"diameter" "radius" "790683"` | 直接请求返回 Google 的 `Verifying...` 页面，未能读取结果数或引用列表。[编号检索](https://scholar.google.com/scholar?q=%22790683%22+%22Cazenave%22) · [题名检索](https://scholar.google.com/scholar?q=%22Lemmas+and+Conjectures+in+Spectral+Graph+Theory%22) |
| OpenAlex / Semantic Scholar | 由论文 DOI 与 arXiv 编号查前向引用 | OpenAlex 的记录 W7225245562 显示 0 个已收录引用，Semantic Scholar 的引用接口返回空数组。网页检索实际找到了引用原文的后续作品，这两个查询反映索引的覆盖范围。[OpenAlex 记录](https://api.openalex.org/works/W7225245562) · [Semantic Scholar 引用接口](https://api.semanticscholar.org/graph/v1/paper/arXiv:2611.03879/citations?fields=title,url,year) |
| 网页全文和引文追踪 | `"2611.03879" "790683"`，`"790683" "Cazenave" diameter radius`，`"diam" "sqrt(rad)" "790683"`，`graph diameter at most three to the square root of radius`，标量形式 `3^sqrt(x) 2x`、`3^x 2x^2` | 未定位到完整目标式的既刊证明。Alexander M. Kramer 的后续预印本明确处理第 6(ii) 个猜想。trureturing 已公开第 4、5 个猜想的解答。Duhamel 和 Cazenave 的前序论文说明生成方法。[Kramer 原文](https://hexagonmath.org/pdf/2611.00232v1) · [猜想 4](https://www.trureturing.org/research/op-cazenave2611c4/) · [猜想 5](https://www.trureturing.org/research/op-cazenave2611c5/) · [原语料作者的论文](https://www.lamsade.dauphine.fr/~cazenave/papers/SpectralGraphTheoryConjectureGeneration.pdf) |

## 形式化社区与 MathOverflow

| 平台 | 实际检索词与结果 |
|---|---|
| GitHub 议题与拉取请求 | `"g790683"` 零条。 `"790683" "Cazenave"` 两条，均为项目自身的 PR 序号恰好等于 790683。 `"2611.03879"` 两条，分别指向 Cazenave 正文猜想 4 和 5。[定理名检索](https://api.github.com/search/issues?q=%22g790683%22) · [论文检索](https://api.github.com/search/issues?q=%222611.03879%22) |
| GitHub 仓库 | `"790683" "Cazenave" in:readme` 零条。 `"2611.03879" in:readme` 返回两个仓库。两仓当前默认分支的工作树中均未检出编号 790683。broken-conjectures 涵盖 #20829 及其他七个编号。gap-is-one 处理第 2 个猜想和相关行，附有数值扫描。GitHub 全站源码搜索 API 对匿名请求返回 HTTP 401，补充使用的 grep.app 搜索返回 HTTP 429。[仓库检索](https://api.github.com/search/repositories?q=%222611.03879%22+in%3Areadme) · [broken-conjectures 核查快照](https://github.com/AmirMakir/broken-conjectures/tree/dda3f0d1ee5f9cc1f7cafb11f93127b4871c7543) · [gap-is-one 核查快照](https://github.com/Sulayman22S/gap-is-one/tree/450c20c5201c05e447278fd36d4478996507fb46) |
| Lean Zulip | 通过公开网页客户端的 `/json/messages`，在 `channels:web-public` 下全文查 `g790683`、`790683`、`2611.03879`，均为零条。`"Cazenave"` 仅命中与色散方程有关的一个话题。服务器各次皆返回 `history_limited=false` 及 `found_oldest=true`。此范围仅覆盖网上公开的频道。[公开频道检索](https://leanprover.zulipchat.com/#narrow/channels/web-public/search/g790683) · [可复现的 JSON 查询](https://leanprover.zulipchat.com/json/messages?anchor=newest&num_before=30&num_after=0&narrow=%5B%7B%22operator%22%3A%22channels%22%2C%22operand%22%3A%22web-public%22%7D%2C%7B%22operator%22%3A%22search%22%2C%22operand%22%3A%22g790683%22%7D%5D) |
| MathOverflow | Stack Exchange API `search/advanced` 指定 `site=mathoverflow`，对 `g790683`、`790683 Cazenave`、完整论文标题及 `"Cazenave" "diameter"` 各返回零个问题。补做站点索引检索以寻找回复正文。[MathOverflow 检索](https://api.stackexchange.com/2.3/search/advanced?site=mathoverflow&q=790683%20Cazenave) |
| Mathlib | 在提交 `fc4f59e577feb1a4956671bc04ac18aaaf8cd842` 的 `Mathlib` 和参考文献目录中检索 `790683`、`2611.03879`、`sqrt.{0,15}radius`、`diam.{0,65}(rpow\|sqrt.{0,12}radius)` 及 `two_mul_radius`。找到了上述经典图界，未发现完整的指数上界。[Mathlib 源码树](https://github.com/leanprover-community/mathlib4/tree/fc4f59e577feb1a4956671bc04ac18aaaf8cd842) |

在所核验的作者附件、公开文献与代码中，尚未定位到 #790683 或相同直径指数上界的完整证明。此记录支持“该条目在引用语料中标为开放，检索未见此前直接解决”的表述。未索引作品、未开放频道以及使用不同术语的证明仍可能存在。

## 同一语料的锐化 #956425

第二条完整原句为 `diam ≤ ((2 * sqrt(2)) ^ sqrt(rad))`。#956425 也标为 `ouverte`、`verifiee_lean=non`，Lean 文件与定理栏均为空。两条不等式都是作者公开提出的猜想。前述 3,673 个 Lean 文件中同时检索 `g790683` 和 `g956425`，均无命中。对那 3,807 个单变量右式 $f(r)$ 逐一令 $b=f(1)$，筛取 $0<b\le3$ 并在 $r=2,3,4,7,15$ 与 $b^{\sqrt r}$ 比对。只有 #790683 和 #956425 入选，均未标为已证明。这是公式去重的数值筛选。[作者附件](https://www.lamsade.dauphine.fr/~cazenave/papers/preuves_spectrales.zip)

| 平台 | 补充检查 |
|---|---|
| arXiv 与学术网页 | arXiv 的 `all:"956425" AND "Cazenave"` 零条。另查 `("956425" OR "g956425") "Cazenave" diameter`、原式 `"((2 * sqrt(2)) ^ sqrt(rad))"` 和 `graph diameter radius "2√2" optimal base`，未找到说明该公式或相应最优底数的论文。[arXiv 检索](https://export.arxiv.org/api/query?search_query=all:%22956425%22%20AND%20all:%22Cazenave%22) |
| Google Scholar | `"956425" "Cazenave"` 和 `"diameter" "radius" "956425"` 均未返回可读取的结果。另用 Chrome 打开 #790683 的检索页，Google 明示当前网络触发异常访问检测并要求人工验证码。此渠道没有可用的阴性结果。[Google Scholar 检索](https://scholar.google.com/scholar?q=%22956425%22+%22Cazenave%22) |
| GitHub 与 MathOverflow | GitHub 议题与拉取请求的 `"956425" "Cazenave"`、`"g956425"`，仓库的 `"956425" "Cazenave" in:readme` 均为零条。对前述两个仓库的固定版本再搜 956425，均无匹配。GitHub 匿名全站源码搜索仍返回 HTTP 401。MathOverflow 对 `g956425`、`956425 Cazenave` 均为零条。[GitHub 议题](https://api.github.com/search/issues?q=%22g956425%22) · [GitHub 仓库](https://api.github.com/search/repositories?q=%22956425%22+%22Cazenave%22+in%3Areadme) · [MathOverflow](https://api.stackexchange.com/2.3/search/advanced?site=mathoverflow&q=956425%20Cazenave) |
| Lean Zulip | 所有 web-public 频道中分别查询 `956425` 与 `g956425` 得零条。两次的 `found_oldest` 均为 true，`history_limited` 均为 false。[公开频道检索](https://leanprover.zulipchat.com/#narrow/channels/web-public/search/g956425) |
| Mathlib | 除构建所用固定版本外，另下载核查当日上游 master 的快照 `69e1852ff6e20cfdc5c3505b8c45777cde5230de`。在 8,737 个 Mathlib Lean 源文件及参考文献文件中，查两编号、原论文 ID、`sqrt.{0,15}radius`、`radius.{0,15}sqrt` 与经典图界名。唯一命中是 `ediam_le_two_mul_radius`。[当日上游源码树](https://github.com/leanprover-community/mathlib4/tree/69e1852ff6e20cfdc5c3505b8c45777cde5230de/Mathlib) |

这两项搜索结果支持在同一证明中处理语料原题及其给出的锐化。底数 $2\sqrt2$ 的最优性是一项单独的数学断言，在已核查的文件中未见针对该指数族的明确证明。

GitHub 全站提交说明检索也查了 `"g790683"`、`"g956425"` 及两个编号各与 `"Cazenave"` 的组合，四组均为零条。`"2611.03879"` 返回一项对原语料已提交证明的复核，内容为归档与 Lean 定理编号核对。[提交检索](https://api.github.com/search/commits?q=%22g956425%22) · [语料复核记录](https://github.com/chokmah-me/fragile-proof-audit/commit/df141c54e7bbfd1a5aef813eeba63067620bd3a6)

## 两份作者档案的交叉核对

生成项目的原始压缩包在 `open.txt` 第 64,313 行和第 88,780 行分别列出这两个编号及其前缀表达式。它的 SHA-256 是 `1349f791447c58275cc5029736f354cab1336240449a56713b55dc115b217ada`。复核存档中整张 CSV 的 SHA-256 是 `0fe17238cd725ea6237bb24d18c6da48e9d17488b26d79c682ed8c8bcad46aec`。表头及两行原始记录已原样保存。[生成项目原包](https://www.lamsade.dauphine.fr/~cazenave/papers/Conjectures.zip) · [原行摘录](source-rows.csv)

另按标量问题检索 `"(2n)^(1/sqrt(n))" maximum`、`"log(2n)" "sqrt(n)" maximum n=4` 和 `"Cazenave" "radius" "diameter" "optimal base"`，未找到直接给出这两条结论或精确底数的结果。DataCite 对该 DOI 的引文计数也是零。Semantic Scholar 的一次引用请求得到空列表，另一次独立请求受到限流。检索可读结果中出现的后续论文说明这些引文列表尚不完整。[DataCite 记录](https://api.datacite.org/dois/10.48550/arxiv.2611.03879) · [已有引用原文的后续论文](https://hexagonmath.org/pdf/2611.00232v1)

补查 Open Problem Garden 的图论目录，以及 Erdős Problems 以 `diameter radius connected graph` 检索到的条目。后者的 #612 涉及最小度和禁团条件，与本项目的两条公式有不同的假设及结论。[Open Problem Garden 图论目录](https://www.openproblemgarden.org/category/graph_theory) · [Erdős #612](https://www.erdosproblems.com/612)

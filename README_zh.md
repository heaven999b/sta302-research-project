# STA302 研究项目（总仓库）

本仓库是多伦多大学 **STA302H1（2026 秋）** 期末项目的总仓库，记录三件事：

1. 选题是怎么做出来的；
2. 测过哪些候选、为什么被淘汰；
3. 三个已经完整做好的候选方案。

每个方案是一个独立仓库，以 git submodule 的形式放在 `projects/` 下。最终从三个方案里选一个提交。

> 三个方案的完整中文说明见 [docs/overview_zh.md](docs/overview_zh.md)，包括研究问题、数据、变量、清洗、Part 1、Part 2、IID、文献、局限和写作对照。

## 三个方案

| | 子仓库 | 数据 | 单位 / n | Y | X × G | Part 1 R² | 最终 R² | 核心发现 |
|---|---|---|---|---|---|---|---|---|
| 一 | [`soc-new-home-prices`](projects/soc-new-home-prices) | Census SOC 2025 | 新房 / 6,185 | 售价 | 面积 × 9 个地区 | 0.713 | 0.756（log–log） | 面积 +10%，中西部售价约 +5%，南部和沿海约 +7%；2024 年独立样本复现 |
| 二 | [`ntd-transit-ridership`](projects/ntd-transit-ridership) | FTA NTD 2024 | 公交机构 / 2,135 | log 客运量 | log 营运小时 × 服务类型 | 0.930（log–log） | 0.935 | 客运量对营运小时的弹性：固定线路 1.21（规模报酬递增），仅需求响应 0.90 |
| 三 | [`ipeds-faculty-salary`](projects/ipeds-faculty-salary) | NCES IPEDS 2023 | 四年制高校 / 1,070 | 教师平均薪酬 | log 生均捐赠 × 公立/私立 | 0.849 | 0.847（log Y） | 捐赠 ×10：私立薪酬约 +18.6%，公立约 +2.4%（不显著） |

**怎么选：**
- **方案一**：课程叙事最完整，Part 1 残差违反明显，Part 2 用 Box-Cox 修好；做过独立复现。
- **方案三**：效应最大，故事最好讲，IID 最干净。
- **方案二**：显著性最强，政策含义直接；但 Part 1 直接用了 log–log，分组变量也改过一次。

## 每个子仓库里有什么

| 路径 | 内容 |
|---|---|
| `Part1_Code.Rmd` | 课程要求提交的代码：从原始数据清洗 → 变量汇总 → 初步模型 → 完整残差分析（不修正） |
| `Part2_Analysis.Rmd` | Part 2 工作稿，只用训练集：变换、VIF、影响点、变量选择、最终模型、稳健与聚类 SE、混杂检查 |
| `proposal/` | 英文 Part 1 proposal（md/html/pdf）+ 逐段中文对照 |
| `design/research_design.md` | 中文研究设计全文 |
| `data/` | 原始数据、清洗后数据、固定的训练/测试划分 `split_ids.csv` |
| `verification/` | R 与 Python 数值核对 |
| `probe/` | 探索阶段的 Python 探针（只作溯源） |
| `docs/` | TODO、决策记录、变更记录 |

## 选题标准（全部满足才算合格）

1. **满足课程 Part 0/1 全部要求**：
   - 开源数据，≥ 1000 行；
   - ≥ 9 个预测变量，至少 1 个类别变量、1 个数值变量；
   - 有"类别 × 其他变量"的交互项；
   - 数据的收集方式查得到；
   - 有 3 篇同行评审文献。
2. **严格 IID 的横截面数据**：
   - 不能是时间序列或面板，一个单位一行；
   - 按自然聚类的残差 ICC < 0.05；
   - 交互项在聚类稳健 SE 下仍然显著；
   - 地理单位要查 Moran's I。
3. **结果有意义**：
   - 训练集 R² ≥ 0.50；
   - 关注变量的 ΔR² ≥ 0.02；
   - X 从 P10 到 P90 时，Y 的变化 ≥ 0.25 SD；
   - 交互项 p < 0.01，并且在 HC3 下仍然显著；
   - 通过混杂检查；
   - 没有机械关系。
4. **测试集纪律**：先按 70/30（seed 302）固定划分，所有探针只用训练集。

三组并行共测了约 29 个候选，3 个合格。搜索记录都在 [`docs/search/`](docs/search)：
- `candidate_registry.md`：候选登记表
- `group*_report.md`：各组报告
- `failures_*.md`：失败记录

## 目录

```
.
├── README.md / README_zh.md
├── docs/
│   ├── overview_zh.md                 三个方案的完整中文汇总
│   ├── course_requirements_summary.md 课程 Part 0/1 要求摘要（自己整理，不含课程原件）
│   ├── decisions.md                   跨项目决策（已定 / 待定）
│   ├── todo.md                        提交前待办
│   ├── changelog.md
│   └── search/                        选题搜索的全部记录
├── projects/                          三个子仓库（submodule）
└── scripts/publish_to_github.sh       一键创建 GitHub 仓库并挂上 submodule
```

## 复现

```bash
git clone --recurse-submodules https://github.com/heaven999b/sta302-research-project.git
```

用 RStudio 打开子仓库文件夹（R ≥ 4.3，需安装 `car`、`sandwich`、`lmtest`），先 knit `Part1_Code.Rmd`，再 knit `Part2_Analysis.Rmd`。

## 注意

- 所有数据都来自美国联邦政府，属于公有领域，不含个人信息。
- **课程讲义和 PDF 原件不放进仓库**，因为有版权。
- 测试集从未用于建模。各子仓库的测试集验证代码块都设为 `eval = FALSE`，只在 Part 2 最后运行一次。

> **历史记录**：这是 2026-09-30 选题搜索时的原始文件，照原样保存。文中路径是当时的本机路径；已淘汰候选的数据和脚本当时已按规则删除。

# 组3（产业/交通/公共/医疗/农业/泛经济）失败记录

## 候选 B：公共图书馆到馆人次 ~ log 运营支出 × 城乡类型（IMLS PLS FY2024）— 失败（2026-09-30）
- 数据源：https://www.imls.gov/research-evaluation/surveys/public-libraries-survey-pls （pls_fy2024_csv.zip，AE 文件）；n = 8,627（训练 6,039）
- Y = log(VISITS)；X = log(TOTOPEXP)（中心化）；G = NCES 城乡 4 类；9 个控制（log 服务人口、法律基础、联盟成员、分馆数、流动书车、地方财政占比、人次是否实数、地区、log 县人口）
- B1：R² 0.879 / adj 0.878，ΔR²(去 X 与 X×G) 0.089，交互 partial F p = 0.0005，HC3 p = 0.0016；弹性 City 0.72 vs Rural 0.81（差仅 0.09），P10→P90 效应 1.83–2.06 SD（组间差实质很小）
- 混杂检查失败：加 log_pop×X 后交互 p = 0.013（HC3 0.018）；加入全部替代交互后 p = 0.14。城乡差异基本是"规模 × 支出"的替身
- B2（G = 法律基础）：交互 partial F p = 0.087，直接不显著
- 其他问题：残差超额峰度 7.8、偏度 −0.97；县 ICC 0.083（>0.05），Moran's I 0.058（p = 0.005）
- 研究者自由度：试了 2 个设定（B1 城乡、B2 法律基础），均失败

## 候选 C：医院每调整出院成本 ~ log CMI × 所有制（HCRIS 2023 + IPPS FY2025 Impact File）— 失败（2026-09-30）
- 数据源：https://data.cms.gov/provider-compliance/cost-report/hospital-provider-cost-report （CostReport_2023_Final.csv）+ https://www.cms.gov/files/zip/fy-2025-ipps-fr-impact-file.zip ；n = 3,030（训练 2,121）
- Y = log(总成本 / 调整出院数)；X = log(转院调整 CMI, V42)；G = 所有制（非营利/营利/政府）；10 个控制（log 工资指数、教学强度 3 类、log 床位、占用率、DSH%、Medicare 天数%、城乡 3 类、9 大区、医院支付类型）
- R² 0.488 / adj 0.482（< 0.50）；ΔR²(X, X×G) 0.151；交互 partial F p = 0.003，但 HC3 p = 0.245；斜率 非营利 1.27、营利 1.14、政府 0.92（P10→P90：1.34 / 1.20 / 0.97 SD）
- 混杂检查：加教学×X、床位×X 等单项后 HC3 p 均 > 0.19；全部替代交互同时加入 partial F p = 0.53
- 残差偏度 2.37、超额峰度 22.7（HCRIS 总成本含附属单位，离群严重）；原始尺度 R² 仅 0.05、峰度 1816；Box-Cox λ = −0.2
- "营利医院 upcoding 使成本-CMI 斜率变平"的假设方向对但不显著；研究者自由度：1 个设定

## 候选 D：慈善机构捐赠收入 ~ log 筹款支出 × 类型（英格兰和威尔士 Charity Commission 登记册 Part A/B）— 失败（2026-09-30）
- 数据源：https://register-of-charities.charitycommission.gov.uk/register/full-register-download （publicextract.charity / annual_return_parta / partb / classification，2026-09-29 版）；n = 8,679（训练 6,075）
- Y = log(捐赠与遗赠收入)；X = log(筹款支出)；G 预设 = 宗教活动类(What 108)；10 个控制（log 雇员、log 志愿者、log 净资产、log 收费收入、log 经营收入、log 政府收入、年龄、法律形式、是否用职业筹款人、是否有经营子公司）
- 宗教 G：交互 −0.265（宗教类筹款弹性 0.08 vs 世俗 0.35），partial F p = 3e-20，HC3 p = 6e-20，加全部替代交互后 HC3 p = 2e-8，邮编区 ICC 0.018——交互本身很稳
- 但 R² 只有 0.28（adj 0.28），ΔR² 0.073；残差偏度 −1.16。唯一能把 R² 拉高的"总支出/总收入"是 Y 的预算恒等式对应项，属泄漏，不能用
- 共试 6 个 G（宗教、是否向公众募捐、资助型、海外援助、教育、法律形式），R² 全在 0.26–0.28；研究者自由度 6 个设定

## 候选 E：货运承运人年里程 ~ log 动力车辆数 × 营运类型（FMCSA Company Census File，里程年份 2024）— 失败（2026-09-30）
- 数据源：https://data.transportation.gov/d/az4n-8mr2 （Socrata API，status A，mcs150_mileage_year = 2024；2025 年份备作独立复现）；n = 227,801（训练 159,461）
- Y = log(MCS-150 年里程)；X = log(动力车辆数)；G = 纯 for-hire vs 纯 private property；16 个控制（州际、长途司机占比、牵引车占比、租赁车占比、每车司机数、危险品、组织形式、年龄、7 类货物、4 大区）
- T1（含"每车年里程 1,000–250,000"合理性过滤）：R² 0.512 / adj 0.512，ΔR² 0.286，交互 −0.058（private 弹性 0.94 vs for-hire 0.885），HC3 p = 2e-27，所有替代交互后仍显著，ICC ≤ 0.022，残差偏度 −0.45 / 峰度 0.56
- 失败原因：① 组间斜率差仅 0.06（P10→P90 效应 1.35 vs 1.27 SD，实质差异很小）；② 结果完全依赖基于 Y/X 的过滤——不做过滤时 R² 0.18、交互变号为 +0.35（自报里程约 20% 为明显录入错误），属于"过滤塑造关系"；③ R² 远低于 SOC 基准
- 研究者自由度：3 个设定（T1、无过滤、加 3 个运营控制）

## 候选 A：航空城市对平均票价 ~ log 距离 × 最大承运人类型（DOT Consumer Airfare Report Table 6，2026Q1）— 失败（协调者裁定，2026-09-30）
- 数据源：https://data.transportation.gov/d/yj5y-b2ir ；n = 5,916 个城市对（训练 4,141）；Y = log(平均票价)，X = log(直飞距离)，G = 最大承运人类型（Legacy AA/DL/UA/AS、Southwest、ULCC/其他 LCC）
- 推荐版（端点城市多成员固定效应 + 5 个市场层控制）：R² 0.831 / adj 0.823，ΔR²(X, X×G) 0.073；弹性 Legacy 0.172、WN 0.181、ULCC 0.351（P10→P90 418→1,997 英里：+31% / +33% / +73%，1.05 / 1.10 / 2.14 SD）；交互 partial F p = 4e-27，HC3 p = 4e-9；全部替代交互、剔除单个承运人、Box-Cox λ=0.4、原始美元尺度（HC3 p = 0.007）均稳健；2019Q1、2025Q1 同表复现通过（但城市对 >90% 重叠，非独立）
- 失败原因：城市对属于二元数据，结构上共享端点；不加 FE 时残差城市 ICC 0.19–0.23、二元相关 0.14、最大承运人 ICC 0.14–0.38；加 FE 后城市 ICC −0.03、二元相关 −0.015，但独立性是靠约 174 个城市固定效应在模型内吸收的，不是由设计保证，协调者判定不满足"严格 IID"。另：Part 1 原始尺度（无 FE）交互 p = 0.41
- 研究者自由度：9 个设定（A1 二分类 G → A2 三分类 G → A3 端点协变量 → A4/A5 城市 FE，各含原始尺度对照，另弃用 large_ms×G 构成性设定）

## 候选 G：安宁疗护机构护理投入 ~ log 服务天数 × 所有制（CMS PAC PUF Hospice FY2024 + Care Compare 所有制）— 失败（2026-09-30）
- 数据源：https://data.cms.gov/provider-summary-by-type-of-service/medicare-post-acute-care-utilization/hospice ；https://data.cms.gov/provider-data/dataset/yc9t-dgbk ；n = 1,487（训练 1,041；CMS 对小格抑制使协变量大量缺失，6,134 → 1,487）
- Y = log(总护理分钟)；X = log(服务天数)；G = 营利 vs 非营利/政府；11 个控制（常规居家天数占比、风险分、双重资格%、农村%、平均年龄、4 类主诊断%、认证年限、4 大区）
- R² 0.904（只放 X 时 0.880），ΔR²(X, X×G) 0.691；但交互 −/+ 0.018（非营利弹性 0.97 vs 营利 0.99），partial F p = 0.40、HC3 p = 0.47；加任何替代交互后仍 p > 0.16；州 ICC 0.061
- 失败原因：交互项不存在（"营利机构护理投入随规模增长更慢"的假设不成立），且样本因抑制值损失 70%
- 研究者自由度：1 个设定

## 候选 H：公立中小学教师配置 log 教师 FTE ~ log 在校生 × 全日制虚拟学校（NCES EDGE Public School Characteristics 2024-25）— 失败（未达方案一水平，2026-09-30）
- 数据源：https://data-nces.opendata.arcgis.com/datasets/nces::public-school-characteristics-current （ArcGIS FeatureServer 全量下载）；设计：每学区随机 1 校，n = 13,816（训练 9,671，其中虚拟校 183）
- Part 2（州 FE + 删除 84 所 |学生化残差|>4 的明显录入错误 + BIC 选变量）：R² 0.898 / adj 0.897，ΔR²(X, X×G) 0.634（只放 log 在校生 R² 0.82）；弹性 实体校 0.822 [0.815, 0.829] vs 虚拟校 0.955 [0.929, 0.982]，交互 +0.133，HC3 p = 2e-7，州聚类 p = 5e-6；全部替代交互 + X² 后 HC3 p = 6e-5；不删离群点 HC3 p = 5e-5；同年未抽中学校（不重叠，学区聚类）复现 +0.087，p = 0.0008
- 失败原因：① 原始尺度（FTE ~ 在校生）交互 p = 0.10、HC3 p = 0.93，两组边际配比同为每生 0.055 FTE，log 尺度的"弹性差"其实是实体校存在固定编制（截距）差异——可移除交互，不是稳健的斜率差；② 38%（463/1,223）的全日制虚拟校报告教师 FTE = 0（外包教师未上报），关键组存在选择性缺失；③ 加州 FE 后残差 Moran's I 仍为 0.05–0.06（p = 0.002）；④ Part 1 残差峰度 45（录入错误），州 ICC 0.108
- 研究者自由度：2 个设定（全部学校 / 一校一学区），另做 Box-Cox、不删离群点敏感性

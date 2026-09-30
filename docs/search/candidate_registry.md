> **历史记录**：这是 2026-09-30 选题搜索时的原始文件，照原样保存。文中路径是当时的本机路径；已淘汰候选的数据和脚本当时已按规则删除。

# 候选登记表（三组共用，防止重复）

规则：开始实测某个候选之前，先读本文件；若同一数据集或同一研究问题已被其他组登记，就换一个。确认没有重复后，用 `>>` 追加一行登记，不要改动别人的行。

| 组 | 候选名 | 数据源（网址） | 分析单位 | 状态（实测中/成功/失败） |
|---|---|---|---|---|
| 组1 | SOC 新建独栋住宅售价：面积 × Census division（Census Survey of Construction 2025 微观数据） | https://www.census.gov/construction/chars/microdata.html | 新建住宅（每套 1 行） | 实测中 |
| 组1 | LFS 时薪：工龄 × 工会（加拿大 Labour Force Survey PUMF 2026-08） | https://www150.statcan.gc.ca/n1/pub/71m0001x/71m0001x2021001-eng.htm | 雇员（个人） | 实测中 |
| 组1 | SEC XBRL 公司估值：log 公众流通市值 ~ ROA × 亏损（FY2024 财报 + 2025-06 public float，frames API） | https://data.sec.gov/api/xbrl/frames/ | 上市公司（每 CIK 1 行） | 实测中 |
| 组1 | EIA-861 电力公司居民电价：规模 × 所有制（2024 年终版） | https://www.eia.gov/electricity/data/eia861/ | 电力公司×州 | 实测中 |
| 组1 | LFS 时薪：工龄 × 工会 | https://www150.statcan.gc.ca/n1/pub/71m0001x/71m0001x2021001-eng.htm | 雇员（个人） | 失败（R² 0.42，交互 p=0.02，被 工会×年龄 解释） |
| 组2 | SEC Form ADV 投资顾问公司规模：log(RAUM) ~ log(投顾雇员数) × 是否管理私募基金（2026-09 注册投顾快照） | https://www.sec.gov/data-research/sec-markets-data/information-about-registered-investment-advisers-exempt-reporting-advisers | 注册投资顾问公司（每 CRD 1 行） | 实测中 |
| 组3 | 航空城市对平均票价：log 距离 × 最大承运人是否低成本航空（DOT Consumer Airfare Report Table 6，单季度截面） | https://data.transportation.gov/d/yj5y-b2ir | 城市对市场（每对 1 行） | 实测中 |
| 组3 | 公共图书馆产出：log 到馆人次 ~ log 运营支出 × 城乡类型（IMLS Public Libraries Survey FY2024 AE 文件） | https://www.imls.gov/research-evaluation/surveys/public-libraries-survey-pls | 图书馆行政实体（每 FSCSKEY 1 行） | 实测中 |
| 组1 | EIA-861 居民电价：规模 × 所有制 | https://www.eia.gov/electricity/data/eia861/ | 电力公司 | 失败（R² 靠州固定效应，ΔR²=0.020，交互被 所有制×密度 削弱至 HC3 p=0.09） |
| 组1 | 费城住宅成交价：居住面积 × 外观状况评级（Philadelphia OPA properties，2025 年单户成交） | https://opendataphilly.org/datasets/philadelphia-properties-and-assessment-history/ （Carto SQL API: https://phl.carto.com/api/v2/sql） | 房产（每 parcel 1 行） | 实测中 |
| 组1 | 费城住宅成交价：面积 × 外观状况 | https://phl.carto.com/api/v2/sql | 房产 | 失败（R² 0.27，Moran's I 0.09–0.13，交互被 面积×邮编 等解释） |
| 组1 | CBECS 商业建筑年电费：建筑面积 × 主要用途（EIA CBECS 2018 公开微观数据） | https://www.eia.gov/consumption/commercial/data/2018/index.php?view=microdata | 商业建筑（每栋 1 行） | 实测中 |
| 组3 | 公共图书馆产出：log 到馆人次 ~ log 运营支出 × 城乡类型（IMLS PLS FY2024） | https://www.imls.gov/research-evaluation/surveys/public-libraries-survey-pls | 图书馆行政实体 | 失败（R² 0.88，但交互在加 log人口×X 后 p=0.013、全替代交互 p=0.14；组间弹性差仅 0.09） |
| 组2 | DOL Form 5500 员工福利计划审计费：log(IQPA 审计费) ~ log(计划资产) × 是否 ERISA 103(a)(3)(C) 有限范围审计（2024 计划年 Schedule H） | https://www.dol.gov/agencies/ebsa/about-ebsa/our-activities/public-disclosure/foia/form-5500-datasets | 员工福利计划（每发起人 EIN 1 行） | 实测中 |
| 组2 | DOL Form 5500 审计费：log 资产 × 有限范围审计 | https://www.dol.gov/agencies/ebsa/about-ebsa/our-activities/public-disclosure/foia/form-5500-datasets | 员工福利计划 | 失败（R² 0.30；交互 p=7e-8 但 R² 不达标，审计师 ICC 0.089） |
| 组1 | SEC XBRL 公司估值：ROA × 亏损 | https://data.sec.gov/api/xbrl/frames/ | 上市公司 | 失败（log R² 0.72 但几乎全来自规模，ΔR²=0.008，效应 0.21 SD） |
| 组1 | SOC 新建独栋住宅售价：面积 × Census division | https://www.census.gov/construction/chars/microdata.html | 新建住宅 | 成功（R² 0.71，交互 p=1e-57，HC3 p=8e-24） |
| 组2 | SCF 2022 家庭财富：log 净资产/资产 ~ log 收入 × 金融素养（Fed Survey of Consumer Finances 公开摘要数据，仅第 1 个插补） | https://www.federalreserve.gov/econres/scfindex.htm | 家庭（每户 1 行） | 实测中 |
| 组2 | SCF 2022 家庭总资产：log 工资 × 金融素养 | https://www.federalreserve.gov/econres/scfindex.htm | 家庭 | 失败（R² 0.65，但交互 p=0.041、HC3 p=0.12，加权后 p=0.74） |
| 组2 | SEC Form N-CEN 基金经纪佣金：log(年度经纪佣金) ~ log(月均净资产) × 是否指数基金（2025Q3–2026Q2 申报，每基金系列 1 行） | https://www.sec.gov/data-research/sec-markets-data/form-n-cen-data-sets | 基金系列（每 SERIES_ID 1 行） | 实测中 |
| 组2 | SEC Form N-CEN 基金经纪佣金：log 资产 × 指数基金 | https://www.sec.gov/data-research/sec-markets-data/form-n-cen-data-sets | 基金系列 | 失败（R² 0.493 < 0.50；家族 ICC 0.15、信托 ICC 0.24） |
| 汇总 | SOC 新建独栋住宅售价：面积 × Census division（方案一） | https://www.census.gov/construction/chars/microdata.html | 新建住宅 | 合格 |

## 停止规则（用户 2026-09-30 设定）
- 状态写"合格"的候选（需达到方案一的水平或更好，见各组任务消息）累计 ≥ 3 个时，全体停止开新候选。
- 统计方法（只数表格行）：`grep -cE '^[|] (组[123]|汇总) .*[|] 合格 [|]$' 候选登记.md`。每开一个新候选前先统计一次。
- 状态写法：只能用"实测中 / 合格 / 失败（原因）"，不要写"成功"。
| 组3 | 医院每调整出院运营成本：log 病例组合指数(CMI) × 所有制（营利/非营利/政府）（CMS HCRIS 2023 成本报告 + IPPS FY2025 Impact File） | https://data.cms.gov/provider-compliance/cost-report/hospital-provider-cost-report ; https://www.cms.gov/medicare/payment/prospective-payment-systems/acute-inpatient-pps/fy-2025-ipps-final-rule-home-page | 急性病 IPPS 医院（每 CCN 1 行） | 实测中 |
| 组3 | 医院每调整出院成本：log CMI × 所有制（HCRIS 2023 + IPPS FY2025 Impact File） | https://data.cms.gov/provider-compliance/cost-report/hospital-provider-cost-report | 急性病 IPPS 医院 | 失败（R² 0.49；交互 HC3 p=0.25；残差峰度 22.7） |
| 组3 | 慈善机构捐赠收入：log 捐赠与遗赠收入 ~ log 筹款支出 × 慈善类型（英格兰和威尔士 Charity Commission 登记册 Part B，最新财年，每机构 1 行） | https://register-of-charities.charitycommission.gov.uk/register/full-register-download | 注册慈善机构（每 organisation_number 1 行） | 实测中 |
| 组3 | 慈善机构捐赠收入：log 筹款支出 × 类型（Charity Commission Part A/B） | https://register-of-charities.charitycommission.gov.uk/register/full-register-download | 注册慈善机构 | 失败（R² 仅 0.28；交互本身稳健但解释力不足，唯一能提 R² 的总支出属预算恒等式泄漏） |
| 组2 | 加州地方政府债券发行的债券律师费：log(律师费) ~ log(发行本金) × 私募配售（CDIAC DebtWatch，2021–2025 已售发行，每发行人 1 行） | https://debtwatch.treasurer.ca.gov/ | 地方政府债务发行（每发行人最近 1 次） | 实测中 |
| 组3 | 货运承运人年行驶里程：log 年里程 ~ log 动力车辆数 × 营运类型（租赁营运 for-hire vs 自有货运 private）（FMCSA Company Census File，里程年份 2024；2025 年份为独立复现样本） | https://data.transportation.gov/d/az4n-8mr2 | 在册承运人（每 USDOT 号 1 行） | 实测中 |
| 组2 | 加州债券律师费：log 本金 × 私募配售 | https://debtwatch.treasurer.ca.gov/ | 债务发行 | 失败（R² 0.63，但交互 p=0.029、HC3 p=0.15，被 本金×评级 解释；峰度 76） |
| 组3 | 货运承运人年里程：log 车辆数 × for-hire/private（FMCSA Census） | https://data.transportation.gov/d/az4n-8mr2 | 承运人 | 失败（R² 0.51 且依赖按 Y/X 的合理性过滤，不过滤时 R² 0.18、交互变号；组间弹性差仅 0.06） |
| 组1 | 加拿大慈善机构募捐：log 收据捐款 ~ log 募捐支出 × 慈善类别（CRA T3010 List of charities 2024） | https://open.canada.ca/data/en/dataset/80c00cdb-1358-415c-bb8b-0de7f12675b8 | 注册慈善机构（每 BN 1 行） | 实测中 |
| 组1 | 加拿大慈善机构募捐：log 募捐支出 × 慈善类别（CRA T3010） | https://open.canada.ca/data/en/dataset/80c00cdb-1358-415c-bb8b-0de7f12675b8 | 注册慈善机构 | 失败（未实测即放弃：与组3 已登记的"捐款 ~ 筹款支出 × 类型"研究问题重复，且组3 同题 R² 仅 0.28） |
| 组2 | SEC Form ADV：log RAUM ~ log 投顾雇员 × 私募基金顾问 | https://www.sec.gov/data-research/sec-markets-data/information-about-registered-investment-advisers-exempt-reporting-advisers | 注册投顾 | 失败（log 模型 R² 0.69、HC3 p=5e-40、2019 不重叠样本复现通过；但原始尺度 R² 0.12、HC3 p=0.14，对 Y 截断，非美国样本复现反号——未达方案一水平） |
| 组2 | 加州市政债发行利率：TIC(%) ~ 最终到期年限 × 联邦免税/应税（CDIAC DebtWatch 2021–2025 已售固定利率发行，每发行人 1 行，季度固定效应） | https://debtwatch.treasurer.ca.gov/ | 地方政府债务发行（每发行人最近 1 次） | 实测中 |
| 组2 | 加州市政债 TIC：到期年限 × 联邦应税 | https://debtwatch.treasurer.ca.gov/ | 债务发行 | 失败（R² 0.77，但交互 p=0.023、HC3 p=0.26） |
| 组2 | 次级/近优汽车贷款定价：APR(%) ~ 借款人信用分 × 新车/二手车（SEC EDGAR ABS-EE 资产级数据，Santander Drive Auto Receivables Trust 2025-3 发行时资产池；2025-1 池为独立复现样本） | https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&type=ABS-EE | 汽车贷款（每笔 1 行，每池仅发行时快照） | 实测中 |
| 组3 | 公共交通机构客运量：log 年客运人次(UPT) ~ log 车辆营运小时(VRH) × 城乡（城市报告者 vs 农村报告者）（FTA National Transit Database 2024，每机构 1 行） | https://data.transportation.gov/d/4fir-qbim ; https://data.transportation.gov/d/g27i-aq2u | 公交机构（每 NTD ID 1 行） | 实测中 |
| 组3 | 公共交通机构客运量（更新：G 改为"仅需求响应 DR-only vs 有固定线路"，依据 Mohring 固定线路频率效应；城乡 G 因被 DR 占比×X 解释而放弃） | https://data.transportation.gov/d/4fir-qbim | 公交机构（每 NTD ID 1 行） | 实测中 |
| 组1 | CBECS 商业建筑年电费：面积 × 用途 | https://www.eia.gov/consumption/commercial/data/2018/index.php?view=microdata | 商业建筑 | 失败（原始尺度 R² 0.54、峰度 206；log–log 模型中交互 ΔR² 0.002，替代交互全加入后 HC3 p=0.076） |
| 组3 | 公共交通机构客运量：log UPT ~ log VRH × 服务类型（仅需求响应 vs 有固定线路）（NTD 2024，每机构 1 行） | https://data.transportation.gov/d/4fir-qbim | 公交机构（每 NTD ID 1 行） | 合格 |
| 组3 | 航空城市对票价：log 距离 × 最大承运人类型（Legacy/WN/ULCC）+ 端点城市固定效应（加 FE 后城市 ICC −0.03、二元残差相关 −0.015，其余硬性指标全部达标；依赖靠模型 FE 而非"一城一行"设计消除，待协调者裁定） | https://data.transportation.gov/d/yj5y-b2ir | 城市对市场 | 实测中 |
| 组3 | 航空城市对票价：log 距离 × 最大承运人类型（DOT Table 6） | https://data.transportation.gov/d/yj5y-b2ir | 城市对市场 | 失败（二元依赖，FE 修补不满足严格 IID 要求） |
| 组1 | 美国高校教师平均薪酬：log 生均捐赠基金 × 公立/私立非营利（IPEDS 2023 薪酬 + 2022-23 财务） | https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx | 四年制高校（每 UNITID 1 行） | 实测中 |
| 组3 | 安宁疗护机构护理投入：log 总护理分钟 ~ log 服务天数 × 所有制（营利 vs 非营利/政府）（CMS PAC PUF Hospice 2024 + Care Compare Hospice General Information） | https://data.cms.gov/provider-summary-by-type-of-service/medicare-post-acute-care-utilization/hospice | 安宁疗护机构（每 CCN 1 行） | 实测中 |
| 组3 | 安宁疗护护理分钟：log 服务天数 × 所有制（CMS PAC PUF Hospice 2024） | https://data.cms.gov/provider-summary-by-type-of-service/medicare-post-acute-care-utilization/hospice | 安宁疗护机构 | 失败（交互 p=0.40、HC3 p=0.47；抑制值使 n 从 6,134 降到 1,487） |
| 组3 | 公立中小学教师配置：log 教师 FTE ~ log 在校生数 × 是否全日制虚拟（网课）学校（NCES EDGE Public School Characteristics 2024-25） | https://data-nces.opendata.arcgis.com/datasets/nces::public-school-characteristics-current | 公立学校（每 NCESSCH 1 行） | 实测中 |
| 组1 | 美国高校教师平均薪酬：log 生均捐赠基金 × 公立/私立非营利（IPEDS 2023，每系统 1 校） | https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx | 四年制高校 | 合格 |
| 组2 | 汽车贷款 APR：征信分 × 二手车（SDART 2025-3 ABS-EE） | https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&type=ABS-EE | 汽车贷款 | 失败（R² 0.365 < 0.50；交互 HC3 p=5e-18 但加替代交互后减半） |
| 组3 | 公立中小学教师 FTE：log 在校生 × 全日制虚拟学校（NCES EDGE 2024-25） | https://data-nces.opendata.arcgis.com/datasets/nces::public-school-characteristics-current | 公立学校 | 失败（log 尺度 HC3 p=2e-7 但原始尺度交互 p=0.93，属固定编制造成的可移除交互；38% 虚拟校 FTE 未报；州 FE 后 Moran I 仍 0.05–0.06） |

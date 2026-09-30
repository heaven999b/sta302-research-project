# 变更记录

## 2026-09-30
- 废弃此前所有 STA302 方案，旧文件已移入废纸篓。
- 确定新的选题标准，分三组并行搜索，共实测约 29 个候选。
- 3 个候选达标：SOC 新房售价、NTD 公交客运量、IPEDS 教师薪酬。
- 用 Python 探针完成课程要求的全部检验和 Part 2 预演。
- 安装 R 环境（conda 环境 `sta302r`），把三个方案全部改写为 R：Part1_Code.Rmd、Part2_Analysis.Rmd、英文 proposal 及中文对照。R 结果与 Python 结果一致，并按 R 更正了探针中的错误。
- 建立总仓库和三个子仓库。
- 三个子仓库建好（soc-new-home-prices、ntd-transit-ridership、ipeds-faculty-salary），每个都在新位置重新 knit 验证过，清洗后数据逐字节一致。方案三的仓库版 HD 文件删去了校长姓名列。

# 提交前待办（跨项目）

各子仓库的 `docs/TODO.md` 里还有该方案自己的待办。

## 选题
- [ ] 从三个方案里选定一个（见 decisions.md）

## 所有方案都要做
- [ ] 填写组号、成员姓名、Contributions、时间表的负责人和日期
- [ ] Ethics 一节改用课程 Module 3 的术语（中文对照稿中标有 `[TODO]`）
- [ ] 阅读原文，核对文献概括，尤其是摘要缺失的几篇：Rosen 1974（方案一）、Taylor et al. 2009（方案二）
- [ ] 在 RStudio 里实际 knit 一遍 `Part1_Code.Rmd`
- [ ] 把原始 CSV、清洗后 CSV 和 `data/split_ids.csv` 上传 UofT OneDrive，设置权限，并把链接写进 Quercus 提交评论
- [ ] 完成 Part 0 团队协议（全员签字）并导出 PDF
- [ ] 按 Quercus 上的实际日期调整时间表（Part 1 截止 11/5 23:59）

## 在 Part 2 中需要如实披露
- [ ] 方案一：划分之前看过全样本的描述统计；"东北中部单独最低"这一结论不稳健
- [ ] 方案二：分组变量 G 是在第一版失败后改定的（研究者自由度）；Part 1 使用了 log–log
- [ ] 方案三：探针阶段的备选分析碰过部分测试集院校（只看过汇总系数）

## GitHub
- [ ] 用户用 yihaiwen9@gmail.com 注册新的 GitHub 账号
- [ ] `gh auth login` 登录新账号，然后运行 `scripts/publish_to_github.sh <新用户名> --public`（已决定公开）
- [ ] 小组其他成员注册 GitHub 后，加为协作者

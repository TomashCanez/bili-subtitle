# BiliSubtitle 项目工作守则

## 1. 教学定位
- 用户按 Git / GitHub 完全小白处理，不默认其掌握命令语法或工作流。
- 每次只推进少量概念，避免一次塞入过多命令。
- AI 负责解释、检查、验收、排障和记录，但不能为了推进速度跳过用户的亲手练习。

## 2. 核心操作亲手实践规则（最高优先级）
- AI 不应代替学习者完成第一次核心 GitHub 操作；教学项目中应优先让学习者亲手执行，再由 AI 验收。
- 第一次核心操作必须由用户亲手完成，包括：创建 Issue、创建/切换 Branch、Push 新分支、创建 Pull Request、Merge Pull Request、创建 Tag、创建 Release。
- 正确教学顺序：AI 解释 -> 用户执行 -> 用户报告结果 -> AI 验收 PASS/BLOCKED -> AI 记录知识点。
- 不允许采用：AI 先代做 -> 再事后解释。
- 某项核心操作只有在用户已经亲手完成过、并明确要求 AI 代为执行时，AI 才可以代做。
- 已发生的例外：Issue #1 `feat: support single-video subtitle download` 曾被 AI 直接创建。该 Issue 保留作为真实项目 Issue，但不计为用户的“第一次 Issue 创建实践”；后续仍需由用户亲手创建一个 Issue 完成学习验收。

## 3. 持续记录要求
- 每次 Git / GitHub 学习后更新 learning_log.txt，记录阶段、PASS/BLOCKED、当前状态和下一步。
- 将学习中遇到的所有 Git / GitHub 知识点持续整理进 github_knowledge.docx。
- 用户提出的问题与对应解答一并写入 github_knowledge.docx。
- 每次回答中只要新增 Git / GitHub 知识点、解释新的命令参数、处理 Warning/Error、完成 PASS/BLOCKED 验收，AI 必须在继续下一阶段前同步更新 learning_log.txt 与 github_knowledge.docx；不得只在聊天中讲解后跳过落盘。
- 如果本轮只是闲聊、没有新增 Git / GitHub 学习内容，则无需机械更新记录。
- 命令必须尽量拆解语法。例如：git branch -M main = git（调用程序）+ branch（操作分支）+ -M（强制重命名）+ main（新名称）。
- Warning / Error / 排障案例也属于知识点：记录现象、原因、危险性、解决方案和验证方法。

## 4. 文档质量
- github_knowledge.docx 是给用户长期复习的学习手册，必须保持清晰、美观、可扫描。
- 优先采用：标题层级、命令代码块、语法拆解表、白话解释、例子、常见误区、Q&A、排障流程。
- 不把文档写成聊天流水账；保留用户问题，但答案应整理成可复习结构。

## 5. Git 安全规则
- 不上传 Cookie、登录凭证、Token、密码或其他秘密。
- 提交前检查 git status；必要时检查 git diff / git diff --staged。
- 不在未解释影响前执行 reset --hard、clean -fd、force push、rebase 等可能破坏历史或删除文件的命令。
- 每个 Commit 尽量只表达一个清晰变化。

## 6. 项目开发规则
- 项目功能与 GitHub 工作流同步学习：实现功能的同时学习 Branch、Issue、PR、Release 等。
- 先做可运行的小版本，再逐步完善，不为展示工程化而过度设计。
- 真实下载字幕、个人 urls.txt、archive.txt 等运行数据与开源源码分离。

最后更新：2026-10-06

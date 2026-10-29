# 来源与依赖

## 本仓库

本整理版作者：**popsicletan**。

本仓库从已有硕士开题稿中提炼需求：中文封面、目录、正文、参考文献；
统一页眉；A4 与 25 mm 页边距；打印模式下封面及目录后的两张固定空白页。
原工作稿采用标识为 BUAAThesis v4.1.0（2025/09/01）的 `buaa.cls` 并包含本地修改。

为使公开模板的配置和依赖更简单，本仓库新建 `buaa-proposal.cls`，
直接使用 CTeX、fontspec、fancyhdr 等公开宏包接口实现硕士开题所需功能。
未附带原工作稿的完整类文件、正文、字体、封面 EPS、论文原图或私人文献库。
封面校名和报告名称直接以文字排版，与原稿使用图形字样的封面存在外观差异。
本仓库不宣称是原模板的完整兼容版本，也不宣称已经获得学校格式认证。

## 致谢

- [CheckBoxStudio/BUAAThesis](https://github.com/CheckBoxStudio/BUAAThesis)：北航研究生论文模板的重要前序项目。
  其公开仓库的 [LICENSE](https://github.com/CheckBoxStudio/BUAAThesis/blob/master/LICENSE) 为 MIT，署名 CheckBox Studio（2018）。
- 既有 v4.1.0 类文件列出的初始作者 Wei Quanmao、维护作者 Wei Xiaoyuan 及参与贡献者。
  本仓库不把较早公开仓库的许可自动扩展为所有后续外部文件的许可。

完整署名与随附的原许可证见 [NOTICE.md](../NOTICE.md)。

## 来源核对与修改记录

公开项目已核对至固定提交
[`2033aed941263a57a10a06c438e0d014bed677e8`](https://github.com/CheckBoxStudio/BUAAThesis/commit/2033aed941263a57a10a06c438e0d014bed677e8)，
提交日期为 2024-02-01。该版本的 MIT 许可证保留为
[本地原文副本](../licenses/CheckBoxStudio-BUAAThesis-LICENSE.txt)。

本地 v4.1.0 工作稿的文件头、署名与版本历史另存为
[buaa-v4.1.0-header.txt](provenance/buaa-v4.1.0-header.txt)。
所核对的 `buaa.cls` 已包含开题适配修改，其 SHA-256 为：

```text
f87b2b6e3a1f8c4f64b9bae805b68ced4bd367a8b37b7b7f3db76c87487c3457
```

该摘要用于识别本次所见的 44,487 字节工作稿，不是公开上游提交的文件摘要。
尚未确认本地 v4.1.0 对应的公开仓库提交，因此分别记录这两条来源线索。

| 整理项目 | 本版处理 |
| --- | --- |
| 开题结构与版式 | 参考既有开题稿，保留中文封面、目录、正文、文献及统一页眉等需求 |
| 类文件 | 新建 `buaa-proposal.cls`，集中硕士开题选项；在文件头保留格式来源与原作者线索 |
| 封面 | 改用文字校名和报告名称；本版示例作者为 popsicletan |
| 正文与文献 | 使用通用填写示例，保留文献作者、BibTeX 条目和正文引用键 |
| 使用与发布 | 补充 README、编译配置、GitHub Actions 与选项检查脚本 |
| 作者和许可 | popsicletan 署名适用于本整理版；原作者名单、原许可证与依赖链接分别保留 |

## 编译依赖

这些依赖由用户的 TeX 发行版提供，没有随仓库重新分发：

| 依赖 | 用途 | 上游 |
| --- | --- | --- |
| CTeX / xeCJK / fontspec | 中文排版与字体 | [CTeX](https://github.com/CTeX-org/ctex-kit) / [fontspec](https://github.com/latex3/fontspec) |
| Fandol / TeX Gyre / Latin Modern | 默认中西文字体 | [Fandol](https://ctan.org/pkg/fandol) / [TeX Gyre](https://ctan.org/pkg/tex-gyre) / [Latin Modern](https://ctan.org/pkg/lm) |
| gbt7714 | 国标参考文献与引用 | [gbt7714-bibtex-style](https://github.com/zepinglee/gbt7714-bibtex-style) |
| latexmk | 自动编译 | [latexmk](https://ctan.org/pkg/latexmk) |

各依赖遵循各自许可证。仓库的 MIT 许可不改变第三方字体、论文插图或学校标识的使用条件。
用户自行添加的内容应注明适当来源，并自行决定是否公开。

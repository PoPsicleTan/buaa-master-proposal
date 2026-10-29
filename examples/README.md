# 原模板示例保留版

`tex/` 中保留原工程的 BUAAThesis v4.1.0 示例章节，文件内容、引用键和原有换行均原样保存。
原作者与版本线索见 [NOTICE.md](../NOTICE.md) 和 [来源说明](../docs/ORIGIN.md)。

| 文件 | 原示例内容 |
| --- | --- |
| `tex/chap_instruction.tex` | 模板简介、原模板选项与写作提示 |
| `tex/chap_sample.tex` | 文献引用、算法、表格、插图、公式、定理和证明 |
| `tex/chap_summary.tex` | 总结 |
| `tex/chap_appendix.tex` | 附录 |
| `tex/chap_achievement.tex` | 攻读学位期间成果 |
| `tex/chap_acknowledge.tex` | 致谢 |
| `tex/chap_biography.tex` | 作者简介 |

配套原始图片保存在 `figures/examples/`。`ref.bib` 来自公开上游固定提交
[`2033aed941263a57a10a06c438e0d014bed677e8`](https://github.com/CheckBoxStudio/BUAAThesis/blob/2033aed941263a57a10a06c438e0d014bed677e8/ref.bib)，
保留示例需要的 `knuth86a`、`knuth84`、`tlc2`、`db` 等原引用键。
该书目是上游原文快照，其历史字段也保留原样。
v4.1.0 示例表题所用的 `zhudaoqian` 条目，另从原工程配套书目提取，
保存在 `ref-v4.1-supplement.bib`；正文中原有的引用键保持不变。

在项目根目录执行：

```sh
latexmk -xelatex examples-original.tex
```

输出为 `examples-original.pdf`。[查看已编译的示例](../docs/original-examples.pdf)。
算法需要 `algorithm2e`（Ubuntu/Debian 的 `texlive-science`），EPS 图片需要 Ghostscript。
默认开题报告仍通过 `main.tex` 编译；这些毕业论文示例按需参考。

`examples-original.tex` 和 `compatibility.tex` 是 popsicletan 添加的入口与兼容定义，
用于在当前硕士开题类下演示原章节。原章节中关于旧类文件选项、原版封面或附加页的说明，
描述的是原模板；当前可用选项以根目录 README 为准。
该入口保留原章节内容，页面样式采用当前模板。

`SOURCES.json` 记录每个原始文件的来源和 SHA-256 摘要。可运行
`python scripts/check-original-examples.py` 检查快照是否完整。

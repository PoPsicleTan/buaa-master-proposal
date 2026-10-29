# 北航硕士开题报告 LaTeX 模板

支持学硕 / 专硕、打印 / 电子版，使用 **XeLaTeX + BibTeX** 编译。
整理作者：[popsicletan](https://github.com/PoPsicleTan)。

[下载 ZIP](https://github.com/PoPsicleTan/buaa-master-proposal/archive/refs/heads/main.zip) · [Use this template](https://github.com/PoPsicleTan/buaa-master-proposal/generate) · [示例 PDF](docs/example.pdf)

<img src="docs/cover-preview.png" alt="原报告封面示意，已替换为公开示例信息" width="540">

## 使用

1. 在 `config/info.tex` 填写个人信息。
2. 在 `chapters/` 编写正文，在 `bibliography/references.bib` 添加文献。
3. 在项目根目录编译：

```sh
latexmk -xelatex main.tex
```

输出为 `main.pdf`。使用 Overleaf 时，上传整个项目，主文件选 `main.tex`，编译器选 **XeLaTeX**。

## 常用选项

在 `main.tex` 的 `\documentclass[...]` 中修改：

| 选项 | 可选值 |
| --- | --- |
| `degree` | `academic` 学硕 / `professional` 专硕 |
| `layout` | `print` 打印版 / `electronic` 电子版 |
| `subject` | `STEM` 理工类 / `HSS` 人文社科类 |
| `fontset` | 默认 `fandol`，无需另外提供字体文件 |

打印版封面后留白；目录为两页时不补空白页，奇数页时补白。
其他设置见 [详细使用说明](docs/USAGE.md)。

## 原始示例

原模板的 7 个示例章节、配图和引用保存在 `examples/` 中。
运行 `latexmk -xelatex examples-original.tex` 可编译查看。

[原始示例 PDF](docs/original-examples.pdf) · [示例说明](examples/README.md) · [写作与排版](docs/WRITING.md)

## 来源与许可

感谢 [CheckBoxStudio/BUAAThesis](https://github.com/CheckBoxStudio/BUAAThesis) 及原作者的工作。
原作者署名与引用来源保留在 [NOTICE.md](NOTICE.md)，本整理版采用 [MIT License](LICENSE)。
本模板为非官方整理，提交格式以学院要求为准。

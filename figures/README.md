# 插图目录

将自己绘制或有权使用的插图放在这里，推荐 PDF 矢量图或清晰的 PNG/JPEG。
类文件已设置 `\graphicspath{{figures/}}`，例如：

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.9\linewidth]{technical-route.pdf}
  \caption{总体技术路线}
  \label{fig:technical-route}
\end{figure}
```

先放入真实图片文件再使用该代码。正文自带的路线占位图无需图片文件。
建议文件名使用简短的英文字母、数字和连字符。

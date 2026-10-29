% SPDX-License-Identifier: MIT
% Copyright (c) 2026 popsicletan
% Author: popsicletan
% Format/design lineage: BUAAThesis; initial author Wei Quanmao;
% v4.1.0 maintainer Wei Xiaoyuan and the contributors recorded in NOTICE.md.
% Public predecessor: https://github.com/CheckBoxStudio/BUAAThesis
% Prior authorship, original license and change scope: NOTICE.md, docs/ORIGIN.md.
% This new class is maintained by popsicletan; prior credits remain in place.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{buaa-proposal}[2026/10/30 v1.0.0 BUAA master proposal]
\RequirePackage{iftex}
\RequireXeTeX
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\SetupKeyvalOptions{family=proposalclass,prefix=proposal@}
\DeclareStringOption[academic]{degree}
\DeclareStringOption[print]{layout}
\DeclareStringOption[STEM]{subject}
\DeclareStringOption[fandol]{fontset}
\DeclareBoolOption[false]{colorlinks}
\DeclareBoolOption[false]{longtitle}
\DeclareDefaultOption{\ClassError{buaa-proposal}{Unknown option: \CurrentOption}{See the options table in README.md.}}
\ProcessKeyvalOptions*
\newcommand{\proposal@checkchoice}[3]{%
  \ifboolexpr{test {\ifdefstring{#1}{#2}} or test {\ifdefstring{#1}{#3}}}{}%
  {\ClassError{buaa-proposal}{Invalid option value: \meaning#1}{Use #2 or #3.}}}
\proposal@checkchoice{\proposal@degree}{academic}{professional}
\proposal@checkchoice{\proposal@layout}{print}{electronic}
\proposal@checkchoice{\proposal@subject}{STEM}{HSS}
\ifboolexpr{test {\ifdefstring{\proposal@fontset}{fandol}} or
  test {\ifdefstring{\proposal@fontset}{windows}} or
  test {\ifdefstring{\proposal@fontset}{mac}} or
  test {\ifdefstring{\proposal@fontset}{none}}}{}%
  {\ClassError{buaa-proposal}{Invalid fontset}{Use fandol, windows, mac or none.}}
\edef\proposal@loadoptions{\noexpand\PassOptionsToClass{fontset=\proposal@fontset}{ctexbook}}
\proposal@loadoptions
\LoadClass[UTF8,a4paper,zihao=-4,oneside,openany,linespread=1.7]{ctexbook}
% In fontset=none mode users define these families in config/packages.tex.
\providecommand{\songti}{\CJKfamily{zhsong}}
\providecommand{\heiti}{\CJKfamily{zhhei}}
\providecommand{\kaishu}{\CJKfamily{zhkai}}
\providecommand{\fangsong}{\CJKfamily{zhfs}}
% Resolve bundled font files through kpathsea, without an OS font-cache dependency.
\setmainfont{texgyretermes}[
  Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
  ItalicFont=*-italic,BoldItalicFont=*-bolditalic]
\setsansfont{texgyreheros}[
  Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
  ItalicFont=*-italic,BoldItalicFont=*-bolditalic]
\setmonofont{lmmono10-regular.otf}
\RequirePackage[margin=25mm,headheight=15pt]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage{amsmath,amssymb}
\RequirePackage{booktabs,tabularx,longtable,array}
\RequirePackage{caption,subcaption}
\RequirePackage{enumitem}
\RequirePackage[nodisplayskipstretch]{setspace}
\RequirePackage{gbt7714}
\RequirePackage{xcolor}
\RequirePackage[unicode,hypertexnames=false]{hyperref}
\ifproposal@colorlinks
  \hypersetup{colorlinks=true,linkcolor=blue!50!black,citecolor=blue!50!black,urlcolor=blue!50!black}
\else
  \hypersetup{hidelinks}
\fi
\graphicspath{{figures/}}
\ctexset{
  autoindent=2,
  contentsname={目\quad 录},
  bibname={参考文献},
  chapter={number=\arabic{chapter},format=\centering\heiti\zihao{3},beforeskip=19pt,afterskip=22pt,fixskip=true},
  section={format=\heiti\zihao{4},beforeskip=9pt,afterskip=11pt},
  subsection={format=\heiti\zihao{-4},beforeskip=4pt,afterskip=4pt}
}
\ifdefstring{\proposal@subject}{HSS}{%
  \ctexset{chapter={name={,、},number=\chinese{chapter}},
    section={name={（,）},number=\chinese{section}},
    subsection={name={,、},number=\arabic{subsection}}}
}{}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}
% Keep floats' spacing local; never wrap a floating table in a spacing environment.
\AtBeginEnvironment{table}{\zihao{5}\renewcommand{\arraystretch}{1.35}}
\captionsetup{font=small,labelsep=quad}
\captionsetup[table]{position=top,skip=6pt}
\captionsetup[figure]{position=bottom,skip=6pt}
% Arabic chapter numbers keep figure/table references unambiguous in HSS mode.
\renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}}
\renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}
\setlist{itemsep=0pt,parsep=0pt,topsep=4pt}
\setlength{\bibsep}{3pt}
\renewcommand{\bibfont}{\zihao{5}\linespread{1.15}\selectfont}
\raggedbottom

% Public metadata interface; optional fields are omitted when empty.
\newcommand{\proposal@title}{}
\newcommand{\proposal@author}{}
\newcommand{\proposal@studentid}{}
\newcommand{\proposal@department}{}
\newcommand{\proposal@major}{}
\newcommand{\proposal@supervisor}{}
\newcommand{\proposal@cosupervisor}{}
\newcommand{\proposal@date}{}
\newcommand{\proposal@specialprogram}{}
\newcommand{\proposal@confidentiality}{公开}
\define@key{proposal}{title}{\renewcommand{\proposal@title}{#1}}
\define@key{proposal}{author}{\renewcommand{\proposal@author}{#1}}
\define@key{proposal}{student-id}{\renewcommand{\proposal@studentid}{#1}}
\define@key{proposal}{department}{\renewcommand{\proposal@department}{#1}}
\define@key{proposal}{major}{\renewcommand{\proposal@major}{#1}}
\define@key{proposal}{supervisor}{\renewcommand{\proposal@supervisor}{#1}}
\define@key{proposal}{co-supervisor}{\renewcommand{\proposal@cosupervisor}{#1}}
\define@key{proposal}{date}{\renewcommand{\proposal@date}{#1}}
\define@key{proposal}{special-program}{\renewcommand{\proposal@specialprogram}{#1}}
\define@key{proposal}{confidentiality}{\renewcommand{\proposal@confidentiality}{#1}}
\newcommand{\ProposalSetup}[1]{\setkeys{proposal}{#1}}
\newcommand{\proposal@required}[2]{\ifdefempty{#1}{%
  \ClassError{buaa-proposal}{Missing field: #2}{Fill config/info.tex before compiling.}}{}}
\AtBeginDocument{%
  \proposal@required{\proposal@title}{title}
  \proposal@required{\proposal@author}{author}
  \proposal@required{\proposal@studentid}{student-id}
  \proposal@required{\proposal@department}{department}
  \proposal@required{\proposal@major}{major}
  \proposal@required{\proposal@supervisor}{supervisor}
  \proposal@required{\proposal@date}{date}
  \hypersetup{pdftitle={\proposal@title},pdfauthor={\proposal@author},pdfsubject={硕士开题报告}}
}
\newcommand{\proposal@pagestyle}{%
  \fancyhf{}
  \fancyhead[C]{\songti\zihao{-5}北京航空航天大学硕士开题报告}
  \fancyfoot[C]{\zihao{5}\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
}
\fancypagestyle{proposal}{\proposal@pagestyle}
\fancypagestyle{plain}{\proposal@pagestyle}
% A deliberately blank physical page, without header, footer or page number.
\newcommand{\proposal@blankpage}{%
  \ifdefstring{\proposal@layout}{print}{%
    \begingroup\pagestyle{empty}\thispagestyle{empty}\null\newpage\endgroup
  }{}
}
\newcommand{\makeproposalfrontmatter}{%
  \begingroup\setstretch{1}
  \pagenumbering{gobble}\pagestyle{empty}\thispagestyle{empty}
  \pdfbookmark[0]{中文封面}{proposal.cover}
  \noindent\hfill{\zihao{5}密级：\proposal@confidentiality}\par
  \vspace*{15mm}
  \begin{center}
    {\heiti\fontsize{28pt}{36pt}\selectfont 北京航空航天大学\par}
    \vspace{8mm}
    {\heiti\fontsize{32pt}{40pt}\selectfont 硕士开题报告\par}
    \vspace{22mm}
    \begin{minipage}[c][38mm][c]{\textwidth}
      \centering\songti\bfseries
      \ifproposal@longtitle\fontsize{24pt}{32pt}\else\fontsize{30pt}{40pt}\fi
      \selectfont\proposal@title\par
    \end{minipage}
    \vspace{14mm}
    {\heiti\zihao{4}\renewcommand{\arraystretch}{1.65}
    \begin{tabularx}{0.85\textwidth}{@{}>{\raggedleft\arraybackslash}p{27mm}X@{}}
      学位类型 & \ifdefstring{\proposal@degree}{academic}{学术学位硕士}{专业学位硕士}\\
      作者姓名 & \proposal@author\\
      学\qquad 号 & \proposal@studentid\\
      \ifdefstring{\proposal@degree}{academic}{学科专业}{专业名称} & \proposal@major\\
      指导教师 & \proposal@supervisor\\
      \ifdefempty{\proposal@cosupervisor}{}{联合导师 & \proposal@cosupervisor\\}
      培养学院 & \proposal@department\\
      \ifdefempty{\proposal@specialprogram}{}{专项计划 & \proposal@specialprogram\\}
      报告日期 & \proposal@date
    \end{tabularx}}
  \end{center}
  \clearpage\endgroup\proposal@blankpage
  \pagenumbering{Roman}\pagestyle{proposal}
  \pdfbookmark[0]{目录}{proposal.contents}
  \begingroup\setstretch{1.25}\tableofcontents\clearpage\endgroup
  \proposal@blankpage
  \pagenumbering{arabic}\pagestyle{proposal}
}
\apptocmd{\bibsection}{\phantomsection\addcontentsline{toc}{chapter}{参考文献}}{}%
  {\ClassError{buaa-proposal}{Cannot configure bibliography heading}{Check the installed natbib/gbt7714 packages.}}
% Explicitly keep the 2015 style: gbt7714 v3 changed its unversioned default.
\newcommand{\proposalbibliography}[1]{%
  \@ifpackagelater{gbt7714}{2026/05/02}
    {\bibliographystyle{gbt7714-2015-numeric}}
    {\bibliographystyle{gbt7714-numerical}}%
  \bibliography{#1}
}
\endinput

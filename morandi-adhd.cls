%% =====================================================================
%%  morandi-adhd.cls
%%  莫蘭迪配色 × ADHD 友善閱讀 LaTeX 模板
%%
%%  編譯：XeLaTeX（建議用 latexmk -xelatex）
%%  授權：MIT License
%% =====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{morandi-adhd}[2026/09/27 v1.0 Morandi palette, ADHD-friendly layout]

%% ---------------------------------------------------------------------
%% 選項 Options
%%   dark      深色護眼模式
%%   print     列印模式（白底、不填滿頁面背景色）
%%   bionic    開啟 \bionic{} 的英文粗體引導（預設開啟，nobionic 關閉）
%%   compact   較緊湊的行距（1.35 倍，預設 1.6 倍）
%%   english   介面文字（方塊標題、目錄、日期…）改成英文
%%   classic   使用 v1 的舊版 7 色配色（預設為 morandi.sty 的 12 色）
%%   其他選項會傳給 article
%% ---------------------------------------------------------------------
\newif\ifmorandi@dark     \morandi@darkfalse
\newif\ifmorandi@print    \morandi@printfalse
\newif\ifmorandi@bionic   \morandi@bionictrue
\newif\ifmorandi@compact  \morandi@compactfalse
\newif\ifmorandi@english  \morandi@englishfalse
\newif\ifmorandi@classic  \morandi@classicfalse

\DeclareOption{dark}{\morandi@darktrue}
\DeclareOption{print}{\morandi@printtrue}
\DeclareOption{bionic}{\morandi@bionictrue}
\DeclareOption{nobionic}{\morandi@bionicfalse}
\DeclareOption{compact}{\morandi@compacttrue}
\DeclareOption{english}{\morandi@englishtrue}
\DeclareOption{classic}{\morandi@classictrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[a4paper,11pt]{article}

%% ---------------------------------------------------------------------
%% 套件 Packages
%% ---------------------------------------------------------------------
\RequirePackage{fontspec}
% 注意：不使用 xeCJK 的 boldfont 選項（全域偽粗體）。偽粗體是把筆畫往外加粗，
% 字會擠在一起、和一般字對不齊；這裡改用字型本身的真粗體（見「字型」段落）。
\RequirePackage[slantfont]{xeCJK}
\RequirePackage{xeCJKfntef}
\RequirePackage{amsmath,amssymb}
\RequirePackage{xcolor}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{ragged2e}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{refcount}
\RequirePackage{enumitem}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{colortbl}
\RequirePackage{pifont}
\RequirePackage{tikz}
\RequirePackage[most]{tcolorbox}
\RequirePackage{needspace}
\RequirePackage{caption}
\RequirePackage{hyperref}

%% ---------------------------------------------------------------------
%% 莫蘭迪色盤 Morandi palette
%%   12 色定義在 morandi.sty（講義、讀本、英文版、試卷共用）。
%%   這裡把顏色對應到「語意角色」，版面其他地方只使用角色名稱，
%%   所以換色盤時只要改這一段。
%% ---------------------------------------------------------------------
\RequirePackage{morandi}

% v1 舊版 7 色：保留名稱，classic 選項會用它們覆寫 12 色
\definecolor{MorandiRose}   {HTML}{C4A4A0} % 灰玫瑰
\definecolor{MorandiSage}   {HTML}{9EAE95} % 鼠尾草綠
\definecolor{MorandiBlue}   {HTML}{8DA1B0} % 霧霾藍
\definecolor{MorandiSand}   {HTML}{C9B79C} % 奶茶沙
\definecolor{MorandiMauve}  {HTML}{A698AE} % 灰紫
\definecolor{MorandiClay}   {HTML}{B98B7D} % 陶土紅
\definecolor{MorandiStone}  {HTML}{A9A39A} % 岩灰

% 角色在 \begin{document} 才對應，所以在導言區改 mdBlue 等 12 色也會生效
\newcommand\morandi@setroles{%
\ifmorandi@classic
  \definecolor{mdDeep}  {HTML}{6E5A57}
  \colorlet{mdBlue}  {MorandiBlue}
  \colorlet{mdTerm}  {MorandiClay}
  \colorlet{mdRose}  {MorandiRose}
  \colorlet{mdSage}  {MorandiSage}
  \colorlet{mdSand}  {MorandiSand!55!white}
  \definecolor{mdCream} {HTML}{F6F2EC}
  \colorlet{mdRow}   {MorandiStone!14!white}
  \colorlet{mdHeadBg}{MorandiBlue}
  \colorlet{mdLine}  {MorandiStone!60!white}
  \colorlet{mdMuted} {MorandiMauve!60!MorandiStone}
  \definecolor{mdText}  {HTML}{3F3B38}
\fi

%% ---- 語意角色 --------------------------------------------------------
\ifmorandi@dark
  % 深色模式：深灰藍底、米白字；方塊底色改用各色與背景混合
  \definecolor{PageBg}   {HTML}{2E3136}
  \definecolor{TextMain} {HTML}{E4DED6}
  \definecolor{TextSoft} {HTML}{B5AFA7}
  \colorlet{TintBase}    {PageBg}
  \colorlet{Heading}     {mdRose!45!white}
  \colorlet{SubHeading}  {mdBlue!55!white}
  \colorlet{KeyColor}    {mdRose}
  \colorlet{BionicColor} {mdBlue!45!white}
  \colorlet{RuleColor}   {mdLine!45!PageBg}
  \colorlet{CoverBg}     {mdRose!16!PageBg}
  \colorlet{BoxCream}    {white!7!PageBg}
  \colorlet{TableRowBg}  {white!6!PageBg}
  \colorlet{TableHeadBg} {mdHeadBg!65!PageBg}
  \colorlet{HighlightColor}{mdRose!38!PageBg}
\else
  % 淺色模式：偏白的暖白底、深炭灰字
  \definecolor{PageBg}   {HTML}{FCFBF9}
  \colorlet{TextMain}    {mdText}
  \colorlet{TextSoft}    {mdMuted}
  \colorlet{TintBase}    {white}
  \colorlet{Heading}     {mdDeep}       % 大標題、章名
  \colorlet{SubHeading}  {mdBlue}       % 次標題
  \colorlet{KeyColor}    {mdTerm}       % 專有名詞、答案字母
  \colorlet{BionicColor} {mdDeep}       % 英文粗體字首
  \colorlet{RuleColor}   {mdLine}       % 分隔線、表格線、頁首線
  \colorlet{CoverBg}     {mdCream}      % 封面框
  \colorlet{BoxCream}    {mdCream}      % 重點框、定義框底色
  \colorlet{TableRowBg}  {mdRow}        % 表格隔行
  \colorlet{TableHeadBg} {mdHeadBg}     % 表頭
  \colorlet{HighlightColor}{mdSand}     % 螢光筆
\fi
\ifmorandi@print
  \definecolor{PageBg}{HTML}{FFFFFF}
\fi
\colorlet{LinkColor}     {mdBlue}       % 連結
\colorlet{PageNumColor}  {mdBlue}       % 頁碼
\colorlet{SecNumBg}      {mdRose}       % 節號色塊
\colorlet{CoverAccent}   {mdRose}       % 封面左邊線
\colorlet{BulletColor}   {mdSage}       % 項目符號
\colorlet{ProgressColor} {mdSage}
\colorlet{TableHeadText} {white}

\pagecolor{PageBg}
\color{TextMain}
}
\AtBeginDocument{\morandi@setroles}

%% ---------------------------------------------------------------------
%% 字型 Fonts
%%   ADHD / 閱讀困難者通常覺得無襯線字較好讀，這裡預設全用黑體系。
%%   會依序尋找系統中存在的字型；也可以在導言區用
%%   \setCJKmainfont{...} / \setmainfont{...} 自行覆寫。
%% ---------------------------------------------------------------------
\newcommand\morandi@pickfont[3]{% #1 = 設定指令, #2 = 候選清單, #3 = 最後備案
  \def\morandi@found{0}%
  \@for\morandi@f:=#2\do{%
    \if0\morandi@found
      \IfFontExistsTF{\morandi@f}{#1{\morandi@f}\def\morandi@found{1}}{}%
    \fi}%
  \if0\morandi@found #3\fi}

\morandi@pickfont{\setmainfont}
  {Noto Sans,Source Sans 3,Helvetica Neue,Arial,DejaVu Sans}
  {\setmainfont{Latin Modern Sans}}
\morandi@pickfont{\setsansfont}
  {Noto Sans,Source Sans 3,Helvetica Neue,Arial,DejaVu Sans}
  {\setsansfont{Latin Modern Sans}}
\morandi@pickfont{\setmonofont}
  {JetBrains Mono,Fira Code,Source Code Pro,Menlo,Consolas,DejaVu Sans Mono}
  {\setmonofont{Latin Modern Mono}}
% 中文字型：優先使用字型內建的真粗體，字寬、基線都和一般字一致。
%   * 有 Bold 字重的字型（Noto／思源／微軟正黑）交給 fontspec 自動找
%   * 蘋方沒有 Bold，改用 Semibold
%   * 只有單一字重的字型才退回偽粗體
\newcommand\morandi@setcjkboldopts[1]{% 結果存在 \morandi@opts
  \edef\morandi@tmp{#1}\def\morandi@pf{PingFang TC}\def\morandi@ht{Heiti TC}%
  \def\morandi@opts{}%
  \ifx\morandi@tmp\morandi@pf \def\morandi@opts{BoldFont={PingFang TC Semibold}}\fi
  \ifx\morandi@tmp\morandi@ht \def\morandi@opts{AutoFakeBold=2.5}\fi}
\newcommand\morandi@pickcjk[3]{% #1 = 設定指令, #2 = 候選清單, #3 = 最後備案
  \def\morandi@found{0}%
  \@for\morandi@f:=#2\do{%
    \if0\morandi@found
      \IfFontExistsTF{\morandi@f}{%
        \morandi@setcjkboldopts{\morandi@f}%
        \edef\morandi@next{\noexpand#1{\morandi@f}[\morandi@opts]}%
        \morandi@next\def\morandi@found{1}}{}%
    \fi}%
  \if0\morandi@found #3\fi}

\morandi@pickcjk{\setCJKmainfont}
  {Noto Sans CJK TC,Noto Sans TC,Source Han Sans TC,PingFang TC,Microsoft JhengHei,Heiti TC}
  {\ClassWarningNoLine{morandi-adhd}{找不到繁體中文黑體，請自行設定 \string\setCJKmainfont}}
\morandi@pickcjk{\setCJKsansfont}
  {Noto Sans CJK TC,Noto Sans TC,Source Han Sans TC,PingFang TC,Microsoft JhengHei,Heiti TC}
  {}
\morandi@pickcjk{\setCJKmonofont}
  {Noto Sans Mono CJK TC,Noto Sans CJK TC,Noto Sans TC,PingFang TC,Microsoft JhengHei}
  {}

\renewcommand\familydefault{\sfdefault}

%% ---------------------------------------------------------------------
%% 版面 Layout
%%   * 較寬的左右邊界 → 每行字數較少，視線不容易跳行
%%   * 較大的行距與段距 → 段落之間有明確的「呼吸空間」
%%   * 靠左對齊（不左右對齊）→ 避免字距忽大忽小形成「河流」
%% ---------------------------------------------------------------------
\geometry{a4paper, top=24mm, bottom=26mm, left=30mm, right=30mm,
          headsep=8mm, footskip=12mm}

\ifmorandi@compact
  \setstretch{1.35}
\else
  \setstretch{1.6}
\fi
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.75em plus 0.2em minus 0.1em}
\xeCJKsetup{CJKecglue={\hskip 0.25em plus 0.08em}}
% 完全靠左、右側自由參差：不斷字時英文長單字也不會超出邊界
\setlength{\RaggedRightRightskip}{0pt plus 1fil}
\AtBeginDocument{\RaggedRight}
\setlength{\emergencystretch}{3em}
\hyphenpenalty=10000
\exhyphenpenalty=10000
\widowpenalty=10000
\clubpenalty=10000

\hypersetup{colorlinks=true, linkcolor=LinkColor, urlcolor=LinkColor,
            citecolor=LinkColor, bookmarksnumbered=true}

%% ---------------------------------------------------------------------
%% 標題 Headings：色塊編號 + 大字，一眼就能找到章節位置
%% ---------------------------------------------------------------------
\titleformat{\section}[hang]
  {\needspace{7\baselineskip}\Large\bfseries\color{Heading}}
  {\tikz[baseline=(n.base)]\node[fill=SecNumBg, text=white, rounded corners=3pt,
     inner xsep=6pt, inner ysep=3pt, font=\large\bfseries](n){\thesection};}
  {0.6em}{}
  [\vspace{-0.72\baselineskip}{\color{RuleColor}\rule{\linewidth}{1pt}}]
\titleformat{\subsection}
  {\needspace{5\baselineskip}\large\bfseries\color{SubHeading}}
  {{\color{BulletColor}\rule[-0.15em]{4pt}{1.1em}}\hspace{0.5em}\thesubsection}
  {0.6em}{}
\titleformat{\subsubsection}
  {\normalsize\bfseries\color{SubHeading}}
  {{\color{BulletColor}\ding{110}}\hspace{0.3em}\thesubsubsection}
  {0.5em}{}
\titlespacing*{\section}{0pt}{2.2em}{1.0em}
\titlespacing*{\subsection}{0pt}{1.6em}{0.6em}
\titlespacing*{\subsubsection}{0pt}{1.2em}{0.4em}

% 每一節從新頁開始？預設否；需要時在導言區加 \morandisectionnewpage
\newcommand\morandisectionnewpage{%
  \let\morandi@oldsection\section
  \renewcommand\section{\clearpage\morandi@oldsection}}

%% 目錄
\titlecontents{section}[2em]
  {\vspace{0.4em}\bfseries\color{Heading}}
  {\contentslabel[{\color{SecNumBg}\thecontentslabel}]{2em}}
  {}{\titlerule*[0.6pc]{\color{RuleColor}.}\contentspage}
\titlecontents{subsection}[4.6em]
  {\color{TextMain}}
  {\contentslabel[{\color{SubHeading}\thecontentslabel}]{2.6em}}
  {}{\titlerule*[0.6pc]{\color{RuleColor}.}\contentspage}

% 目錄行距稍微收緊，方便一眼看完整體架構
\let\morandi@oldtoc\tableofcontents
\renewcommand\tableofcontents{\begingroup\setstretch{1.25}\setlength{\parskip}{0pt}%
  \morandi@oldtoc\endgroup}

%% ---------------------------------------------------------------------
%% 頁首頁尾 + 閱讀進度條
%%   進度條讓讀者知道「還剩多少」，減少面對長文件的焦慮感。
%% ---------------------------------------------------------------------
\newcommand\morandi@progressbar{%
  \begin{tikzpicture}
    \pgfmathsetmacro\morandi@total{max(\getpagerefnumber{LastPage},1)}%
    \pgfmathsetmacro\morandi@ratio{min(\thepage/\morandi@total,1)}%
    \fill[RuleColor!45!PageBg, rounded corners=1.5pt] (0,0) rectangle (\linewidth,3pt);
    \fill[ProgressColor, rounded corners=1.5pt] (0,0) rectangle (\morandi@ratio\linewidth,3pt);
  \end{tikzpicture}}

\pagestyle{fancy}
\fancyhf{}
\renewcommand\headrulewidth{0.4pt}
\renewcommand\headrule{{\color{RuleColor}\hrule height\headrulewidth\vskip-\headrulewidth}}
\fancyhead[L]{\small\color{TextSoft}\rightmark}
\fancyhead[R]{\small\color{TextSoft}\@title}
\fancyfoot[C]{\morandi@progressbar\\[2pt]
  \small\color{PageNumColor}\thepage\ /\ \pageref*{LastPage}}
\fancypagestyle{plain}{\fancyhf{}\renewcommand\headrulewidth{0pt}\fancyfoot[C]{\morandi@progressbar\\[2pt]
  \small\color{PageNumColor}\thepage\ /\ \pageref*{LastPage}}}
% 頁首顯示「本頁開頭所在的章節」，而不是本頁最後一個章節
\renewcommand\sectionmark[1]{\markboth{\thesection\quad #1}{\thesection\quad #1}}
\setlength{\headheight}{16pt}

%% ---------------------------------------------------------------------
%% 封面標題 Title
%% ---------------------------------------------------------------------
% 沒寫 \title 也能編譯（頁首會用到標題）
\gdef\@title{}
\newcommand\subtitle[1]{\gdef\morandi@subtitle{#1}}
\gdef\morandi@subtitle{}
\newcommand\readingtime[1]{\gdef\morandi@readingtime{#1}}
\gdef\morandi@readingtime{}

\renewcommand\maketitle{%
  \thispagestyle{plain}%
  \begin{tcolorbox}[enhanced, colback=CoverBg, colframe=CoverBg,
      arc=6pt, boxrule=0pt, left=14pt, right=14pt, top=14pt, bottom=12pt,
      borderline west={5pt}{0pt}{CoverAccent}]
    {\LARGE\bfseries\color{Heading}\@title\par}
    \ifx\morandi@subtitle\@empty\else
      \vspace{0.3em}{\large\color{TextSoft}\morandi@subtitle\par}\fi
    \vspace{0.8em}
    {\small\color{TextSoft}\@author
     \ifx\@date\@empty\else\quad|\quad\@date\fi
     \ifx\morandi@readingtime\@empty\else\quad|\quad \readingtimename\morandi@titlesep\morandi@readingtime\fi\par}
  \end{tcolorbox}
  \vspace{0.5em}}

%% ---------------------------------------------------------------------
%% 資訊方塊 Callout boxes
%%   不同顏色 = 不同用途。固定的顏色語意讓大腦不必每次重新判讀。
%%     tldr        一句話摘要（放在最前面）  奶茶底、淺玫瑰邊
%%     goals       本節目標                  霧藍灰
%%     keypoint    重點                      鼠尾草綠邊、米白底
%%     definition  定義                      乾燥玫瑰邊、米白底
%%     example     例題／範例                灰藍
%%     tip         小提示                    奶茶
%%     warning     注意                      淺玫瑰
%%     question    想一想                    暖灰
%%     summary     本節回顧                  鼠尾草綠
%%     bigidea     Big idea                  鼠尾草綠全框、米白底
%%     derivation  推導                      淺玫瑰標題、灰褐邊
%%     selfcheck   自我檢查                  奶茶標題、灰褐邊
%%     terms       名詞                      奶茶底、乾燥玫瑰邊
%% ---------------------------------------------------------------------
\tcbset{morandi/.style={
    enhanced, breakable, arc=4pt, boxrule=0pt,
    left=10pt, right=10pt, top=12pt, bottom=6pt,
    before skip=1.1em, after skip=1.3em,
    fonttitle=\bfseries\small,
    colupper=TextMain,
    attach boxed title to top left={xshift=8pt, yshift=-7pt},
    boxed title style={arc=3pt, boxrule=0pt},
  }}

% 淺色模式用指定底色；深色模式改用邊線色與背景混合，避免亮色方塊刺眼
\newcommand\morandi@bodycolor[2]{% #1 = 邊線色, #2 = 淺色模式底色
  \ifmorandi@dark #1!16!PageBg\else #2\fi}

% \morandi@newbox[額外設定]{環境名}{邊線色}{標題底色}{標題字色}{底色}{預設標題}
\newcommand\morandi@newbox[7][]{%
  \newtcolorbox{#2}[1][]{morandi,
    colback=\morandi@bodycolor{#3}{#6},
    borderline west={3pt}{0pt}{#3},
    boxed title style={colback=#4}, coltitle=#5,
    title={#7\if\relax\detokenize{##1}\relax\else\morandi@titlesep##1\fi}, #1}}

% 推導框、自我檢查框底色是白的，加一圈灰褐細框才看得出範圍
\tcbset{morandi/outlined/.style={colframe=RuleColor, boxrule=0.6pt, leftrule=3pt}}

% 方塊標題文字在檔案最後依語言設定（見「介面語言」）
%                  環境          邊線      標題底    標題字   淺色底色             標題
\morandi@newbox{keypoint}  {mdSage} {mdSage} {white}  {BoxCream}           {\keypointname}
\morandi@newbox{definition}{mdTerm} {mdTerm} {white}  {BoxCream}           {\definitionname}
\morandi@newbox{example}   {mdBlue} {mdBlue} {white}  {mdBlue!8!TintBase}  {\examplename}
\morandi@newbox{goals}     {mdDeep} {mdDeep} {white}  {mdDeep!6!TintBase}  {\goalsname}
\morandi@newbox{tip}       {mdLine} {mdSand} {mdDeep} {mdSand!45!TintBase} {\tipname}
\morandi@newbox{warning}   {mdRose} {mdRose} {white}  {mdRose!18!TintBase} {\warningname}
\morandi@newbox{question}  {mdMuted}{mdMuted}{white}  {mdMuted!8!TintBase} {\questionname}
\morandi@newbox{summary}   {mdSage} {mdSage} {white}  {mdSage!12!TintBase} {\summaryname}
\morandi@newbox[morandi/outlined]{derivation}{mdLine} {mdRose} {white}  {TintBase}           {\derivationname}
\morandi@newbox[morandi/outlined]{selfcheck} {mdLine} {mdSand} {mdDeep} {TintBase}           {\selfcheckname}
\morandi@newbox{terms}     {mdTerm} {mdTerm} {white}  {mdSand}             {\termsname}

% Big idea：四邊全框，份量比一般方塊重，用在整章最核心的概念
\newtcolorbox{bigidea}[1][]{morandi,
  colback=\morandi@bodycolor{mdSage}{BoxCream}, colframe=mdSage, boxrule=1.2pt,
  fontupper=\large, top=14pt, bottom=8pt,
  boxed title style={colback=mdSage}, coltitle=white,
  title={\bigideaname\if\relax\detokenize{#1}\relax\else\morandi@titlesep#1\fi}}

% TL;DR：無標題籤的大字條
\newtcolorbox{tldr}{morandi, colback=\morandi@bodycolor{mdRose}{mdSand!60!TintBase},
  borderline west={5pt}{0pt}{mdRose},
  fontupper=\large, top=8pt, bottom=8pt, left=12pt,
  before upper=\morandi@tldrlabel}
\newcommand\morandi@tldrlabel{\textbf{\textcolor{KeyColor}{\tldrname}}\quad}

%% ---------------------------------------------------------------------
%% 清單 Lists
%%   項目間距加大；checklist 讓任務可以一格一格打勾，
%%   把大任務拆成小步驟，對執行功能較弱的讀者特別有幫助。
%% ---------------------------------------------------------------------
\setlist{itemsep=0.35em, topsep=0.4em, leftmargin=1.8em}
\setlist[itemize,1]{label={\color{BulletColor}\ding{108}}, font=\scriptsize}
\setlist[itemize,2]{label={\color{mdRose}\ding{109}}, font=\scriptsize}
\setlist[itemize,3]{label={\color{mdBlue}\textbullet}}
\setlist[enumerate,1]{label={\color{SubHeading}\bfseries\arabic*.}}
\setlist[enumerate,2]{label={\color{BulletColor}\bfseries(\alph*)}}

\newcommand\morandi@unchecked{{\color{mdLine}\large\ding{113}}}
\newcommand\morandi@checked{{\color{BulletColor}\large\ding{51}}}
\newlist{checklist}{itemize}{2}
\setlist[checklist]{label=\morandi@unchecked, leftmargin=2em, itemsep=0.1em}
\newcommand\done{\item[\morandi@checked]}

% steps：大圓圈編號的步驟
\newlist{steps}{enumerate}{1}
\DeclareRobustCommand\morandi@stepnum[1]{\tikz[baseline=(c.base)]\node[circle,
    fill=mdBlue, text=white, font=\small\bfseries, inner sep=0pt,
    minimum size=1.5em](c){#1};}
\setlist[steps]{label=\morandi@stepnum{\arabic*}, leftmargin=2.5em, itemsep=0.6em}

%% ---------------------------------------------------------------------
%% 行內強調 Inline emphasis
%%   \key{...}   關鍵字（粗體 + 顏色）
%%   \hl{...}    螢光筆標記（可跨行）
%%   \soft{...}  次要資訊（淡色），讓主要內容更突出
%%   \bionic{...} 英文閱讀引導：每三個單字，第一個單字的前兩個字母加粗
%%                 （可用 \bionicsetup{every=3, letters=2} 調整）
%% ---------------------------------------------------------------------
\newcommand\key[1]{{\bfseries\color{KeyColor}#1}}
% 試卷答案字母，例如 \answer{B}
\newcommand\answer[1]{{\bfseries\color{KeyColor}#1}}
\newcommand\soft[1]{{\color{TextSoft}\small #1}}

\newcommand\hl[1]{%
  \begingroup
  \xeCJKsetup{underline/format=\color{HighlightColor}, underline/thickness=1.08em,
    underline/depth=-0.84em}%
  \CJKunderline*{#1}%
  \endgroup}

\ExplSyntaxOn
\seq_new:N \l__morandi_words_seq
\int_new:N \l__morandi_index_int
\int_new:N \l__morandi_every_int
\int_new:N \l__morandi_letters_int
\int_set:Nn \l__morandi_every_int   { 3 }
\int_set:Nn \l__morandi_letters_int { 2 }

% \bionicsetup{every=3, letters=2}
%   every   ：每幾個單字加粗一次（1 = 每個單字都加粗）
%   letters ：加粗單字的前幾個字母
\keys_define:nn { morandi / bionic }
  {
    every   .int_set:N = \l__morandi_every_int ,
    letters .int_set:N = \l__morandi_letters_int ,
  }
\NewDocumentCommand \bionicsetup { m } { \keys_set:nn { morandi / bionic } {#1} }

\cs_new_protected:Npn \__morandi_bionic_word:n #1
  {
    { \bfseries \color{BionicColor} \tl_range:nnn {#1} { 1 } { \l__morandi_letters_int } }
    \tl_range:nnn {#1} { \l__morandi_letters_int + 1 } { -1 }
  }

% 從第 1 個單字開始，每 every 個單字把前 letters 個字母加粗
% 例：every=3, letters=2 → 第 1、4、7… 個單字的前兩個字母加粗
\NewDocumentCommand \bionic { m }
  {
    \legacy_if:nTF { morandi@bionic }
      {
        \seq_set_split:Nnn \l__morandi_words_seq { ~ } {#1}
        \int_zero:N \l__morandi_index_int
        \seq_map_inline:Nn \l__morandi_words_seq
          {
            \int_compare:nNnF \l__morandi_index_int = 0 { \c_space_tl }
            \int_compare:nNnTF
              { \int_mod:nn { \l__morandi_index_int } { \int_max:nn { \l__morandi_every_int } { 1 } } } = 0
              { \__morandi_bionic_word:n {##1} }
              { ##1 }
            \int_incr:N \l__morandi_index_int
          }
      }
      { #1 }
  }
\ExplSyntaxOff

%% ---------------------------------------------------------------------
%% 分段休息 Break points
%%   長內容之間插入「休息點」，提醒讀者可以停一下、喝口水。
%% ---------------------------------------------------------------------
\newcommand\takeabreak[1][\breakname]{%
  \par\vspace{1.2em}%
  \begin{center}
    \begin{tikzpicture}
      \foreach \c [count=\i] in {mdRose,mdSage,mdBlue,mdTerm,mdMuted}
        \fill[\c] (\i*0.45,0) circle (2.6pt);
    \end{tikzpicture}\\[0.2em]
    {\small\color{TextSoft}#1}
  \end{center}
  \vspace{0.6em}\par}

%% 輕量分隔線
\newcommand\chunkbreak{\par\vspace{0.4em}%
  {\centering\color{RuleColor}\rule{0.3\linewidth}{0.8pt}\par}\vspace{0.4em}}

%% ---------------------------------------------------------------------
%% 表格 Tables：斑馬紋讓視線不容易跑錯列
%% ---------------------------------------------------------------------
\newcommand\zebra{\rowcolors{2}{TableRowBg}{PageBg}}
\newcommand\headerrow{\rowcolor{TableHeadBg}}
% 表頭文字（白字粗體），搭配 \headerrow 使用
\newcommand\headcell[1]{{\color{TableHeadText}\bfseries #1}}
\AtBeginDocument{\arrayrulecolor{RuleColor}}

%% 圖說 Captions：暖灰小字，標籤用次標題色
\DeclareCaptionFont{morandimuted}{\color{TextSoft}}
\DeclareCaptionFont{morandilabel}{\color{SubHeading}}
\captionsetup{font={small,morandimuted}, labelfont={bf,morandilabel}}

%% ---------------------------------------------------------------------
%% 介面語言 Interface language
%%   預設繁體中文；加上 english 選項則全部改成英文。
%%   也可以在導言區用 \renewcommand\keypointname{...} 個別覆寫。
%% ---------------------------------------------------------------------
\ifmorandi@english
  \newcommand\tldrname{TL;DR}
  \newcommand\goalsname{Goals}
  \newcommand\keypointname{Key Point}
  \newcommand\definitionname{Definition}
  \newcommand\examplename{Example}
  \newcommand\tipname{Tip}
  \newcommand\warningname{Caution}
  \newcommand\questionname{Think About It}
  \newcommand\summaryname{Recap}
  \newcommand\bigideaname{Big Idea}
  \newcommand\derivationname{Derivation}
  \newcommand\selfcheckname{Self-Check}
  \newcommand\termsname{Key Terms}
  \newcommand\breakname{Take a short break, then keep going}
  \newcommand\readingtimename{Reading time}
  \newcommand\morandi@titlesep{:\space}
\else
  \newcommand\tldrname{一句話摘要}
  \newcommand\goalsname{本節目標}
  \newcommand\keypointname{重點}
  \newcommand\definitionname{定義}
  \newcommand\examplename{範例}
  \newcommand\tipname{小提示}
  \newcommand\warningname{注意}
  \newcommand\questionname{想一想}
  \newcommand\summaryname{本節回顧}
  \newcommand\bigideaname{Big idea}
  \newcommand\derivationname{推導}
  \newcommand\selfcheckname{自我檢查}
  \newcommand\termsname{名詞}
  \newcommand\breakname{休息一下，再繼續}
  \newcommand\readingtimename{預估閱讀}
  \newcommand\morandi@titlesep{：}
  \renewcommand\contentsname{目錄}
  \renewcommand\figurename{圖}
  \renewcommand\tablename{表}
  \renewcommand\refname{參考資料}
  \renewcommand\abstractname{摘要}
  \renewcommand\today{\the\year 年 \the\month 月 \the\day 日}
\fi

\endinput

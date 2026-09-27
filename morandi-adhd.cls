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
%%   其他選項會傳給 article
%% ---------------------------------------------------------------------
\newif\ifmorandi@dark     \morandi@darkfalse
\newif\ifmorandi@print    \morandi@printfalse
\newif\ifmorandi@bionic   \morandi@bionictrue
\newif\ifmorandi@compact  \morandi@compactfalse

\DeclareOption{dark}{\morandi@darktrue}
\DeclareOption{print}{\morandi@printtrue}
\DeclareOption{bionic}{\morandi@bionictrue}
\DeclareOption{nobionic}{\morandi@bionicfalse}
\DeclareOption{compact}{\morandi@compacttrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[a4paper,11pt]{article}

%% ---------------------------------------------------------------------
%% 套件 Packages
%% ---------------------------------------------------------------------
\RequirePackage{fontspec}
\RequirePackage[slantfont,boldfont]{xeCJK}
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
\RequirePackage{hyperref}

%% ---------------------------------------------------------------------
%% 莫蘭迪色盤 Morandi palette
%%   低彩度、帶灰調的顏色：降低視覺刺激，但仍保有足夠的區辨度，
%%   讓不同類型的資訊一眼就能分辨。
%% ---------------------------------------------------------------------
\definecolor{MorandiRose}   {HTML}{C4A4A0} % 灰玫瑰：重點
\definecolor{MorandiSage}   {HTML}{9EAE95} % 鼠尾草綠：範例、完成
\definecolor{MorandiBlue}   {HTML}{8DA1B0} % 霧霾藍：定義、資訊
\definecolor{MorandiSand}   {HTML}{C9B79C} % 奶茶沙：提示
\definecolor{MorandiMauve}  {HTML}{A698AE} % 灰紫：思考、問題
\definecolor{MorandiClay}   {HTML}{B98B7D} % 陶土紅：注意、警告
\definecolor{MorandiStone}  {HTML}{A9A39A} % 岩灰：輔助線條

\ifmorandi@dark
  % 深色模式：深灰藍底、米白字（避免純黑純白的強烈對比）
  \definecolor{PageBg}   {HTML}{2E3136}
  \definecolor{TextMain} {HTML}{E4DED6}
  \definecolor{TextSoft} {HTML}{B5AFA7}
  \definecolor{Heading}  {HTML}{E9D7D2}
  \definecolor{BoxBgMix} {HTML}{2E3136}
  \def\morandi@boxmix{22}
\else
  % 淺色模式：偏白的暖白底、深灰字（比純白底柔和，又比米色更清爽）
  \definecolor{PageBg}   {HTML}{FBFAF7}
  \definecolor{TextMain} {HTML}{3F3B38}
  \definecolor{TextSoft} {HTML}{7A736C}
  \definecolor{Heading}  {HTML}{6E5A57}
  \definecolor{BoxBgMix} {HTML}{FFFFFF}
  \def\morandi@boxmix{22}
\fi
\ifmorandi@print
  \definecolor{PageBg}  {HTML}{FFFFFF}
  \definecolor{BoxBgMix}{HTML}{FFFFFF}
\fi

\colorlet{LinkColor}{MorandiBlue!70!TextMain}
\colorlet{HighlightColor}{MorandiSand!60!PageBg}

\pagecolor{PageBg}
\color{TextMain}

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
\morandi@pickfont{\setCJKmainfont}
  {Noto Sans CJK TC,Noto Sans TC,Source Han Sans TC,PingFang TC,Microsoft JhengHei,Heiti TC}
  {\ClassWarningNoLine{morandi-adhd}{找不到繁體中文黑體，請自行設定 \string\setCJKmainfont}}
\morandi@pickfont{\setCJKsansfont}
  {Noto Sans CJK TC,Noto Sans TC,Source Han Sans TC,PingFang TC,Microsoft JhengHei,Heiti TC}
  {}
\morandi@pickfont{\setCJKmonofont}
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
\AtBeginDocument{\RaggedRight}
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
  {\tikz[baseline=(n.base)]\node[fill=MorandiRose, text=white, rounded corners=3pt,
     inner xsep=6pt, inner ysep=3pt, font=\large\bfseries](n){\thesection};}
  {0.6em}{}
  [\vspace{-0.72\baselineskip}{\color{MorandiRose!60!PageBg}\rule{\linewidth}{1.2pt}}]
\titleformat{\subsection}
  {\needspace{5\baselineskip}\large\bfseries\color{Heading}}
  {{\color{MorandiSage}\rule[-0.15em]{4pt}{1.1em}}\hspace{0.5em}\thesubsection}
  {0.6em}{}
\titleformat{\subsubsection}
  {\normalsize\bfseries\color{Heading}}
  {{\color{MorandiBlue}\ding{110}}\hspace{0.3em}\thesubsubsection}
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
  {\contentslabel[{\color{MorandiRose}\thecontentslabel}]{2em}}
  {}{\titlerule*[0.6pc]{\color{MorandiStone}.}\contentspage}
\titlecontents{subsection}[4.6em]
  {\color{TextMain}}
  {\contentslabel[{\color{MorandiSage!80!TextMain}\thecontentslabel}]{2.6em}}
  {}{\titlerule*[0.6pc]{\color{MorandiStone}.}\contentspage}

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
    \fill[MorandiStone!35!PageBg, rounded corners=1.5pt] (0,0) rectangle (\linewidth,3pt);
    \fill[MorandiSage, rounded corners=1.5pt] (0,0) rectangle (\morandi@ratio\linewidth,3pt);
  \end{tikzpicture}}

\pagestyle{fancy}
\fancyhf{}
\renewcommand\headrulewidth{0pt}
\fancyhead[L]{\small\color{TextSoft}\leftmark}
\fancyhead[R]{\small\color{TextSoft}\@title}
\fancyfoot[C]{\morandi@progressbar\\[2pt]
  \small\color{TextSoft}\thepage\ /\ \pageref*{LastPage}}
\fancypagestyle{plain}{\fancyhf{}\fancyfoot[C]{\morandi@progressbar\\[2pt]
  \small\color{TextSoft}\thepage\ /\ \pageref*{LastPage}}}
\renewcommand\sectionmark[1]{\markboth{\thesection\quad #1}{}}
\setlength{\headheight}{16pt}

%% ---------------------------------------------------------------------
%% 封面標題 Title
%% ---------------------------------------------------------------------
\newcommand\subtitle[1]{\gdef\morandi@subtitle{#1}}
\gdef\morandi@subtitle{}
\newcommand\readingtime[1]{\gdef\morandi@readingtime{#1}}
\gdef\morandi@readingtime{}

\renewcommand\maketitle{%
  \thispagestyle{plain}%
  \begin{tcolorbox}[enhanced, colback=MorandiRose!25!PageBg, colframe=MorandiRose!25!PageBg,
      arc=6pt, boxrule=0pt, left=14pt, right=14pt, top=14pt, bottom=12pt,
      borderline west={5pt}{0pt}{MorandiRose}]
    {\LARGE\bfseries\color{Heading}\@title\par}
    \ifx\morandi@subtitle\@empty\else
      \vspace{0.3em}{\large\color{TextSoft}\morandi@subtitle\par}\fi
    \vspace{0.8em}
    {\small\color{TextSoft}\@author
     \ifx\@date\@empty\else\quad|\quad\@date\fi
     \ifx\morandi@readingtime\@empty\else\quad|\quad 預估閱讀：\morandi@readingtime\fi\par}
  \end{tcolorbox}
  \vspace{0.5em}}

%% ---------------------------------------------------------------------
%% 資訊方塊 Callout boxes
%%   不同顏色 = 不同用途。固定的顏色語意讓大腦不必每次重新判讀。
%%     tldr      一句話摘要（放在最前面）
%%     goals     本節目標
%%     keypoint  重點
%%     definition 定義
%%     example   範例
%%     tip       小提示
%%     warning   注意
%%     question  想一想
%%     summary   本節回顧
%% ---------------------------------------------------------------------
\tcbset{morandi/.style={
    enhanced, breakable, arc=4pt, boxrule=0pt,
    left=10pt, right=10pt, top=6pt, bottom=6pt,
    before skip=1.1em, after skip=1.3em,
    fonttitle=\bfseries\small, coltitle=white,
    colupper=TextMain,
    attach boxed title to top left={xshift=8pt, yshift=-7pt},
    boxed title style={arc=3pt, boxrule=0pt},
  }}

% \morandi@newbox{環境名}{顏色}{預設標題}
\newcommand\morandi@newbox[3]{%
  \newtcolorbox{#1}[1][]{morandi,
    colback=#2!\morandi@boxmix!BoxBgMix,
    borderline west={3pt}{0pt}{#2},
    boxed title style={colback=#2},
    title={#3\if\relax\detokenize{##1}\relax\else：##1\fi},
    top=12pt}}

\newcommand\tldrname{一句話摘要}
\newcommand\goalsname{本節目標}
\newcommand\keypointname{重點}
\newcommand\definitionname{定義}
\newcommand\examplename{範例}
\newcommand\tipname{小提示}
\newcommand\warningname{注意}
\newcommand\questionname{想一想}
\newcommand\summaryname{本節回顧}

\morandi@newbox{keypoint}  {MorandiRose} {\keypointname}
\morandi@newbox{definition}{MorandiBlue} {\definitionname}
\morandi@newbox{example}   {MorandiSage} {\examplename}
\morandi@newbox{tip}       {MorandiSand} {\tipname}
\morandi@newbox{warning}   {MorandiClay} {\warningname}
\morandi@newbox{question}  {MorandiMauve}{\questionname}
\morandi@newbox{summary}   {MorandiSage} {\summaryname}
\morandi@newbox{goals}     {MorandiBlue} {\goalsname}

% TL;DR：無外框的大字條
\newtcolorbox{tldr}{morandi, colback=MorandiSand!30!BoxBgMix,
  borderline west={5pt}{0pt}{MorandiSand},
  fontupper=\large, top=8pt, bottom=8pt, left=12pt,
  before upper=\morandi@tldrlabel}
\newcommand\morandi@tldrlabel{\textbf{\textcolor{MorandiSand!55!TextMain}{\tldrname}}\quad}

%% ---------------------------------------------------------------------
%% 清單 Lists
%%   項目間距加大；checklist 讓任務可以一格一格打勾，
%%   把大任務拆成小步驟，對執行功能較弱的讀者特別有幫助。
%% ---------------------------------------------------------------------
\setlist{itemsep=0.35em, topsep=0.4em, leftmargin=1.8em}
\setlist[itemize,1]{label={\color{MorandiRose}\ding{108}}, font=\scriptsize}
\setlist[itemize,2]{label={\color{MorandiSage}\ding{109}}, font=\scriptsize}
\setlist[itemize,3]{label={\color{MorandiBlue}\textbullet}}
\setlist[enumerate,1]{label={\color{MorandiRose!80!TextMain}\bfseries\arabic*.}}
\setlist[enumerate,2]{label={\color{MorandiSage!80!TextMain}\bfseries(\alph*)}}

\newcommand\morandi@unchecked{{\color{MorandiStone}\large\ding{113}}}
\newcommand\morandi@checked{{\color{MorandiSage}\large\ding{51}}}
\newlist{checklist}{itemize}{2}
\setlist[checklist]{label=\morandi@unchecked, leftmargin=2em, itemsep=0.1em}
\newcommand\done{\item[\morandi@checked]}

% steps：大圓圈編號的步驟
\newlist{steps}{enumerate}{1}
\DeclareRobustCommand\morandi@stepnum[1]{\tikz[baseline=(c.base)]\node[circle,
    fill=MorandiBlue, text=white, font=\small\bfseries, inner sep=0pt,
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
\newcommand\key[1]{{\bfseries\color{MorandiClay!85!TextMain}#1}}
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
    { \bfseries \tl_range:nnn {#1} { 1 } { \l__morandi_letters_int } }
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
\newcommand\breakname{休息一下，再繼續}
\newcommand\takeabreak[1][\breakname]{%
  \par\vspace{1.2em}%
  \begin{center}
    \begin{tikzpicture}
      \foreach \c [count=\i] in {MorandiRose,MorandiSand,MorandiSage,MorandiBlue,MorandiMauve}
        \fill[\c] (\i*0.45,0) circle (2.6pt);
    \end{tikzpicture}\\[0.2em]
    {\small\color{TextSoft}#1}
  \end{center}
  \vspace{0.6em}\par}

%% 輕量分隔線
\newcommand\chunkbreak{\par\vspace{0.4em}%
  {\centering\color{MorandiStone!60!PageBg}\rule{0.3\linewidth}{0.8pt}\par}\vspace{0.4em}}

%% ---------------------------------------------------------------------
%% 表格 Tables：斑馬紋讓視線不容易跑錯列
%% ---------------------------------------------------------------------
\newcommand\zebra{\rowcolors{2}{MorandiStone!14!PageBg}{PageBg}}
\newcommand\headerrow{\rowcolor{MorandiBlue!35!PageBg}}

%% ---------------------------------------------------------------------
%% 目錄標題 & 其他中文化
%% ---------------------------------------------------------------------
\renewcommand\contentsname{目錄}
\renewcommand\figurename{圖}
\renewcommand\tablename{表}
\renewcommand\refname{參考資料}
\renewcommand\abstractname{摘要}
\renewcommand\today{\the\year 年 \the\month 月 \the\day 日}

\endinput

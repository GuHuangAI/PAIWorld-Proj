%%======== IAII-PAI Paper Template ========
%% Based on ByteDance Seed template style
%% Adapted for Institute of AI for Industries, Chinese Academy of Sciences

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iaii_pai}[2025/06/13 IAII-PAI Paper Template]
\LoadClassWithOptions{article}
\pdfoutput=1

\RequirePackage[table,dvipsnames]{xcolor}

% Layout
\RequirePackage[top=2.75cm, bottom=2.5cm, left=2.5cm, right=2.5cm, columnsep=0.65cm]{geometry}
\RequirePackage{microtype}
\RequirePackage{placeins}
\RequirePackage{hyphenat}
\RequirePackage{setspace}
\RequirePackage{parskip}
\RequirePackage[english]{babel}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{ulem}
\normalem
\DisableLigatures[f]{family=sf*}
\RequirePackage{graphicx}
\RequirePackage{subcaption}

\RequirePackage{booktabs}
\RequirePackage{nicematrix}
\RequirePackage{multirow}
\RequirePackage{bm}
\newcommand{\nm}[1]{#1}
\RequirePackage[most]{tcolorbox}

% Brand colors - IAII blue
\definecolor{paibg}{HTML}{1B4F8A}
\definecolor{paiblue}{HTML}{1B4F8A}
\definecolor{myblue}{RGB}{210, 225, 255}
\definecolor{lightred}{RGB}{255, 182, 193}
\definecolor{lightgreen}{RGB}{144, 238, 144}
\definecolor{lightblue}{RGB}{173, 216, 230}
\definecolor{lightergray}{gray}{0.90}

\newcommand{\paitext}[1]{{\bfseries\color{paiblue} #1}}

% References
\RequirePackage{hyperref}
\RequirePackage[noabbrev,nameinlink]{cleveref}
\hypersetup{
  colorlinks,
  linkcolor=paiblue,
  citecolor=paiblue,
  urlcolor=paiblue
}

\RequirePackage[numbers, sort&compress]{natbib}
\def\bibfont{\small}

\addto{\captionsenglish}{\renewcommand{\refname}{References}}

% Section and caption format
\newcommand{\sectionfont}{\fontsize{12}{10}\selectfont}
\newcommand{\subsectionfont}{\fontsize{11}{10}\selectfont}

\RequirePackage{titlesec}
\titleformat*{\paragraph}{\itshape}
\titleformat*{\section}{\sectionfont\sffamily\bfseries\color{paiblue}}
\titleformat*{\subsection}{\subsectionfont\sffamily\bfseries\color{paiblue}}
\titleformat*{\subsubsection}{\normalsize\sffamily\bfseries\color{paiblue}}

% Bold formatting for captions only (do not override \textbf globally)

\RequirePackage{caption}
\DeclareCaptionLabelSeparator{custom}{}
\DeclareCaptionFormat{custom}{{\sffamily\textbf{#1 #2}} #3}
\captionsetup{singlelinecheck=true,format=custom,labelsep=custom,font=small}
\captionsetup[sub]{singlelinecheck=true,format=custom,labelsep=custom,font=small}

% Font setup - use Latin Modern Sans (no proprietary fonts)
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\renewcommand{\sfdefault}{lmss}
\renewcommand{\rmdefault}{lmr}

% Authors, affiliations, infos
\newcommand\pai@addtolist[5][]{
  \begingroup
    \if\relax#3\relax\def\sep{}\else\def\sep{#5}\fi
    \let\protect\@unexpandable@protect
    \xdef#3{\expandafter{#3}\sep #4[#1]{#2}}%
  \endgroup
}

\newcommand{\authorfont}{\fontsize{12}{14}\selectfont}

\newcommand\authorlist{}
\newcommand\authorformat[2][]{\authorfont {\sffamily #2$^{#1}$}}
\renewcommand\author[2][]{\pai@addtolist[#1]{#2}{\authorlist}{\authorformat}{, }}

\newcommand{\affiliationfont}{\fontsize{10}{12}\selectfont}

\newcommand\affiliationlist{}
\newcommand\affiliationformat[2][]{{\affiliationfont {\sffamily $^{#1}$#2}}}
\newcommand\affiliation[2][]{\pai@addtolist[#1]{#2}{\affiliationlist}{\affiliationformat}{, }}

\newcommand{\contributionfont}{\fontsize{10}{12}\selectfont}

\newcommand\contributionlist{}
\newcommand\contributionformat[2][]{{\contributionfont $^{#1}$#2}}
\newcommand\contribution[2][]{\pai@addtolist[#1]{#2}{\contributionlist}{\contributionformat}{, }}

\newcommand{\checkdatafont}{\fontsize{7.92}{10}\selectfont}

\newcommand\checkdatalist{}
\newcommand\checkdataformat[2][]{{\small {\checkdatafont\sffamily \bfseries #1:} #2}}
\newcommand\checkdata[2][]{\pai@addtolist[#1]{#2}{\checkdatalist}{\checkdataformat}{\par}}

\newcommand{\abstractinfont}{\fontsize{10}{12}\selectfont}

\renewcommand{\abstract}[1]{\def\abstractlist{{\abstractinfont #1}}}
\newcommand{\email}[1]{\href{mailto:#1}{\texttt{#1}}}

\renewcommand\date[1]{\checkdata[Date]{#1}}
\newcommand\correspondence[1]{\checkdata[Correspondence]{#1}}

\newcommand{\titlefont}{\fontsize{17}{20}\selectfont}

\renewcommand{\title}[1]{\newcommand{\titlelist}{\titlefont{\sffamily #1}}}

\newcommand{\abstractfont}{\fontsize{12}{12}\selectfont}

\newcommand{\beginabstract}{\abstractfont{\sffamily\bfseries \paitext{Abstract}\par}}

\newcommand{\beginappendix}{\appendix{\titlefont\sffamily \paitext{Appendix}\par}}

\RequirePackage{tocloft}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsecfont}{\sffamily}
\renewcommand{\cftsecpagefont}{\sffamily\color{paiblue}}
\renewcommand{\cfttoctitlefont}{\sffamily\sectionfont\color{paiblue}}

%%======== Header and Footer Content ========
\fancypagestyle{firststyle}{
    \fancyhead[R]{
        \vskip 4mm
    \includegraphics[height=12mm]{logos/pai_logo.jpg}
    }
    \fancyhead[L]{
        \vskip 4mm
    \includegraphics[height=12mm]{logos/iaii_logo.png}
    }
}

\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Rules for title box at top of first page
\newcommand{\@toptitlebar}{
  {\color{paiblue}\hrule height 0.5pt}
  \vskip 6mm
}
\newcommand{\@bottomtitlebar}{
  \vskip 6mm
  {\color{paiblue}\hrule height 0.5pt}
}

% Titlebox
\newcommand{\mymaketitle}{%
  \tcbset{enhanced}
  \tcbset{left=8mm}
  \tcbset{right=8mm}
  \tcbset{top=6mm}
  \tcbset{bottom=6mm}
  \tcbset{colback=white}
  \tcbset{colframe=paibg}
  \tcbset{boxrule=0.5pt}
  \tcbset{before skip=0pt}
  \tcbset{grow to left by=1.5pt}
  \tcbset{grow to right by=1.5pt}
  \tcbset{arc=2.5mm}
      {
      \setlength{\parskip}{0mm}
      \centering
      \nohyphens

      {
      \@toptitlebar
        \titlelist\par
         \@bottomtitlebar
      }
      \vskip 6mm
      \authorlist
      \vskip 3mm
      \affiliationlist\par
      \vskip 3mm
      \contributionlist\par
    }
   \vskip 6mm

  \begin{tcolorbox}
    \setlength{\parindent}{0cm}
    \setlength{\parskip}{0cm}

    \begin{center}
        \beginabstract
        \vskip 3mm
    \end{center}

    \abstractlist\par
    \vskip 3mm
    {
      \setlength{\parskip}{0cm}
      \ifdefempty{\checkdatalist}{\vspace*{0.65cm}}{\checkdatalist\par}
    }
  \end{tcolorbox}
  \tcbset{reset}
  \FloatBarrier

  \thispagestyle{firststyle}
}

\if@twocolumn%
\renewcommand{\maketitle}{
\twocolumn[%
 \vskip 3mm
  \mymaketitle
  \vskip 8mm
]
}%
\else%
\renewcommand{\maketitle}{
  \mymaketitle
  \vskip 8mm
}%
\fi

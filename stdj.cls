\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{stdj}[2023/09/05 Science and Technology Developlment Journal article class]
\LoadClass[a4paper,9pt]{extarticle}

\RequirePackage{calc}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{adjustbox}
\RequirePackage[most]{tcolorbox}
\RequirePackage{tikz}
\RequirePackage{authblk}
\RequirePackage{xcolor}
\RequirePackage{multicol}
\RequirePackage{fancyhdr}
\RequirePackage[absolute]{textpos}
\RequirePackage{parskip}
\RequirePackage{setspace}
\RequirePackage{enumitem}
\RequirePackage[hidelinks,bookmarksopen]{hyperref}
\RequirePackage{lastpage}
\RequirePackage{qrcode}
\RequirePackage{lipsum}
\RequirePackage{layout}
\RequirePackage{bookmark}
\RequirePackage{titlesec}
\RequirePackage[english]{babel}
\RequirePackage{fontspec}
\RequirePackage{ifthen, everypage}
\RequirePackage{afterpage}

\graphicspath{
    {./images/}
}

\definecolor{TitleColor}{RGB}{0, 0, 153}
\definecolor{BackgroundColor}{RGB}{231, 236, 247}

\directlua{require("stdj")}

\newlength{\margin}
\setlength{\margin}{2cm}

\newlength{\lmargin}
\setlength{\lmargin}{7cm}

\newlength{\bmargin}
\setlength{\bmargin}{2.5cm}

\newlength{\shift}
\setlength{\shift}{\margin - \lmargin}

% https://www.overleaf.com/learn/latex/Page_size_and_margins
\geometry{a4paper, margin=\margin, lmargin=\lmargin, bmargin=\bmargin}

\newcommand{\twodigits}[1]{%
    \ifnum#1<10 0#1\else #1\fi
}

\newcommand{\AbstractLabel}{ABSTRACT}
\newcommand{\AbstractText}{\lipsum[1-2]}
\newcommand{\KeywordsLabel}{Keywords}
\newcommand{\KeywordsText}{\lipsum[1][1-2]}
\newcommand{\CorrespondenceLabel}{Correspondence}
\newcommand{\ArticleHistoryLabel}{History}
\newcommand{\ArticleReceivedLabel}{Received}
\newcommand{\ArticleAccpetedLabel}{Accepted}
\newcommand{\ArticlePublishedLabel}{Published}
\newcommand{\ArticleReceivedDate}{\the\year{}-\twodigits{\the\month}-\twodigits{\the\day}}
\newcommand{\ArticleAccpetedDate}{\the\year{}-\twodigits{\the\month}-\twodigits{\the\day}}
\newcommand{\ArticlePublishedDate}{\the\year{}-\twodigits{\the\month}-\twodigits{\the\day}}
\newcommand{\ArticleDOILabel}{DOI}
\newcommand{\ArticleDOIURL}{https://doi.org/10.1000/demo\_DOI}
\newcommand{\ArticleURL}{http://stdj.scienceandtechnology.com.vn/index.php/stdj}
\newcommand{\ArticleCopyrightLabel}{Copyright}
\newcommand{\ArticlePublisher}{VNUHCM Press}
\newcommand{\ArticleLicenseDescription}{This is an open- access article distributed under the terms of the Creative Commons Attribution 4.0 International license.}
\newcommand{\CiteThisArticleLabel}{Cite this article}
\newcommand{\CiteAuthors}{\empty}
\newcommand{\JournalAbbreviation}{\empty}
\newcommand{\ReferencesLabel}{References}

\newcommand{\FromPageNumber}{0}
\newcommand{\ToPageNumber}{0}

\newcommand{\IssueNumber}{1}
\newcommand{\VolumeNumber}{1}
\newcommand{\VolumeYear}{\the\year}
\newcommand{\makejournaltitle}{%
    {\sffamily\small%
        \textbf{%
            \textit{%
                Science \& Technology Development Journal \VolumeYear{}, \VolumeNumber{}(\IssueNumber{}):\FromPageNumber{}-\ToPageNumber{}%
            }
        }
    }
}

\newcommand{\ArticleTitle}{Hello World!}
\newcommand{\ArticleSection}{Natural Sciences}
\newcommand{\ArticleType}{Research Article}
\newcommand{\MakeArticleSection}{
    \raggedleft{%
        \underline{%
            \ArticleSection{}: \ArticleType{}                   
        }
    }
}

\renewcommand{\maketitle}{%
    \noindent%
    {\Huge\bfseries\color{TitleColor}\sffamily\ArticleTitle}
}

\newcommand{\authors}{
    \noindent%
    {\sffamily\large\bfseries\color{TitleColor}\directlua{tex.sprint(get_authors(authors, author_affiliation_indexes))}}
}

\newcommand{\affiliations}{%
    \noindent%
    \textit{{\footnotesize\directlua{tex.sprint(get_affiliations(affiliations))}}}
}

\newenvironment{SideSection}[1]{%
    \noindent%
    {\ttfamily\footnotesize\textcolor{TitleColor}{\textbf{#1}}}\par%
    \noindent\footnotesize%
    \ttfamily%
}{}

\newcommand{\Correspondences}[3][\CorrespondenceLabel]{%
    \noindent%
    \raggedright \directlua{tex.sprint(get_correspondences(authors, "\luaescapestring{\unexpanded{#1}}", "#2", "#3"))}%
}

\newcommand{\ArticleHistory}{%
    \begin{SideSection}{\ArticleHistoryLabel}%
        \begin{itemize}[leftmargin=*]%
            \item\ArticleReceivedLabel: \ArticleReceivedDate
            \item\ArticleAccpetedLabel: \ArticleAccpetedDate
            \item\ArticlePublishedLabel: \ArticlePublishedDate
        \end{itemize}
    \end{SideSection}%
}

\newcommand{\ArticleDOI}{%
    \begin{SideSection}{\ArticleDOILabel}%
        \href{\ArticleDOIURL}{\url{\ArticleDOIURL}}\par%
        \href{\ArticleDOIURL}{\includegraphics[scale=0.45, keepaspectratio]{CROSSMARK_Color_horizontal}}%
    \end{SideSection}
}

\newcommand{\JournalCopyright}{%
    \begin{SideSection}{\ArticleCopyrightLabel}%
        \copyright\relax\hspace{4pt}\ArticlePublisher\relax. \ArticleLicenseDescription\relax%
    \end{SideSection}
}

\newcommand{\CiteText}{%
    \colorbox{BackgroundColor}{%
        \begin{minipage}{\textwidth}%
            \sffamily%
            \textbf{\CiteThisArticleLabel:} \CiteAuthors. \textbf{\ArticleTitle}. \textit{\JournalAbbreviation}. \VolumeYear; \VolumeNumber(\IssueNumber):\FromPageNumber{}-\ToPageNumber{}.
        \end{minipage}
    }
}

\fancypagestyle{FancyFirstPage}{%
    \fancyhf{}%
    %\renewcommand{\headwidth}{\dimexpr\textwidth+1cm}%
    \renewcommand{\headrulewidth}{0pt}%
    \fancyheadoffset[lh]{-\shift}
    \fancyhead[L]{%
        \makejournaltitle%
        \newline
        \begin{minipage}[t]{.5\textwidth}%
            \includegraphics[scale=0.06,keepaspectratio]{OpenAccessLogo_153x240}%
            \hspace{2pt}%
            \raisebox{0.5\height}{\rmfamily\color{gray}Open Access Full Text Article}%
        \end{minipage}%
    }%
    \fancyhead[R]{%
        \underline{%
            \textit{%
                {\rmfamily\large\bfseries\ArticleSection{}: \ArticleType{}}%
            }
        }
    }
    \fancyfoot[L]{%
        \CiteText%
    }
    \fancyfoot[R]{%
        \par%
        \vspace{0.8cm}%
        {\sffamily\bfseries\color{TitleColor}\thepage}
    }
}

\fancypagestyle{FancyNotFirstPage}{%
    \fancyhf{}%
    %\renewcommand{\headwidth}{\textwidth}%
    \fancyheadoffset[lh]{-\shift}
    %\fancyheadoffset[lh,rh]{0pt}
    \fancyhead[L]{%
        \makejournaltitle
    }
    \fancyfoot[L]{\ifodd\thepage{{\sffamily\bfseries\color{TitleColor}\thepage}}\else{}\fi}
    \fancyfoot[R]{\ifodd\thepage{}\else{{\sffamily\bfseries\color{TitleColor}\thepage}}\fi}
}

\newcommand{\MakeAbstract}{%
    \noindent%
    \hspace{\shift}%
    \begin{minipage}{\textwidth+-\shift}%
        \maketitle%
        \par\vspace{0.5cm}%
        \authors%
    \end{minipage}\par
    \vspace{0.5cm}
    \noindent%
    \hspace{\shift}%
    \begin{minipage}[t]{-\shift - 0.2cm}%
        \vspace{0pt}%
        \begin{center}%
            %\hspace{10pt}%
            %\includegraphics[width=2cm,keepaspectratio]{Article_QR_Code}%
            \qrcode{\ArticleURL}%
            %\vspace{-10pt}
            \par%
            %\vspace{-5pt}%
            {\tiny Use your smartphone to scan this QR code and download this article}
        \end{center}
    \end{minipage}%
    \hspace{0.2cm}%
    {\setlength{\fboxsep}{10pt}%
        \colorbox{BackgroundColor}{%
            \begin{minipage}[t]{\textwidth}%
                \vspace{0pt}%
                {\sffamily\Large\bfseries\color{TitleColor}\AbstractLabel}\par%
                \vspace{3pt}%
                {\AbstractText}\par%
                {\bfseries\KeywordsLabel:} \KeywordsText
            \end{minipage}
    }}
}

\newcommand{\MakeSideBar}{%
    \noindent%
    \begin{textblock*}{-\shift-0.2cm}(0cm, 0cm)%
        \noindent%
        \begin{minipage}[t][\paperheight-\margin+1.4cm][t]{-\shift-0.2cm}%
            \vspace*{\fill}%
            \rule{-\shift-0.2cm}{0.5pt}\par%
            \affiliations\par\vspace{0.5cm}%
            \Correspondences[\CorrespondenceLabel]{0.5cm}{0.25cm}\par\vspace{0.5cm}%
            \ArticleHistory\par\vspace{0.5cm}%
            \ArticleDOI\par\vspace{0.5cm}%
            \JournalCopyright
        \end{minipage}
    \end{textblock*}
}

\titleformat{\section}{\normalbaselines\sffamily\bfseries\Large\color{TitleColor}}{\thesection}{0pt}{}
\titleformat{\subsection}{\normalbaselines\sffamily\bfseries\normalsize\color{TitleColor}}{\thesubsection}{0pt}{}
\titlespacing{\section}{0pt}{\parskip}{0.5\parskip}
\titlespacing{\subsection}{0pt}{\parskip}{0.5\parskip}

\setmainfont{MinionPro}[
    Path=./fonts/MinionPro/,
    Extension = .otf,
    UprightFont = *-Regular,
    BoldFont = *-Bold,
    ItalicFont = *-It,
    BoldItalicFont = *-BoldIt
]

\setsansfont{MyriadPro}[
    Path=./fonts/MyriadPro/,
    Extension = .otf,
    UprightFont = *-Regular,
    BoldFont = *-Bold,
    ItalicFont = *-It,
    BoldItalicFont = *-BoldIt
]

\setmonofont{UniversLTStd}[
    Path=./fonts/UniversLTStd/,
    Extension = .otf,
    UprightFont = *-Light,
    BoldFont = *-Bold,
    ItalicFont = *-ExObl,
    BoldItalicFont = *-BlackObl
]

%\rmdefault: Serif
%\sfdefault: Sans Serif
%\ttdefault: Monospace

\renewcommand{\familydefault}{\rmdefault}

\renewcommand{\refname}{\ReferencesLabel}
\bibliographystyle{numeric}

\newcommand{\ChangeGeometryOnNotFirstPage}{%
    \ifthenelse{\value{page} > 1}%
        {%
            
        }%
        {}%
}
\AddEverypageHook{\ChangeGeometryOnNotFirstPage{}}

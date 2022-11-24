\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tufte-style-thesis}[]


%	K E Y V A L  O P T I O N S
%

\RequirePackage{kvoptions}
\RequirePackage{xifthen}
\RequirePackage{etoolbox}

\SetupKeyvalOptions{
    family = opt,
    prefix = opt@,
}

\DeclareStringOption[regular]{fonts}
\DeclareStringOption[side]{notes}
\DeclareStringOption[number]{notesymbol}
\DeclareStringOption[headings]{headers}
\DeclareStringOption[page]{title}
\DeclareStringOption[subsection]{numdepth}
\DeclareStringOption[subsection]{tocdepth}
\DeclareStringOption[perchapter]{floats}
\DeclareStringOption[]{stretch}
\DeclareStringOption[boxey]{flow}
\DeclareBoolOption[true]{color}
\DeclareComplementaryOption{black}{color}
\DeclareStringOption[indented]{paragraphs}
\DeclareStringOption[none]{bibliography}
\DeclareStringOption[default]{toc}
\DeclareBoolOption[false]{glossary}
\DeclareBoolOption[false]{index}
\DeclareBoolOption[false]{code}
\DeclareBoolOption[false]{science}
\DeclareBoolOption[true]{colophon}


% declare void options and pass them to book class
% (basically redefining the default book options and re-passing them to the class so that no option is removed)
\newcommand{\inheritvoption}[2][]{\DeclareVoidOption{#2}{#1\PassOptionsToClass{#2}{book}}}

\inheritvoption{10pt}
\inheritvoption{11pt}
\inheritvoption{12pt}

\inheritvoption{letterpaper}
\inheritvoption{executiverpaper}
\inheritvoption{legalpaper}
\inheritvoption{a4paper}
\inheritvoption{b5paper}

\inheritvoption{draft}

\newif\if@twocolumn\@twocolumnfalse
\inheritvoption[\@twocolumntrue]{twocolumn}

\newif\if@twoside\@twosidetrue
\newif\if@oneside\@onesidefalse
\inheritvoption[\@twosidetrue\@onesidefalse]{twoside}
\inheritvoption[\@twosidefalse\@onesidetrue]{oneside}

\inheritvoption{fleqn}

\inheritvoption{leqno}

\inheritvoption{landscape}

\inheritvoption{titlepage}
\inheritvoption{notitlepage}

\inheritvoption{openany}
\inheritvoption{openright}

\ProcessKeyvalOptions*
\LoadClass{book}

% Process keyval options
%

% fonts
\newif\if@ftcasual\@ftcasualfalse
\newif\if@ftsemicasual\@ftsemicasualfalse
\newif\if@ftregular\@ftregularfalse
\newif\if@ftfullserif\@ftfullseriffalse
\newif\if@ftpedantic\@ftpedanticfalse
\newif\if@ftvanilla\@ftvanillafalse
\ifdefstring{\opt@fonts}{casual}{\@ftcasualtrue}{}
\ifdefstring{\opt@fonts}{semicasual}{\@ftsemicasualtrue}{}
\ifdefstring{\opt@fonts}{regular}{\@ftregulartrue}{}
\ifdefstring{\opt@fonts}{fullserif}{\@ftfullseriftrue}{}
\ifdefstring{\opt@fonts}{pedantic}{\@ftpedantictrue}{}
\ifdefstring{\opt@fonts}{vanilla}{\@ftvanillatrue}{}

\newif\if@libertine\@libertinefalse
\RequirePackage[T1]{fontenc}
\if@ftcasual
    \RequirePackage[default, osf]{sourcesanspro}
	\RequirePackage[]{sourcecodepro}
\else
	\if@ftsemicasual
		\RequirePackage[osf]{libertinus}    % main font
		\RequirePackage{libertinust1math}
		\RequirePackage[osf]{sourcesanspro}	% sans font
		\RequirePackage[
			scale=.86
		]{sourcecodepro}
	\else
		\if@ftregular
			\RequirePackage[osf]{libertinus}	% main font
			\RequirePackage{libertinust1math}
			\RequirePackage[osf]{sourcesanspro}	% sans font
			\RequirePackage[
				scale=.86
			]{sourcecodepro}
			\@libertinetrue
		\else
			\if@ftfullserif
				\RequirePackage[osf]{libertinus}	% main font
				\RequirePackage{libertinust1math}
				\RequirePackage[osf]{sourcesanspro}	% sans font
				\RequirePackage[
					scale=.86
				]{sourcecodepro}
				\@libertinetrue
			\else
				\if@ftpedantic
					\RequirePackage{ebgaramond}
					\RequirePackage{ebgaramond-maths}
					\usepackage[osf, scale=.95]{biolinum}
					\RequirePackage[
						defaultmono,
						scale=.79,
					]{droidsansmono}
					\@ftfullseriftrue
				\else
					\if@ftvanilla
						\RequirePackage{lmodern}
					\else
						\ClassWarning{keyval}{Don't know any font setting matching this "\opt@fonts" given in preamble. Possibilities are : casual, regular, pedantic, vanilla. I'll continue with regular}
						\RequirePackage[osf]{libertinus}	% main font
						\RequirePackage{libertinust1math}
						\RequirePackage[osf]{sourcesanspro}		% sans font
						\RequirePackage[
							scale=.86
						]{sourcecodepro}
						\@ftregulartrue
						\@libertinetrue
					\fi
				\fi
			\fi
		\fi
	\fi
\fi

% notes
\newif\if@notesfoot\@notesfootfalse
\newif\if@notesside\@notessidefalse
\ifdefstring{\opt@notes}{foot}{\@notesfoottrue}{}
\ifdefstring{\opt@notes}{side}{\@notessidetrue}{}


% flow
\newif\if@flragged\@flraggedfalse
\newif\if@flboxey\@flboxeyfalse
\ifdefstring{\opt@flow}{ragged}{\@flraggedtrue}{}
\ifdefstring{\opt@flow}{boxey}{\@flboxeytrue}{}

% biblio	-make more options like choose the style ?
%	unnumbered : \parentcite{key} -> (author year)
%			     \textcite{key}   -> author (year)
%
\newif\if@bibexists\@bibexistsfalse
\newif\if@bibnumbered\@bibnumberedfalse
\ifdefstring{\opt@bibliography}{none}{\@bibexistsfalse}{}
\ifdefstring{\opt@bibliography}{numbered}{\@bibexiststrue\@bibnumberedtrue}{}
\ifdefstring{\opt@bibliography}{unnumbered}{\@bibexiststrue\@bibnumberedfalse}{}

\PassOptionsToPackage{
	backend 	= biber,
	isbn		= false,
	doi			= false,
	autocite	= superscript,
	sorting		= none,
	bibencoding = utf8,
}{biblatex}

\if@bibnumbered %cite with \notecite{}
	\PassOptionsToPackage{style = phys,  citestyle = numeric-comp}{biblatex}
\else %bib is unnumbered
	\PassOptionsToPackage{style = windycity, ibidtracker = false}{biblatex}
\fi

%	P A C K A G E   D E F I N I T I O N
%
\RequirePackage{emptypage}		% if a page is empty, is is really empty
\RequirePackage{fullwidth}		% for wide environments
\RequirePackage{sidenotes}		% for margin stuff
\RequirePackage[
	hypcap=false				% hypcap=true spits an error
]{caption}						% for caption formatting
\RequirePackage{ragged2e}		% for better raggedright
\RequirePackage{titlesec}		% header customization
\RequirePackage{titletoc}		% toc customization
\RequirePackage[titles]{tocloft}% lof lot lol customizatios
\RequirePackage{fancyhdr}		% page header customization
\RequirePackage{graphicx}		% for images
\if@ftvanilla
	\RequirePackage{microtype}
\else
	\RequirePackage[
		protrusion=true,
		expansion=true,
		final,
		tracking,
	]{microtype}
\fi
\RequirePackage{xcolor}			% colorz
\RequirePackage{tabularx}		% adaptive columns on tables
\RequirePackage{booktabs}		% better looking tables
\RequirePackage{enumitem}		% better looking lists
\RequirePackage{setspace}
\RequirePackage[
	hidelinks,
    final,
    breaklinks,
    bookmarks,
	pdfusetitle,
]{hyperref}	% automatic references in pdf				% automatic references in pdf
\RequirePackage[strict]{changepage}	% needed by sidenotes
\RequirePackage{placeins}		% for floatbarrier
\RequirePackage{xparse}
\RequirePackage{xpatch}
\if@bibexists
	\RequirePackage{biblatex}
	\RequirePackage{csquotes}
\fi

%	C O L O R  D E F I N I T I O N
%

\makeatletter
\ifopt@color
	\definecolor{Secondary}{HTML}{cc0000}
\else
	\definecolor{Secondary}{HTML}{000000}
\fi
\makeatother


%	N O T E S
%
\RequirePackage{footnote}
\PassOptionsToPackage{multiple, symbol*, perpage}{footmisc}
\makeatletter
\if@notesfoot
    \RequirePackage{footmisc}
    \newlength{\templength}
    \newlength{\textparindent}
    \setlength{\textparindent}{\parindent}
    \makeatletter
    \let \@makefntextorig \@makefntext
        % Saving the original definition so we can reuse it if necessary.
    \newcommand{\@makefntextcustom}[1]{%
        \parindent \textparindent%
        \hspace{-\textparindent}\hspace{-100pt}\makebox[100pt][r]{\thefootnote\enskip}%
        #1%
    }
    \renewcommand{\@makefntext}[1]{\@makefntextcustom{#1}}
\else
    \if@notesside
        \PassOptionsToPackage{ragged, flushmargin, side}{footmisc}
        \RequirePackage{footmisc}
    \else
    \fi
\fi
\makeatother


%	M A R G I N S
%

\newcommand{\sidetext}[1]
{\marginpar{\setstretch{1.0}\RaggedRight\footnotesize\noindent #1 \vskip 4pt}} % ?

\newenvironment{wide}{
\begin{fullwidth}[outermargin=-\marginparwidth-\marginparsep, width=\linewidth+\marginparwidth+\marginparsep]
}%
{
\end{fullwidth}
}


%	F U L L  A R A B I C (titlepage = page1)
%

\makeatletter
\renewcommand{\frontmatter}{\cleardoublepage\@mainmatterfalse}
\renewcommand{\mainmatter}{\cleardoublepage\@mainmattertrue}
\makeatother


%	P A G E  H E A D E R S
%

\RequirePackage{textcase} % for maketextlowercase
\makeatletter
\if@ftfullserif
	\newcommand\markstyle[1]{\textls{\scshape\nouppercase{\MakeTextLowercase{#1}}}}
\else
	\newcommand\markstyle[1]{\textls{\scshape\sffamily\nouppercase{\MakeTextLowercase{#1}}}}
\fi
\if@ftsemicasual
	\newcommand\pagemarkstyle[1]{\markstyle{#1}}
\else
	\newcommand\pagemarkstyle[1]{\normalfont\normalsize#1}
\fi
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\if@twoside
	\fancyhead[LO]{%
		\markstyle{\rightmark}
	}
	\fancyhead[RE]{%
		\markstyle{\leftmark}
	}
	\fancyhead[RO, LE]{%
		\pagemarkstyle{\thepage}
	}%

	\fancypagestyle{plain}{
	\fancyhf{}
	\fancyhead[RO]{\thepage}
	\fancyhead[LE]{\thepage}
	}
\else
	\if@oneside
		\fancyhead[L]{%
		\markstyle{\leftmark}
		}
		\fancyhead[R]{%
		\pagemarkstyle{\thepage}
		}
	\else
		\fancyhead[LO]{%
		\markstyle{\rightmark}
		}
		\fancyhead[RE]{%
			\markstyle{\leftmark}
		}
		\fancyhead[RO, LE]{%
			\pagemarkstyle{\thepage}
		}%

		\fancypagestyle{plain}{
		\fancyhf{}
		\fancyhead[RO]{\thepage}
		\fancyhead[LE]{\thepage}
		}
	\fi
\fi
\makeatother

\setlength{\headheight}{13.6pt}

%	T I T L E  H E A D E R S
%

%	chapters are not labeled as chapters anymore
\renewcommand{\chaptername}{}

%	default numbering depth
\AtBeginDocument{\setcounter{secnumdepth}{1}}

%	header formatting
\titlespacing*{\part}{.2\linewidth}{.3\textheight}{0pt}
\titlespacing*{\chapter}{0pt}{-70pt}{55pt}
\titleformat{\part}%[hang]
	{\thispagestyle{empty}\huge\raggedleft}
	{\Large\lsstyle\MakeUppercase{\if@libertine\LibertinusDisplay\fi\partname}~~\thepart\normalfont}
	{0em}
	{\vskip 12pt \setstretch{0.9}\huge\lsstyle\sffamily\uppercase}
% \let\oldpart\part
% \renewcommand{\part}{
% }
\titleformat{\chapter}[block]
	{\begin{wide}\thispagestyle{empty}\itshape\huge}
	{\normalfont\makebox[1.5em][l]{\bfseries\fontsize{32pt}{30pt}\selectfont\textcolor{Secondary}{\thechapter}}}
	{1em}
	{\setstretch{0.9}\raggedright\huge\if@libertine\LibertinusDisplay\fi\itshape}[\end{wide}]
\titleformat{\section}
	{\itshape\Large}
	{\normalfont\thesection}
	{1em}
	{\setstretch{0.9}\raggedright\itshape}
\titleformat{\subsection}
	{\itshape\normalfont}
	{\raggedright\normalfont\thesubsection}
	{1em}
	{\setstretch{0.9}\itshape}
\titleformat{\subsubsection}[runin]
	{}
	{\itshape\thesubsubsection}
	{1ex}
	{\itshape}[~~$\cdot$]


%	M A K E T I T L E
%

% 	custom info commands like @title, @author...
% 	info commands definition
\makeatletter
% 	subtitle --title already exists
\newcommand\subtitle[1]{\renewcommand\@subtitle{#1}}
\newcommand\@subtitle{}
% 	university
\newcommand\university[1]{\renewcommand\@university{#1}}
\newcommand\@university{}
% 	lab
\newcommand\lab[1]{\renewcommand\@lab{#1}}
\newcommand\@lab{}

% 	supervisors, jury members, etc.
\newcommand\people{}
\def\zfoo#1\relax{\long\def\people##1{#1}}
\newcommand\updatepeople[1]{%
   \expandafter\zfoo\people{##1}##1#1\relax
}
\newcommand\person[3]{%
    \updatepeople{{\textls{\sffamily\small\scshape\MakeTextLowercase{#1}}} & #2 & \textit{#3}\\}%
}
\newcommand\persongap{%
	\updatepeople{[8pt]}
}

%	logos
\newcommand\logos{}
\def\xfoo#1\relax{\long\def\logos##1{#1}}
\newcommand\updatelogos[1]{%
   \expandafter\xfoo\logos{##1}##1#1\relax
}
\newcommand\logo[1]{
    \updatelogos{
		\hspace{20pt}\includegraphics[height=30pt]{#1}
	}
}

% 	Doctoral thesis (subsubtitle)
\newcommand\type[1]{\renewcommand\@type{#1}}
\newcommand\@type{Doctoral thesis}

% 	shoutouts
\newcommand\shoutouts[1]{\renewcommand\@shoutouts{#1}}
\newcommand\@shoutouts{}

% 	ACTUAL MAKETITLE (titlepage + "copyright" and dedication pages)
\newcommand\@maketitlebis{%
	\makeatletter
	\setstretch{1.0}
	\begin{titlepage}
		% \setcounter{page}{1}
		\hfill
		\begin{minipage}{.8\linewidth}
		\raggedleft

		{\large\scshape
				\MakeLowercase{\@university}%

				\bigskip

				\MakeLowercase{\@lab}%  <- this percent is mandatory -- without it latex places and awkward space
		}

		\vskip.07\paperheight

		{\large\@author}

		\vskip 20 pt

		{%
			\huge\color{Secondary}\if@libertine\LibertinusDisplay\fi\@title\par
		}%

		\vskip 8pt

		{\Large\@subtitle\par}%

		\vskip 20pt

		{\large\sffamily\lsstyle\MakeTextUppercase{\@type}}%

		\vskip 40pt

		{\itshape\@date}

		\end{minipage}

		\vfill

		\raggedleft

		\bgroup\renewcommand{\arraystretch}{1.2}
		\begin{tabular}{rll}
			\people{}
		\end{tabular}
		\egroup

		\vskip 40pt

		\logos{}

	\end{titlepage}

	\if@twocolumn
		\onecolumn
		\@twocolumntrue
	\fi

	\iffalse % colorful
		\hypersetup{
			colorlinks = true,
			linkcolor = niceBlue,
			anchorcolor = niceBlue,
			citecolor = .,
			urlcolor = niceBlue,
		}
	\fi

	% copyright
	\thispagestyle{empty}
	\hfill
	\vfill
	\makeatletter
	\noindent\begin{flushleft}\@author, \textit{\@title}, \MakeTextLowercase{\@date}.
    \end{flushleft}
	\makeatother


	% dedication
	\cleardoublepage
	\thispagestyle{empty}
	~\vskip .3\textheight
	\begin{flushright}
	\large\itshape\@shoutouts
	\end{flushright}

	\setstretch{1.1}
	\makeatother
	\if@twocolumn
		\twocolumn
	\fi
}
\renewcommand\maketitle{
	\@maketitlebis
	\thispagestyle{empty}
}
\newcommand\colophon[1]{\renewcommand\@colophon{#1}}
%	default colophon
\newcommand\@colophon{%
This document was typeset using \LaTeX{} and the \texttt{tufte-style-thesis} class.

The style is heavily inspired by the works of Edward R. Tufte and Robert Bringhurst.

This is available on \url{https://github.com/sylvain-kern/tufte-style-thesis/}.

Feel free to contribute!
}
\makeatother

%	COLOPHON
\makeatletter
\ifopt@colophon
\AtEndDocument{
	\cleardoublepage
	\pagestyle{empty}
		\if@twocolumn
		\onecolumn
		\fi
	\footnotesize\raggedleft
	\hfill
	\vfill
	\noindent\@colophon
}
\fi
\makeatother


%	F I G U R E S  A N D  S T U F F
%
% 	caption formatting
\DeclareCaptionLabelFormat{lc}{\MakeLowercase{#1}~#2}
\DeclareCaptionLabelSeparator{mysep}{.\quad}
\DeclareCaptionLabelSeparator{mysepside}{.\\\noindent}
\captionsetup{
	labelfont = {bf},
	format = hang,
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=on,
}
\DeclareCaptionStyle{sidecaption}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysepside,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
\DeclareCaptionStyle{marginfigure}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysepside,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
\DeclareCaptionStyle{widefigure}{
    labelfont = {bf},
	format = hang,
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
\DeclareCaptionStyle{margintable}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysepside,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
\DeclareCaptionStyle{widetable}{
    labelfont = {bf},
	format = hang,
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
%	figure macros
\AtBeginDocument{\usepackage[export]{adjustbox}} % for 'outer' mode
\newcommand{\textfig}[4][]{%
	\FloatBarrier
	\begin{figure}[!htb]%
		\sidecaption{#3\label{#4}}%
		\includegraphics[width = #1\linewidth, outer]{#2}%
	\end{figure}%
}
\newcommand{\marginfig}[3]{%
	\FloatBarrier%
	\begin{marginfigure}%
		\includegraphics[width = \linewidth]{#1}%
		\caption{#2\label{#3}}%
	\end{marginfigure}%
}
\newcommand{\widefig}[4][]{%
	\FloatBarrier%
	\begin{figure*}[!htb]%
		\includegraphics[width=#1\linewidth, outer]{#2}%
		\sidecaption{#3\label{#4}}%
	\end{figure*}%
}
\newcommand{\plainfig}[4][]{%
	\FloatBarrier%
	\begin{figure}[!htb]%
		\includegraphics[width=#1\linewidth, left]{#2}%
		\caption{#3\label{#4}}%
	\end{figure}%
}
\newcommand{\plainwidefig}[4][]{%
	\FloatBarrier%
	\begin{figure*}[!htb]%
		\includegraphics[width=#1\linewidth, left]{#2}%
		\caption{#3\label{#4}}%
	\end{figure*}%
}
%	table macros
\newcolumntype{Y}{>{\centering\arraybackslash}X} % tabularx column type
\newenvironment{texttable}[2]{%
	\begingroup%
	\small%
	\marginpar{%
		\vskip 8pt%
		\captionof{table}{#1}%
		\label{#2}%
	}

	\noindent%
}
{
	\endgroup%
}


%	C O D E
%
%   colors
\makeatletter
\ifopt@code
\RequirePackage[framemethod=TikZ]{mdframed} % for custom code boxes
\RequirePackage[%				% listings
	% numberbychapter=true,
]{listings}
\definecolor{bg}{rgb}{.95,.95,.95}
\definecolor{key}{HTML}{333399}
\definecolor{comment}{HTML}{6b6b99}
\definecolor{codegray}{rgb}{0.4,0.4,0.4}
\definecolor{string}{HTML}{2b4f2b}
%   boxes
\mdfdefinestyle{code_box}{%
    roundcorner= 2pt,
	backgroundcolor=white,
    linecolor = lightgray,
    linewidth = .5pt,
    topline = true,
    bottomline = true,
    leftline = true,
    rightline = true,
	innertopmargin=.2em,
	innerbottommargin=.2em,
}
%   listing styles
\lstdefinestyle{unnumbered}{
    commentstyle=\color{comment},
    keywordstyle=\color{key},
    stringstyle=\color{string},
    basicstyle=\ttfamily\normalsize\lst@ifdisplaystyle\small,
    breakatwhitespace=false,
    breaklines=true,
    keepspaces=true,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=4,
    framexleftmargin=30pt,
}
\lstdefinestyle{numbered}{
    commentstyle=\color{comment},
    keywordstyle=\color{key},
    stringstyle=\color{string},
    basicstyle=\ttfamily\normalsize\lst@ifdisplaystyle\small,
    breakatwhitespace=false,
    breaklines=true,
    keepspaces=true,
    numbers=left,
    numberstyle = \color{codegray}\footnotesize\ttfamily,
    numbersep=10pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=4,
    framexleftmargin=30pt,
    framextopmargin=100pt,
    framexbottommargin=30pt,
}
%   code macros
\lstnewenvironment{codebox}[1]{%
	\FloatBarrier
	\mdframed[style = code_box, innerleftmargin=10pt]%
	\lstset{style=unnumbered, language=#1}
}
{
    \endmdframed
}
\lstnewenvironment{altcodebox}[1]{%
	\FloatBarrier
	\mdframed[style = code_box, innerleftmargin=10pt]%
	\lstset{style=unnumbered, language=#1}
}
{
    \endmdframed
}
\lstnewenvironment{codeboxnum}[1]{%
	\FloatBarrier
	\mdframed[style = code_box, innerleftmargin=25pt]%
	\lstset{style=numbered, language=#1}
}
{
    \endmdframed
}
\newcommand{\inlinecode}[1]{\lstinline[style=unnumbered, language=#1]}
%	snippet environments
\lstnewenvironment{snippet}[3]{%
	\marginpar{~\vskip 10pt\captionof{listings}{#2\label{#3}}}
	\mdframed[style = code_box, innerleftmargin=10pt]%
	\lstset{style=unnumbered, language=#1}
}
{
    \endmdframed
}
\lstnewenvironment{snippetnum}[3]{%
	\marginpar{~\vskip 10pt\captionof{listings}{#2\label{#3}}}
	\mdframed[style = code_box, innerleftmargin=25pt]%
	\lstset{style=numbered, language=#1}
}
{
    \endmdframed
}
\fi
\makeatother


%	T O C  C U S T O M I Z A T I O N
%
\contentsmargin[1cm]{0cm}
\titlecontents*{part}[0em]
	{\large\scshape}
	{\scshape\thecontentslabel}
	{\vskip 4pt\large\scshape\lowercase}
	{}[\vskip 0pt]
\titlecontents{chapter}[0em]
	{\large\vspace{12pt}}
	{\makebox[-1em][r]{\bfseries\Large\textcolor{Secondary}{\thecontentslabel}}\large\hspace{1em}}
	{\large}
	{~~~\textbullet~~~\contentspage}[\vskip 2pt]
\titlecontents*{section}[0em]
	{\small}
	{\thecontentslabel~~}
	{\small}
	{~~\textbullet~~\contentspage}
	[\\]
% \titlecontents{subsection}[0em]
% 	{\vspace{4pt}}
% 	{\normalfont\thecontentslabel\enspace\itshape}
% 	{\itshape}
% 	{\qquad\contentspage}[\vskip 0pt]
% \titlecontents*{subsection}[0em]
% 	{\vskip 0pt\small}
% 	{{\thecontentslabel}~~\itshape}
% 	{\itshape}
% 	{~~{\contentspage}}
% 	[\qquad]
% \titlecontents{subsubsection}[1em]
% 	{\vspace{0pt}}
% 	{\normalfont\thecontentslabel\enspace\itshape}
% 	{\itshape}
% 	{\quad\quad\contentspage}[\vskip 0pt]

% TOCLOFT (stolen from classicthesis)
\renewcommand{\cftfigpresnum}{\scshape\MakeTextLowercase}%
\renewcommand{\cftfigfont}{\normalfont}%
\renewcommand{\cftfigleader}{\hspace{2.5em}}%
\renewcommand{\cftfigafterpnum}{\cftparfillskip}%
\renewcommand{\cftfigpresnum}{\figurename~}%Fig.~}
\newlength{\figurelabelwidth}
\settowidth{\figurelabelwidth}{\cftfigpresnum~999}
\addtolength{\figurelabelwidth}{1em}
\cftsetindents{figure}{0em}{\figurelabelwidth}
% tables
\renewcommand{\cfttabfont}{\normalfont}%
\renewcommand{\cfttableader}{\hspace{2.5em}}%
\renewcommand{\cfttabafterpnum}{\cftparfillskip}%
\renewcommand{\cfttabpresnum}{\tablename~}%Tab.~}
\newlength{\tablelabelwidth}
\settowidth{\tablelabelwidth}{\cfttabpresnum~999}
\addtolength{\tablelabelwidth}{1em}
%\cftsetindents{table}{0em}{\tablelabelwidth}
\cftsetindents{table}{0em}{\figurelabelwidth}
% listings
\makeatletter
\ifopt@code
	\newcommand\listingsname{Listing}
	\renewcommand\lstlistingname{Listing}
	\renewcommand\lstlistlistingname{List of Listings}
	\newlistof{listings}{lol}{\lstlistlistingname}%
	\renewcommand{\cftlistingspresnum}{\scshape\MakeTextLowercase}%
	\renewcommand{\cftlistingsfont}{\normalfont}%
	\renewcommand{\cftlistingspresnum}{\lstlistingname~}%
	\renewcommand{\cftlistingspagefont}{\normalfont}%
	\renewcommand{\cftlistingsleader}{\hspace{1.5em}}%
	\renewcommand{\cftlistingsafterpnum}{\cftparfillskip}%
	\newlength{\listingslabelwidth}%
	\settowidth{\listingslabelwidth}{\cftlistingspresnum~999}%
	\addtolength{\listingslabelwidth}{2.5em}%
	\cftsetindents{listings}{0em}{\figurelabelwidth}%
	% \let\l@lstlisting\l@listings%
	\let\lstlistoflistings\listoflistings%
\fi
\makeatother

% TOCLOFT over
%	toc offset
\let\oldtoc\tableofcontents
\renewcommand{\tableofcontents}{%
	\begin{quote}\setstretch{1.0}
	\oldtoc
	\end{quote}
}
%	toc depth
\AtBeginDocument{\setcounter{tocdepth}{1}}

%	B I B L I O G R A P H I C
%	      R E F E R E N C E S  %this is black magic to me but it seems 2b working
\makeatletter
\if@bibexists

\if@bibnumbered

% nature style recustom thanks ivo straka
\DeclareFieldFormat{labelnumberwidth}{\textsf{#1}\hspace{1em}}

\renewcommand{\labelnamepunct}{\addcomma\newline}

\DeclareDelimFormat{finalnamedelim}{%
\textup{%
  \ifnumgreater{\value{liststop}}{2}{\finalandcomma}{}%
  \addspace\bibstring{and}\addspace%
  }%
}

\makeatletter
\def\do#1{
  \ifcsdef{blx@bbx@#1}
    {\xpatchbibdriver{#1}
       {\printlist{language}%
        \newunit\newblock}
       {\printlist{language}%
        \printunit{\addcomma\newline}}
       {}{}}
    {}}
\abx@doentrytypes
\makeatother

\letbibmacro{ORIG-institution+location+date}{institution+location+date}
\renewbibmacro*{institution+location+date}
{\iffieldundef{url}
		{\usebibmacro{ORIG-institution+location+date}}
		{\href{\thefield{url}}{\usebibmacro{ORIG-institution+location+date}}}
}

% et al in italics
\DeclareBibstringSet{latin}{andothers,ibidem}%
\DeclareBibstringSetFormat{latin}{\mkbibemph{#1}}

% sidecite

\newcommand\sidecite[2][]{\supercite{#2}\sidetext{\ifthenelse{\equal{#1}{}}{}{\vskip #1}%
\@for\cle:={#2}\do{\makebox[0pt][r]{\supercite{\cle}}\fullcite{\cle}.\\\vskip 4pt \noindent}%
}}
\newcommand\sidetextcite[2][]{\sidetext{\ifthenelse{\equal{#1}{}}{}{\vskip #1}%
\@for\cle:={#2}\do{\makebox[0pt][r]{\supercite{\cle}}\fullcite{\cle}.\\\vskip 4pt \noindent}%
}}

\DeclareCiteCommand{\fullcite}
  {\usebibmacro{prenote}}
  {\clearfield{url}%
   \clearfield{pagetotal}%
   \clearfield{edition}%
   \usedriver
     {\DeclareNameAlias{sortname}{default}}
     {\thefield{entrytype}}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

\DeclareCiteCommand{\plaincite}%[\mkbibbrackets]
  {\usebibmacro{cite:init}%
   \usebibmacro{prenote}}
  {\usebibmacro{citeindex}%
   \usebibmacro{cite:comp}}
  {}
  {\usebibmacro{cite:dump}%
   \usebibmacro{postnote}}

% \newcommand{\footnotecite}[1]{%
% \supercite{#1}%
% \let\oldthefootnote=\thefootnote%
% % \setcounter{footnote}{0}%
% \@for\cle:={#1}\do{%
% \renewcommand{\thefootnote}{\plaincite{\cle}}%
% \footnotetext{\fullcite{\cle}.}%
% }\let\thefootnote=\oldthefootnote}

\newlength{\spc}
\settowidth{\spc}{,}

\DeclareFieldFormat{plain}{#1}
\DeclareFieldFormat{commasuperscript}{\hspace{.2\spc}\textsuperscript{#1}}
\DeclareFieldFormat{commapostnote}{, #1}
\DeclareFieldFormat{notecite}{\footnotetext{#1}}

\DeclareCiteCommand{\textcite}
  {\addspace\usebibmacro{prenote}}
  {\usebibmacro{citeindex}%
   \usebibmacro{textcite}}
  {\multinamedelim}%
  {}%

\DeclareMultiCiteCommand{\textcites}
	{\textcite}{\multicitedelim}

\renewbibmacro*{textcite}{%
  \printtext[bibhyperref]{%
    \printnames{labelname}%
    \setunit{\nameyeardelim}%
    \printtext[parens]{%
		\printfield[plain]{year}%
		\printfield[commapostnote]{postnote}%
	}%
      \printfield{prefixnumber}%
      \printfield[commasuperscript]{labelnumber}%
    \ifbool{bbx:subentry}
      {\printfield{entrysetcount}}
      {}}}

\DeclareCiteCommand{\cite}
	{\usebibmacro{prenote}}
	{\usebibmacro{citeindex}%
	\usebibmacro{cite}}
	{\multinamedelim}%
	{}%

\DeclareMultiCiteCommand{\cites}
	{\cite}{\multicitedelim}

\newbibmacro*{cite}{%
	\printtext[bibhyperref]{%
	\printtext[parens]{%
	\printnames{labelname}%
	\setunit{\nameyeardelim}%
		\addcomma%
		\addspace%
		\printfield[plain]{year}%
		\printfield[commapostnote]{postnote}%
	}%
		\printfield{prefixnumber}%
		\printfield[commasuperscript]{labelnumber}%
	\ifbool{bbx:subentry}
		{\printfield{entrysetcount}}
		{}}}



\DeclareCiteCommand{\mycite}
	{\usebibmacro{prenote}}
	{\usebibmacro{citeindex}%
	\usebibmacro{footnotecite}}
	{}
	{%\usebibmacro{postnote}
	}

% %% La même avec footnotecite et foottextcite ?
% \newbibmacro*{footnotecite}{%
%   	\printtext[bibhyperref]{%
% 		\printfield[subentrycomp]{labelnumber}
% 	}%
% }

%% autocite directly ABOVE punctuation
% (https://tex.stackexchange.com/questions/277988/biblatex-s-supercite-superscript-reference-above-punctuation)

\makeatletter
\newcommand*{\blx@fnpct@movefor}{}
\newcommand*{\DeclareFootnoteMovePunct}{%
  \@ifstar
    {\let\blx@fnpct@movefor\@empty}
    {}
  \blx@def@fnpct@movefor}
\newcommand*{\blx@def@fnpct@movefor}{%
  \def\do##1{\blx@thecheckpunct{\listadd{\blx@fnpct@movefor}}##1}%
  \docsvlist}

\DeclareFootnoteMovePunct{.,{,}}

\newlength{\blx@fnpct@movelength}
\newcommand*{\blx@fnpct@footnotemover}[1]{%
  #1%
  \ifinlist{#1}{\blx@fnpct@movefor}
    {\settowidth{\blx@fnpct@movelength}{#1}%
     \hspace{-.9\blx@fnpct@movelength}}
    {}%
}

\protected\csedef{blx@acitei@superscript}#1#2#3#4#5{%
  \begingroup
  \blx@citeinit
    \noexpand\blx@fnpct@footnotemover{#5}%
    \blxcitecmd{supercite#1}{#2}{#3}{#4}{}%
  \endgroup}%
\protected\csedef{blx@macitei@superscript}#1#2#3{%
  \noexpand\blx@fnpct@footnotemover{#3}%
  #1{#2}%
  \endgroup}
\makeatother

\DeclareCitePunctuationPosition{\supercite}{f}

\else
\renewcommand{\cite}[2][]{\citeauthor{#2} \parencite*[#1]{#2}}

\fi

\fi
\makeatother

\iffalse
\let\oldcite\cite
\makeatletter
\if@notesfoot
	\renewcommand\cite[1]{\footnotecite{#1}}
\else
	\if@notesside
		\renewcommand\cite[1]{\sidecite{#1}}
	\else
	\fi
\fi
\makeatother
\fi

%	flush T I G H T  L I S T S
%
\AtBeginDocument{
	\setlist{topsep=0pt, itemsep=0pt, noitemsep}
}
% 	diamond bullets
\renewcommand{\labelitemi}{$\vcenter{\hbox{\small$\diamond$}}$}


%	I N - T E X T  F I N E T U N I N G
%
% widows and orphans
\clubpenalty = 10000
\widowpenalty = 10000
\displaywidowpenalty = 10000


%	M I S C E L L A N E O U S
%
\providecommand{\toight}{%
	\tightlist%
}
%	minipages with margin notes
\usepackage{minipage-marginpar}
%	no page break environment
\newenvironment{absolutelynopagebreak}
  {\par\nobreak\vfil\penalty0\vfilneg
   \vtop\bgroup}
  {\par\xdef\tpd{\the\prevdepth}\egroup
   \prevdepth=\tpd}
\newcommand{\eemph}[1]{\textsc{\lsstyle\MakeTextLowercase{#1}}} % small caps emph

%	S C I E N C E
%		S T U F F
\makeatletter
\ifopt@science
% uncomment this \iffalse
%and the \fi at the end to disable (or delete)
\RequirePackage{amsfonts}		% math fonts
\RequirePackage{amsmath}		% math stuff
\RequirePackage{mathtools}		% amsmath extension
\RequirePackage{physics}		% handy shortcuts for physics

% i find it more pleasing
\renewcommand{\phi}{\varphi}
\renewcommand{\epsilon}{\varepsilon}
\newcommand{\N}{\mathbb{N}}     % shortcuts for usual number sets
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\C}{\mathbb{C}}
% powers of 10
\newcommand{\ee}[1]{\cdot 10^{#1}}
% new vect with overrightarrow style
\newcommand{\vect}[1]{\:\overrightarrow{#1}}
\fi
\makeatother

% TODO
\newlistof{todos}{tod}{\bfseries \textls{TO DO} list}
\let\oldlistoftodos\listoftodos
\renewcommand{\listoftodos}{\bgroup\color{tooRed}{\oldlistoftodos}\egroup}
\newcommand{\todolist}{\listoftodos}

\newcounter{todo}
\setcounter{todo}{1}
\newcommand{\todo}[1]{
    \addcontentsline{tod}{todos}{\protect\numberline{\bfseries\#\thetodo}#1}
    \bgroup\color{tooRed}
    \noindent\large\textsc{todo \#\arabic{todo}}~~\hrulefill%
    \refstepcounter{todo}%
    \smallskip

    \normalsize\noindent #1

    \noindent\hrulefill
    \egroup
}

%		S  T   R   E   T     C      H
%
\makeatletter
\AtBeginDocument{%
	\setstretch{1.1}
	\if@flragged
		\setlength{\RaggedRightParindent}{1.5em}
		\RaggedRight
	\else
	\fi
}
\makeatother

%	if two column
%
\makeatletter
	\if@twocolumn
		\setlength{\columnsep}{0.12\linewidth}
	\else
	\fi
\makeatother
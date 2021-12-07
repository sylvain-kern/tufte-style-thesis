\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tufte-style-thesis}[]

%	O P T I O N S
%
\DeclareOption{raggedright}{	% makes all paragraphs left-aligned
	\AtBeginDocument{
		\setlength{\RaggedRightParindent}{1em}
		\RaggedRight
	}
}
\DeclareOption{parskip}{		% changes paragraph indents vor vertical skips
	\AtBeginDocument{\usepackage{parskip}}
	\setlength{\parskip}{\baselineskip}
}
\DeclareOption{noheaders}{		% disables section titles on page headers
	\renewcommand{\leftmark}{}
	\renewcommand{\rightmark}{}
}
\DeclareOption{casual}{		% removes header numbering --still puts them in toc
	\AtBeginDocument{\setcounter{secnumdepth}{0}}
}
\newif\if@sans\@sansfalse
\DeclareOption{sans}{
	\@sanstrue
	\renewcommand{\familydefault}{\sfdefault}
}
\newif\if@colorful\@colorfulfalse
\DeclareOption{black}{
	\@colorfulfalse
}
\DeclareOption{colorful}{
	\@colorfultrue
}

\ExecuteOptions{black, raggedright}
\ProcessOptions\relax
\LoadClassWithOptions{book}

%	P A C K A G E   D E F I N I T I O N
%
\RequirePackage{geometry}		% page geometry, margin definition
\RequirePackage{emptypage}		% if a page is empty, is is really empty
\RequirePackage{fullwidth}		% for wide environments
\RequirePackage{marginnote}
\RequirePackage{sidenotes}		% for margin stuff
\RequirePackage[
	hypcap=false				% hypcap=true spits an error
]{caption}						% for caption formatting
\RequirePackage[T1]{fontenc}	% font encoding
\RequirePackage[osf]{libertinus}% main font
\RequirePackage{libertinust1math}
\RequirePackage{gillius}		% sans font
\if@sans
	\RequirePackage[			% font for full sans document
		osf,
		default
	]{sourcesanspro}
\fi
\RequirePackage[
	defaultmono,
	scale=.8
]{droidsansmono}				% mono font
\RequirePackage{ragged2e}		% for better raggedright
\RequirePackage{titlesec}		% header customization
\RequirePackage{titletoc}		% toc customization
\RequirePackage[titles]{tocloft}		% lof lot lol customizatios
\RequirePackage{fancyhdr}		% page header customization
\RequirePackage{graphicx}		% for images
\RequirePackage[
	protrusion=true,
	expansion=true,
	final,
	tracking,
]{microtype}					% microtypography: fine-tuning in text
\RequirePackage{amsfonts}		% math fonts
\RequirePackage{amsmath}		% math stuff
\RequirePackage{mathtools}		% amsmath extension
\RequirePackage{physics}		% handy shortcuts for physics
\RequirePackage[chapter]{minted} 		% for code display
\RequirePackage{xcolor}			% colorz
\RequirePackage[framemethod=TikZ]{mdframed} % for custom code boxes
\RequirePackage{tabularx}		% adaptive columns on tables
\RequirePackage{booktabs}		% better looking tables
\RequirePackage{enumitem}		% better looking lists
\RequirePackage[hidelinks]{hyperref}	% automatic references in pdf
\RequirePackage{etoolbox}		% really idk what this does
\RequirePackage{verbatim}   	% for verbatim environments
\RequirePackage[export]{adjustbox}
\RequirePackage[strict]{changepage}	% needed by sidenotes
\RequirePackage{placeins}		% for floatbarrier


%	C O L O R  D E F I N I T I O N
%
\definecolor{niceRed}{HTML}{dc2828}
\if@colorful
	\definecolor{accent}{niceRed}
	\definecolor{main_accent}{HTML}{cb3004}
	\definecolor{lighter_accent}{HTML}{e45826}
	\definecolor{darker_gray}{HTML}{393136}
	\definecolor{dark_gray}{HTML}{5a565c}
	\definecolor{light_blue}{HTML}{0695c4}
	\definecolor{dark_blue}{HTML}{084983}
	\hypersetup{
		colorlinks = true,
		linkcolor = .,
		anchorcolor = main_accent,
		citecolor = main_accent,
		urlcolor = light_blue
	}
	\renewcommand\thefootnote{\color{main_accent}\arabic{footnote}}
	\renewcommand\thesidenote{\color{main_accent}\arabic{sidenote}}
\else
	\definecolor{main_accent}{HTML}{000000}
	\definecolor{lighter_accent}{HTML}{000000}
	\definecolor{darker_gray}{HTML}{000000}
	\definecolor{dark_gray}{HTML}{000000}
\fi


%	G E O M E T R Y  D E F I N I T I O N
%
\newgeometry{
	tmargin = 80pt,
	bmargin = 80pt,
	lmargin = 100pt,
	rmargin = 100pt,
}
\savegeometry{titlepage}
\newgeometry{
	tmargin = 80pt,
	bmargin = 80pt,
	lmargin = 70pt,
	rmargin = 70pt,
}
\savegeometry{evenmargins}
\newgeometry{
	textwidth = .82\paperwidth,
	textheight = .8\paperheight,
	lmargin = 70pt,
	marginparwidth = .28\textwidth,
	marginparsep = 10pt,
	headheight = 16pt,
	tmargin = 80pt,
	%showframe,
}
\savegeometry{headaz}
\newgeometry{
	textwidth = .58\paperwidth,
	textheight = .8\paperheight,
	lmargin = 70pt,
	marginparwidth = .32\textwidth,
	marginparsep = 20pt,
	headheight = 16pt,
	tmargin = 80pt,
	%showframe,
}
\savegeometry{regular}


%	M A R G I N S
%
% formatting sidenote text
\makeatletter
\RenewDocumentCommand\sidenotetext{ o o +m }{%
    \IfNoValueOrEmptyTF{#1}{%
        \@sidenotes@placemarginal{#2}{\noindent\footnotesize\RaggedRight{\thesidenote{}}~~#3}%
        \refstepcounter{sidenote}%
    }{%
        \@sidenotes@placemarginal{#2}{\noindent\footnotesize\RaggedRight{#1}~~#3}%
    }%
}
\makeatother

\newcommand{\sidetext}[1]
{\marginpar{\color{darker_gray}\RaggedRight\footnotesize\noindent #1 \vskip 4pt}}

\newenvironment{wide}{
\begin{fullwidth}[outermargin=-\marginparwidth-\marginparsep, width=\linewidth+\marginparwidth+\marginparsep]
}%
{
\end{fullwidth}
}
% sidenotes reset on new
\let\oldchap\chapter
\renewcommand{\chapter}{\setcounter{sidenote}{1}\oldchap}


%	P A G E  H E A D E R S
%
\renewcommand{\chaptermark}[1]{ \markboth{#1}{} }
\renewcommand{\sectionmark}[1]{ \markright{#1}{} }
\loadgeometry{headaz}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[LO]{
	\footnotesize\textls{\MakeUppercase{\sffamily\rightmark}} \hfill \normalfont\normalsize\thepage
}
\fancyhead[RE]{
	\normalfont\normalsize\thepage \hfill \footnotesize\textls{\MakeUppercase{\sffamily\leftmark}}
}
\fancypagestyle{plain}{
\fancyhf{}
\fancyhead[RO]{\thepage}
\fancyhead[LE]{\hfill}
}
\loadgeometry{regular}

%	T I T L E  H E A D E R S
%

%	default numbering depth
\AtBeginDocument{\setcounter{secnumdepth}{1}}

%	header formatting
\titlespacing*{\part}{.2\linewidth}{.3\textheight}{0pt}
\titlespacing*{\chapter}{0pt}{-40pt}{65pt}
\titleformat{\part}%[hang]
	{\thispagestyle{empty}\LARGE\raggedleft}
	{\Large\lsstyle\MakeUppercase{\partname}~~\thepart\normalfont}
	{0em}
	{\vskip 12pt \LARGE\lsstyle\sffamily\uppercase}
% \let\oldpart\part
% \renewcommand{\part}{
% 	\loadgeometry{evenmargins}\oldpart\loadgeometry{regular}
% }
\titleformat{\chapter}[block]
	{\begin{wide}\thispagestyle{empty}\itshape\LARGE}
	{\normalfont\bfseries\huge\thechapter}
	{1em}
	{\raggedright\LARGE\itshape}[\end{wide}]
\titleformat{\section}
	{\itshape\Large}
	{\color{main_accent}\normalfont\thesection}
	{1em}
	{\raggedright\color{main_accent}\itshape}
\titleformat{\subsection}
	{\itshape\large}
	{\raggedright\color{lighter_accent}\normalfont\thesubsection}
	{1em}
	{\color{lighter_accent}\itshape}
\titleformat{\subsubsection}
	{\itshape}
	{\color{dark_gray}\normalfont\thesubsubsection}
	{1em}
	{\raggedright\color{dark_gray}\itshape}


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
\newcommand\person[3]{
	\let\@oldpeople\@people
	\def\@people{\@oldpeople #1 & #2 & #3 \\}
}
\newcommand\@people{}




%	logos
\newcommand\logoone[1]{%
	\renewcommand\@logoone{%
		\hspace{20pt}\includegraphics[height=50pt]{#1}
	}
}
\newcommand\@logoone{}

\newcommand\logotwo[1]{%
	\renewcommand\@logotwo{
		\hspace{20pt}\includegraphics[height=50pt]{#1}
	}
}
\newcommand\@logotwo{}

\newcommand\logothree[1]{%
	\renewcommand\@logothree{%
		\hspace{20pt}\includegraphics[height=50pt]{#1}
	}
}
\newcommand\@logothree{}

% 	shoutouts
\newcommand\shoutouts[1]{\renewcommand\@shoutouts{#1}}
\newcommand\@shoutouts{}

% 	ACTUAL MAKETITLE
\newcommand\@maketitlebis{%
	\makeatletter

	\begin{titlepage}
		% \setcounter{page}{1}
		\loadgeometry{titlepage}
		\hfill
		\begin{minipage}{.8\linewidth}
		\raggedleft

		{\large\scshape
				\MakeLowercase{\@university}%

				\bigskip

				\MakeLowercase{\@lab}%  <- this percent is mandatory -- without it latex places and awkward space
		}

		\vskip 80pt

		{\large\itshape\@author}

		\vskip 40 pt

		{\huge\@title\par}%

		\vskip 8pt

		{\large\@subtitle\par}%

		\vskip 20pt

		{\Large Doctoral thesis}%

		\vskip 40pt

		{\itshape\@date}

		\end{minipage}

		\vfill

		\raggedleft

		\begin{tabular}{rll}
			\@people
		\end{tabular}

		\vskip 40pt

		\@logoone
		\@logotwo
		\@logothree

	\end{titlepage}

	% copyright
	\loadgeometry{evenmargins}
	\thispagestyle{empty}
	\hfill
	\vfill
	\makeatletter
	\noindent\RaggedRight\@author,\quad \textit{\@title,} \@subtitle, \@date.
	\makeatother

	\loadgeometry{regular}

	% dedication
	\cleardoublepage
	\thispagestyle{empty}
	\loadgeometry{evenmargins}
	~\vskip .3\textheight
	\begin{flushright}
	\large\itshape\@shoutouts
	\end{flushright}
	\loadgeometry{regular}

	\makeatother
}
\renewcommand\maketitle{
\@maketitlebis
\thispagestyle{empty}
}
\makeatother

% COLOPHON
\AtEndDocument{
	\newpage
	\pagestyle{empty}
	\loadgeometry{evenmargins}
	\footnotesize\raggedleft
	\hfill
	\vfill
	\noindent This thesis was typeset using \LaTeX{} and the \texttt{tufte-style-thesis} class.

	The style is heavily inspired by the works of Edward R. Tufte and Robert Bringhurst.

	This is available on the following repository:

	\vskip 8pt

	\centering \url{https://github.com/sylvain-kern/tufte-style-thesis/}.\\
	\raggedleft\noindent Feel free to contribute!
}

%	F I G U R E S  A N D  S T U F F
%
% 	caption formatting
\DeclareCaptionLabelFormat{lc}{\MakeLowercase{#1}~#2}
\DeclareCaptionLabelSeparator{mysep}{.\quad}
\captionsetup{
	labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize},
	singlelinecheck=off,
}
\DeclareCaptionStyle{sidecaption}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize},
	singlelinecheck=off,
}
\DeclareCaptionStyle{marginfigure}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize},
	singlelinecheck=off,
}
\DeclareCaptionStyle{widefigure}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize},
	singlelinecheck=off,
}
\DeclareCaptionStyle{margintable}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize},
	singlelinecheck=off,
}
\DeclareCaptionStyle{widetable}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize},
	singlelinecheck=off,
}

%	figures

%	figure macros
\AtBeginDocument{\usepackage[export]{adjustbox}}
% \newcommand{\textfig}[4][]{%
% 	\medskip%
% 	\marginpar{%
% 		\vskip 8pt%
% 		\captionof{figure}{#3}%
% 		\label{#4}%
% 	}\nopagebreak%
% 	\noindent\includegraphics[width=#1\textwidth, outer]{#2}%
% 	\medskip%
% }
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

%	T O C  C U S T O M I Z A T I O N
%
\contentsmargin[1cm]{0cm}
\titlecontents*{part}[0em]
	{\large\scshape}
	{\scshape\thecontentslabel}
	{\vskip 4pt\large\scshape\lowercase}
	{}[\vskip 0pt]
\titlecontents{chapter}[0em]
	{\large\vspace{8pt}}
	{\makebox[-1em][r]{\bfseries\large\thecontentslabel}\large\hspace{1em}}
	{\large}
	{~~~\contentspage}[\vskip 2pt]
\titlecontents*{section}[0em]
	{\vskip 0pt\large}
	{{\thecontentslabel}~~\itshape}
	{\itshape}
	{~~{\contentspage}}
	[\qquad]
% \titlecontents{subsection}[0em]
% 	{\vspace{4pt}}
% 	{\normalfont\thecontentslabel\enspace\itshape}
% 	{\itshape}
% 	{\qquad\contentspage}[\vskip 0pt]
% \titlecontents*{subsection}[0em]
% 	{\vskip 0pt\small}
% 	{{\thecontentslabel}~~\itshape}
% 	{\color{darker_gray}\itshape}
% 	{~~{\color{main_accent}\contentspage}}
% 	[\qquad]
% \titlecontents{subsubsection}[1em]
% 	{\vspace{0pt}}
% 	{\normalfont\thecontentslabel\enspace\itshape}
% 	{\itshape}
% 	{\quad\quad\contentspage}[\vskip 0pt]

% TOCLOFT
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
% \newlistof{listings}{lol}{\lstlistlistingname}%
% \renewcommand{\cftlistingspresnum}{\scshape\MakeTextLowercase}%
% \renewcommand{\cftlistingsfont}{\normalfont}%
% \renewcommand{\cftlistingspresnum}{\lstlistingname~}%
% \renewcommand{\cftlistingspagefont}{\normalfont}%

% \renewcommand{\cftlistingsleader}{\hspace{1.5em}}%
% \renewcommand{\cftlistingsafterpnum}{\cftparfillskip}%
% \newlength{\listingslabelwidth}%
% \settowidth{\listingslabelwidth}{\cftlistingspresnum~999}%
% \addtolength{\listingslabelwidth}{2.5em}%
% %\cftsetindents{listings}{0em}{\listingslabelwidth}%
% \cftsetindents{listings}{0em}{\figurelabelwidth}%
% \let\l@lstlisting\l@listings%
% \let\lstlistoflistings\listoflistings%
% TOCLOFT over


%	toc offset
\let\oldtoc\tableofcontents
\renewcommand{\tableofcontents}{
\begin{quote}
\oldtoc
\end{quote}
}

%	toc depth
\AtBeginDocument{\setcounter{tocdepth}{1}}

%	T I G H T  L I S T S
%
\AtBeginDocument{
	\setlist{topsep=0pt, itemsep=0pt, noitemsep, leftmargin = 0pt}
}

% 	smaller bullets
\renewcommand{\labelitemi}{$\vcenter{\hbox{\small$\bullet$}}$}

%	C O D E
%
\usemintedstyle{colorful}
\definecolor{bg}{rgb}{.95,.95,.95} % background color
\mdfdefinestyle{code_box}{%
	backgroundcolor=bg,
	linewidth=1pt,
	linecolor=lightgray,
	topline=false,
	bottomline=false,
	leftline=false,
	rightline=false,
	innerleftmargin=32pt,
	innertopmargin=1em,
	innerbottommargin=1em,
	roundcorner=3pt
}
\mdfdefinestyle{code_box_nonos}{%
	backgroundcolor=bg,
	linewidth=1pt,
	linecolor=lightgray,
	topline=false,
	bottomline=false,
	leftline=false,
	rightline=false,
	innerleftmargin=12pt,
	innertopmargin=1em,
	innerbottommargin=1em,
	roundcorner=3pt
}
\renewcommand{\theFancyVerbLine}{
	\scriptsize
	\textcolor{black}{
		\texttt
		\oldstylenums{}
		\arabic{FancyVerbLine}
	}
}

%	macro environments
\newenvironment{codeboxnum}[1]{%
	\VerbatimEnvironment
	\begin{mdframed}[style = code_box]%
		\begin{minted}[
			breaklines,
			breakanywhere,
			fontsize=\small,
			linenos,
			tabsize=2,
			autogobble,
			numbersep=4pt,
		]{#1}%
}%
{%
		\end{minted}
	\end{mdframed}
}
\newenvironment{codebox}[1]{%
	\VerbatimEnvironment
	\begin{mdframed}[style = code_box_nonos]%
		\begin{minted}[
			breaklines,
		 	breakanywhere,
			fontsize=\small,
			tabsize=2,
		]{#1}%
}%
{%
		\end{minted}
	\end{mdframed}
}
\newenvironment{altcodebox}[1]{% to cite latex code containing codeboxes
	\VerbatimEnvironment
	\begin{mdframed}[style = code_box_nonos]%
		\begin{minted}[
			breaklines,
			breakanywhere,
			fontsize=\small,
			tabsize=2,
		]{#1}%
}%
{%
		\end{minted}
	\end{mdframed}
}
\newenvironment{nextcodebox}[1]{
	\VerbatimEnvironment
	\begin{mdframed}[style = code_box]
		\begin{minted}[
			breaklines,
			breakanywhere,
			fontsize=\small,
			linenos,
			firstnumber = last,
			tabsize=2,
			autogobble,
			numbersep=4pt,
		]{#1}
}%
{%
		\end{minted}
	\end{mdframed}
}

%	snippet environments
\newenvironment{snippetnum}[3]{%
	\VerbatimEnvironment%
	\marginpar{%
		\vskip 8pt%
		\captionof{listing}{#2}%
		\label{#3}%
	}\nopagebreak%
	\begin{mdframed}[style = code_box]%
		\begin{minted}[
			breaklines,
			breakanywhere,
			fontsize=\small,
			linenos,
			tabsize=2,
			autogobble,
			numbersep=4pt,
		]{#1}%
}%
{%
		\end{minted}%
	\end{mdframed}%
}
\newenvironment{snippet}[3]{
	\VerbatimEnvironment
	\marginpar{
		\vskip 8pt
		\captionof{listing}{#2}
		\label{#3}
	}\nopagebreak%
	\begin{mdframed}[style = code_box_nonos]%
		\begin{minted}[
			breaklines,
			breakanywhere,
			fontsize=\small,
			tabsize=2,
			autogobble,
		]{#1}%
}%
{%
		\end{minted}
	\end{mdframed}
}
\newenvironment{nextsnippet}[3]{
	\VerbatimEnvironment
	\marginpar{
		\vskip 8pt
		\captionof{listing}{#2}
		\label{#3}
	}\nopagebreak%
	\begin{mdframed}[style = code_box]%
		\begin{minted}[
			breaklines,
			breakanywhere,
			fontsize=\small,
			linenos,
			firstnumber = last,
			tabsize=2,
			autogobble,
			numbersep=4pt,
		]{#1}
}%
{%
		\end{minted}
	\end{mdframed}
}

%   Inline code
\newcommand{\inlinecode}[1]{\mintinline[bgcolor=bg, fontsize=\small]{#1}}

%	M I S C E L L A N E O U S
%
%	for  t i g h t  lists (pandoc style)
\providecommand{\tightlist}{%
	\setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}
}
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

%	M A T H  &  P H Y S I C S
%	S H O R T C U T S
%\iffalse
% uncomment this \iffalse
%and the \fi at the end to disable (or delete)

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
%fi
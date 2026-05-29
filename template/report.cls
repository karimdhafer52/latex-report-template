% Not used yet

\RequirePackage{fancyhdr} 


%================= configuring minitoc ==================%
\RequirePackage[french]{minitoc}
\mtcsettitle{minitoc}{Plan}
\setcounter{minitocdepth}{1}
\mtcsetrules{minitoc}{off}
\mtcsetoffset{minitoc}{-1.0em}

%% disabling chapter numbers
\newcommand{\filterminitoc}[1]{#1}
\renewcommand{\thesection}{\csname filterminitoc \endcsname{\arabic{chapter}.}\arabic{section}}
\newcommand{\minitocsection}{\begingroup\renewcommand{\filterminitoc}[1]{}\minitoc\endgroup}

%=============== Customizing Chapters Names ===============%
%@author: Stoufa
%Package pstcol Warning:
%************************************
%(pstcol) The package `pstcol' is obsolet!
%(pstcol) You should use `pstricks' directly:
%(pstcol) \RequirePackage{pstricks}
%(pstcol) ************************************
%\RequirePackage{pstcol}
\RequirePackage{pstricks}
\makeatletter
\def\thickhrulefill{\leavevmode \leaders \hrule height 1.2ex \hfill \kern \z@}

\def\@makechapterhead#1{
    \vspace*{10\p@}%
    {\parindent \z@ \centering \reset@font
        \thickhrulefill\quad 
        \scshape\bfseries\textit{\@chapapp{}  \thechapter}  
        \quad \thickhrulefill
        \par\nobreak
        \vspace*{10\p@}%
        \interlinepenalty\@M
        \hrule
        \vspace*{10\p@}%
        \Huge \bfseries #1 \par\nobreak
        \par
        \vspace*{10\p@}%
        \hrule
        \vskip 30\p@
    }
    \minitocsection
    \thispagestyle{empty}%
    \newpage
}
\def\@makeschapterhead#1{\hbox{%
    \huge\hbox{\textbf{#1}}%
}\par\vskip 1cm}

%================= configuring toc ==================%
% @author: Karim Dhafer
\RequirePackage{tocloft}        % Customize toc
% \renewcommand{\cftchappresnum}{\hspace*{-8em}}
% \setlength{\cftchapnumwidth}{0em}
\renewcommand{\cftchappresnum}{Chapitre~}
\renewcommand{\cftchapaftersnum}{~:}
\setlength{\cftchapnumwidth}{7em}
% \setlength{\cftsecnumwidth}{2em}
% \setlength{\cftsubsecnumwidth}{3em}
% \setlength{\cftsubsubsecnumwidth}{3.5em}

% \renewcommand{\thesection}{\arabic{section}}
% \renewcommand{\thesubsection}{\thesection.\arabic{subsection}}

\renewcommand{\thesection}{\arabic{section}.}
\renewcommand{\thesubsection}{\thesection\arabic{subsection}.}
\renewcommand{\thesubsubsection}{\thesubsection\arabic{subsubsection}.}
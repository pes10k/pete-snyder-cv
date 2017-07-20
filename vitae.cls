% vitae class v1.1
% March 3, 2004
% written by Peter Czoschke
%   with inspiration from Miklos Csuros's resume class
%
% Features:
% 
% 1 \address[2] command for home and office address
%       
% 2 redefined \section and \subsection commands (to * forms, among other things)
%
% 3 datelist environment for a list with a left column of dates, etc.
%
% 4 redefined thebibliography environment to be a "Publications" section with
%   appropriate indentation so that BiBTeX can be used (use \nocite{}'s).
%
% Style can be easily modified by changing the definitions of \titlenamefont,
% \sectionnamefont, \subsectionnamefont, and \datelistfont in the preamble of the document.
% Alternatively, the redefinitions of \section and \subsection can be altered
% in this file.
% Also see the options below for customization options.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vitae}[2004/03/03 v1.1 vitae class]

 %-----------------------------------------------------------
 % Options (defaults):
 %          in/cm               sets margins to either 1 in or 
 %                              1.5 cm all around (in)
 %          wideaddress         use one wide address under name
 %          rule/norule         Place a thick line under the name at
 %                              the top of the first page? (norule)
 %          secrule/nosecrule   Place a line 3/4 the text width under
 %                              each section name (secrule)
 
\newlength{\v@margin}
\newif\if@wideaddress\@wideaddressfalse
\newif\if@rule
\newif\if@secrule
\DeclareOption{wideaddress}{\@wideaddresstrue}
\DeclareOption{in}{\setlength{\v@margin}{1in}}
\DeclareOption{cm}{\setlength{\v@margin}{1.5cm}}
\DeclareOption{rule}{\@ruletrue}
\DeclareOption{norule}{\@rulefalse}
\DeclareOption{secrule}{\@secruletrue}
\DeclareOption{nosecrule}{\@secrulefalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{in,norule,secrule}
\ProcessOptions
\LoadClass{article}

\setlength{\footskip}{0pt}

\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-2\v@margin}
\setlength{\oddsidemargin}{\v@margin}
\addtolength{\oddsidemargin}{-1in}
\setlength{\evensidemargin}{\oddsidemargin}
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-\headheight}
\addtolength{\textheight}{-\headsep}
% \addtolength{\textheight}{-\footskip}
\addtolength{\textheight}{-1.4\v@margin}
\setlength{\topmargin}{0.7\v@margin}
\addtolength{\topmargin}{-1in}

\setlength{\parindent}{0in}
\setlength{\parskip}{0in}

% -------------------------------------------------------
%  The following definitions can be changed in the LaTeX
%  file for a different look but the same structure. The 
%  rest of this file defines the structure and the 
%  commands.
% -------------------------------------------------------

\newcommand*{\titlenamefont}{\bfseries\LARGE}  % the font used to print the name
                    % on the top of the 1st page
\newcommand*{\sectionnamefont}{\normalfont\large\scshape}  % font used for section names
\newcommand*{\subsectionnamefont}{\normalfont\normalsize\slshape} % subsection names
\newcommand*{\datelistfont}{\slshape} % Dates in datelist environment

% -------------------------------------------------------
% - new commands
% -------------------------------------------------------
\newlength{\titlewidth}
\newlength{\addresswidth}

%%%%%%% \address                                       
\gdef\@addressA{\ClassWarning{vitae}{%
    No address given.\MessageBreak
    Use \protect\address.}}
\newcommand{\address}[2]{\gdef\@addressA{#1}\gdef\@addressB{#2}}

%%%%%%% \author
\gdef\@author{\ClassError{vitae}{%
    No author given.}{%
    Use \protect\author\space to specify it.}}

%%%%%% redefine the section command
\renewcommand{\section}{\@startsection {section}{1}{-0.3\v@margin}%
    {-3ex plus -2ex minus -1ex}%
    {1ex plus 0.5ex}%
    {\if@secrule \makebox[0pt][l]{\hspace*{-0.3\v@margin}\rule[-0.4ex]{17.25cm}{0.5pt}}\fi\sectionnamefont}*} 

%%%%%% redefine the subsection command
\renewcommand{\subsection}{\@startsection {subsection}{2}{-0.15\v@margin}%
    {-2ex plus -1ex minus -1ex}%
    {1ex plus 0.5ex}%
    {\subsectionnamefont}*}

%%%%%% datelist environment.  The one optional argument is the width of label area
\newenvironment{datelist}[1][1in]
    {\begin{list}{}{
     \setlength{\parsep}{0.5ex plus 0.5ex minus 0.2ex}
%     \setlength{\itemsep}{0.07in}
     \setlength{\topsep}{0ex}
     \setlength{\leftmargin}{#1}
     \setlength{\labelwidth}{#1}
     \addtolength{\labelwidth}{-\labelsep}
     \let\makelabel\datelistlabel}
    }
    {\end{list}}

\newcommand*{\datelistlabel}[1]{\parbox[t]{\labelwidth}{\datelistfont #1}}

%%% command to list publications:
%%%  authors, title, journal, volume, pages, year
\newcommand{\pitem}[6]{%
    \item #1, ``#2,'' \textsl{#3}~\textbf{#4},~#5~(#6).}

%%%%%%% define our own page style -- vitaehead
\newcommand*{\ps@vitaehead}{%
    \renewcommand*{\@oddfoot}{}
%     \renewcommand*{\@oddfoot}{\hfill\@author~(\thepage~of~\lastpagenum)\hfill}
    \renewcommand*{\@evenfoot}{\@oddfoot}
    \renewcommand*{\@oddhead}{}
    \renewcommand*{\@evenhead}{\@oddhead}
}

%% We need these commands to set up a label at the end of the document.
%% This provides the pagenumbering effect of e.g. (2 of 3) in the header.
\AtBeginDocument{\newcommand*{\lastpagenum}{\pageref{vitaeclass:lastpage}}}
\AtEndDocument{\label{vitaeclass:lastpage}}

%%%%%%% \maketitle
\renewcommand{\maketitle}{%
    \setlength{\titlewidth}{\textwidth}
    \addtolength{\titlewidth}{0.6\v@margin}
    \setlength{\addresswidth}{0.5\textwidth}
  \begingroup
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@makeresumetitle
      \else
        \twocolumn[\@makeresumetitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@makeresumetitle
    \fi
    \thispagestyle{empty}
  \endgroup
  \pagestyle{vitaehead}
  \setcounter{footnote}{0}%
  \let\thanks\relax
  \let\maketitle\relax
  \let\@makeresumetitle\relax
  \gdef\@thanks{}
%  \gdef\@author{}
  \gdef\@title{}
}
  
\def\@makeresumetitle{%
  \newpage
  \vspace*{-\headheight}\vspace*{-\headsep}
    \def\@moveleft{\hspace*{-0.3\v@margin}}
  \@moveleft
  \makebox[\titlewidth]{\titlenamefont\@author}\\
  \if@rule
        \@moveleft
        \rule{\titlewidth}{2pt}
  \fi
%  \@moveleft
  \if@wideaddress
    \centering\parbox{1.5\addresswidth}{\begin{center}\@addressA\\\@addressB\end{center}}
  \else
    \parbox[t]{\addresswidth}{\begin{flushleft}\@addressA\end{flushleft}}\hfill%
    \parbox[t]{\addresswidth}{\begin{flushright}\@addressB\end{flushright}}
  \fi
  \par
  \vskip 1.5ex}

\renewcommand{\refname}{Publications}
\renewenvironment{thebibliography}[1]
     {\section{\refname}%
      \begin{list}{}%
           {\setlength{\labelwidth}{0in}
            \addtolength{\itemindent}{-\leftmargin}
            \@openbib@code
            \usecounter{enumiv}}%
      \sloppy%
     }
     {\def\@noitemerr
       {\ClassWarning{vitae}{Empty Publications section.\MessageBreak Use \protect\nocite's.}}%
      \end{list}}

\endinput

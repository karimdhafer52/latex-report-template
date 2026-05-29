# LaTeX Snippet Cheat Sheet

> **Usage:** Copy-paste ready. Every snippet matches the conventions used in this project (`report` class, `biblatex`/Biber, `xcolor`, `tcolorbox`, `algorithm`/`algpseudocode`).  
> For rendered output of each snippet, see `docs/snippets.tex`.

---

## Table of Contents

1. [Text Formatting](#1-text-formatting)
2. [Warning Box](#2-warning-box)
3. [Figures](#3-figures)
4. [Lists](#4-lists)
5. [Tables](#5-tables)
6. [Citations](#6-citations)
7. [Math](#7-math)
8. [Code Listings](#8-code-listings)
9. [Algorithms](#9-algorithms)
10. [Cross-References](#10-cross-references)
11. [Spacing & Layout Utilities](#11-spacing--layout-utilities)

---

## 1. Text Formatting

```latex
\textit{Italic text}          % Italic — use for emphasis, titles, terms
\textbf{Bold text}            % Bold — use for key terms, warnings
\texttt{monospace text}       % Monospace — use for code, file paths
\underline{underlined text}   % Underline — avoid in academic writing
\textsc{Small Caps}           % Small caps — use for acronyms
```

### Combined formatting

```latex
\textit{\textbf{Bold italic}}          % Bold + italic
\textcolor{red}{Colored text}          % Requires xcolor
\textcolor{darkblue}{Colored text}     % Using a custom defined color (see commands.tex)
```

---

## 2. Warning Box

Uses the `tcolorbox` environment defined in `preamble/commands.tex`.

```latex
\begin{warningbox}
    \begin{itemize}[label=\textbf{$\rightarrow$}]
        \item First warning or note here.
        \item Second warning or note here.
    \end{itemize}
\end{warningbox}
```

| Field | Purpose |
|---|---|
| `warningbox` | Custom `tcolorbox` environment (orange frame, pale background) |
| `label=\textbf{$\rightarrow$}` | Replaces default bullet with a bold arrow |
| `\item` | Each point in the warning |

---

## 3. Figures

### Standard figure

```latex
\begin{figure}[H]
    \centering
    \includegraphics[width=0.8\textwidth]{content/chapterX/figures/fig_name.png}
    \caption{Caption describing the figure}
    \label{fig:fig_label}
\end{figure}
```

| Field | Purpose |
|---|---|
| `[H]` | Forces figure to appear exactly here (requires `float` package) |
| `\centering` | Centers the image horizontally |
| `width=0.8\textwidth` | Image width as a fraction of the text column width |
| `{content/chapterX/figures/fig_name.png}` | Path relative to `main.tex`; use the chapter's `figures/` folder |
| `\caption{}` | Figure caption — appears below the image, indexed in List of Figures |
| `\label{fig:...}` | Internal label for cross-referencing with `\ref{}` |

### Custom width or height

```latex
\includegraphics[width=5cm]{path/to/image.png}          % Fixed width
\includegraphics[height=4cm]{path/to/image.png}         % Fixed height
\includegraphics[scale=0.5]{path/to/image.png}          % Scale by factor
\includegraphics[width=\linewidth]{path/to/image.png}   % Full column width
```

### Side-by-side figures (subfigures)

```latex
\usepackage{subcaption} % Add to preamble/packages.tex

\begin{figure}[H]
    \centering
    \begin{subfigure}[b]{0.45\textwidth}
        \includegraphics[width=\textwidth]{path/fig_a.png}
        \caption{Left figure}
        \label{fig:left}
    \end{subfigure}
    \hfill
    \begin{subfigure}[b]{0.45\textwidth}
        \includegraphics[width=\textwidth]{path/fig_b.png}
        \caption{Right figure}
        \label{fig:right}
    \end{subfigure}
    \caption{Overall caption for both figures}
    \label{fig:both}
\end{figure}
```

---

## 4. Lists

### Unordered list

```latex
\begin{itemize}
    \item First bullet point.
    \item Second bullet point.
    \item Third bullet point.
\end{itemize}
```

### Ordered list

```latex
\begin{enumerate}
    \item First numbered item.
    \item Second numbered item.
    \begin{itemize}
        \item Nested bullet under item 2.
    \end{itemize}
    \item Third numbered item.
\end{enumerate}
```

### Custom label (arrow bullets)

```latex
\begin{itemize}[label=\textbf{$\rightarrow$}]
    \item Item with arrow bullet.
    \item Another item.
\end{itemize}
```

| Field | Purpose |
|---|---|
| `label=` | Overrides the default bullet symbol (requires `enumitem`) |
| `$\rightarrow$` | Right arrow in math mode; wrap in `\textbf{}` to bold it |

### Compact list (reduced spacing)

```latex
\begin{itemize}[noitemsep]
    \item Compact item one.
    \item Compact item two.
\end{itemize}
```

---

## 5. Tables

### Table 1 — Colored cell grid (comparison table)

```latex
\begin{table}[H]
    \centering
    \renewcommand{\arraystretch}{1.3}
    \setlength{\tabcolsep}{5pt}

    \begin{tabular}{|p{2.5cm}|p{6cm}|p{6cm}|}
        \hline
        \rowcolor{gray!20}
        \textbf{Criterion} & \textbf{Option A} & \textbf{Option B} \\
        \hline

        \rowcolor{gray!15}
        \textbf{Row 1}
        & \cellcolor{green!10} Advantage A
        & \cellcolor{blue!10} Advantage B \\
        \hline

        \rowcolor{gray!15}
        \textbf{Row 2}
        & \cellcolor{orange!10} Note A
        & \cellcolor{red!10} Note B \\
        \hline
    \end{tabular}

    \caption{Comparison table caption}
    \label{tab:comparison}
\end{table}
```

| Field | Purpose |
|---|---|
| `\renewcommand{\arraystretch}{1.3}` | Increases row height (1.0 = default, 1.5 = spacious) |
| `\setlength{\tabcolsep}{5pt}` | Horizontal padding inside cells |
| `p{Xcm}` | Fixed-width column with automatic text wrap |
| `\rowcolor{gray!20}` | Colors an entire row; `gray!20` = 20% gray (requires `colortbl`) |
| `\cellcolor{green!10}` | Colors a single cell independently of `\rowcolor` |
| `\hline` | Horizontal rule between rows |

### Table 2 — Alternating row colors with dark header

```latex
\begin{table}[H]
    \centering
    \renewcommand{\arraystretch}{1.5}
    \setlength{\tabcolsep}{12pt}

    \rowcolors{2}{white}{lightblue}
    \begin{tabular}{|p{6cm}|c|p{4cm}|}
        \hline
        \rowcolor{darkblue}
        \textcolor{white}{Column A} & \textcolor{white}{Column B} & \textcolor{white}{Column C} \\
        \hline
        Row data 1 & Value & Description \\
        Row data 2 & Value & Description \\
        \hline
    \end{tabular}

    \caption{Table with alternating rows and dark header}
    \label{tab:alternating}
\end{table}
```

| Field | Purpose |
|---|---|
| `\rowcolors{2}{white}{lightblue}` | Alternates row colors starting at row 2: odd=white, even=lightblue |
| `\rowcolor{darkblue}` | Overrides `\rowcolors` for the header row only |
| `\textcolor{white}{...}` | White text on dark header background |
| `c` | Center-aligned column (auto width) |

### Table 3 — Two-column side-by-side comparison

```latex
\rowcolors{2}{gray!10}{white}
\begin{table}[H]
    \centering
    \renewcommand{\arraystretch}{1.3}

    \begin{tabular}{|p{7cm}|p{7cm}|}
        \hline
        \rowcolor{gray!30}
        \textbf{Aspect} & \textbf{Observation} \\
        \hline
        \rowcolor{blue!10}  Point A & \cellcolor{red!10} Response A \\
        \hline
        \rowcolor{blue!10}  Point B & \cellcolor{red!10} Response B \\
        \hline
        \rowcolor{blue!10}  Point C & \cellcolor{red!10} Response C \\
        \hline
    \end{tabular}
    \caption{Two-column comparison}
    \label{tab:twocol}
\end{table}
```

> **Note:** `\rowcolors{}{}{}` must be declared **before** `\begin{table}` and before `\begin{tabular}` to take effect correctly.

---

## 6. Citations

Uses `biblatex` with `biber` backend (configured in `preamble/packages.tex`).

```latex
% Author becomes subject of the sentence
\textcite{authorsyeartitle}
% → Smith (2023) argues that...

% Citation in parentheses at end of sentence
\parencite{authorsyeartitle}
% → (Smith, 2023)

% Citation with page number
\parencite[42]{authorsyeartitle}
% → (Smith, 2023, p. 42)

% Citation with prefix and page number
\parencite[see][42]{authorsyeartitle}
% → (see Smith, 2023, p. 42)

% Multiple sources in one citation
\parencite{authorAyeartitle, authorByeartitle}
% → (Smith, 2023; Jones, 2021)

% Generic citation (output depends on style setting)
\cite{authorsyeartitle}
```

### Key naming convention

```
authorsyeartitle
│      │    │
│      │    └── First significant word of the title (lowercase)
│      └──────── Publication year (4 digits)
└─────────────── First author's last name (lowercase)
```

### Protecting author name formatting in `.bib` files

```bibtex
@book{authorsyeartitle,
  author = {\protect\normalfont{Karim DHAFER}},
  ...
}
```

> Use `\protect\normalfont{}` when your bibliography style forces small caps on names and you want to override it for a specific entry.

---

## 7. Math

### Inline math

```latex
The result is $x = \frac{a}{b}$ where $a, b \in \mathbb{R}$.
```

### Display math (numbered equation)

```latex
\begin{equation}
    E = mc^2
    \label{eq:einstein}
\end{equation}
```

### Display math (unnumbered)

```latex
\[
    \sum_{i=1}^{n} x_i = \bar{x} \cdot n
\]
```

### Aligned multi-line equations

```latex
\begin{align}
    f(x) &= x^2 + 2x + 1 \\
         &= (x + 1)^2
    \label{eq:factored}
\end{align}
```

### Common symbols

```latex
\forall x \in \mathbb{R}     % ∀ x ∈ ℝ  (note: \forall auto-adds spacing via commands.tex)
\exists y \geq 0             % ∃ y ≥ 0
\sum_{i=0}^{n}               % Σ with bounds
\int_{a}^{b} f(x)\,dx       % ∫ with bounds and thin space before dx
\frac{numerator}{denominator}
\sqrt{x}  \quad \sqrt[n]{x} % Square root, nth root
\mathbf{v}                   % Bold vector notation
\|v\|                        % Norm
```

---

## 8. Code Listings

Uses `listingsutf8` (configured in `preamble/commands.tex`).

### Inline code block

```latex
\begin{lstlisting}
public class Example {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
\end{lstlisting}
```

### Code from an external file

```latex
\lstinputlisting[language=Python]{assets/code/my_script.py}
```

### Inline monospace snippet (short)

```latex
Use the \texttt{main.tex} file as the entry point.
```

### Keyboard shortcut highlight

```latex
Press \texttt{\textbf{\textcolor{blue}{CTRL+SHIFT+T}}} to open the test dialog.
```

---

## 9. Algorithms

Uses `algorithm` + `algpseudocode` with French keyword overrides (configured in `preamble/commands.tex`).

```latex
\begin{algorithm}[H]
    \caption{Algorithm Name}
    \label{alg:algo_label}
    \begin{algorithmic}[1]
        \Require Square matrix $A$ of size $n \times n$.

        \Function{FunctionName}{$A: \text{Matrix}, n: \text{Integer}$}
        \VarNoIndent{}
            \State $s, i, j, k, p$ : Integers
        \DebutNoIndent
            \For{$p \text{ from } 1 \text{ to } n$}
                \For{$j \text{ from } p \text{ to } n$}
                    \State $s \gets 0$
                    \For{$k \text{ from } 1 \text{ to } p-1$}
                        \State $s \gets s + A[p,k] \times A[k,j]$
                    \EndFor
                    \State $A[p,j] \gets A[p,j] - s$
                \EndFor
            \EndFor
            \State \Return $A$
        \EndFunction
    \end{algorithmic}
\end{algorithm}
```

| Field | Purpose |
|---|---|
| `[H]` | Place algorithm exactly here |
| `[1]` in `algorithmic` | Show line numbers (use `[0]` to hide) |
| `\Require` | Input precondition (rendered as **Pré-requis:** via `commands.tex`) |
| `\Function{Name}{params}` | Opens a named function block |
| `\VarNoIndent{}` | Custom command — prints **Var** keyword at left margin |
| `\DebutNoIndent` | Custom command — prints **Début** keyword at left margin |
| `\State` | A single statement line |
| `\For / \EndFor` | For loop block |
| `\If / \Else / \EndIf` | Conditional block |
| `\Return` | Return statement |
| `\gets` | Assignment arrow ($\leftarrow$) |

---

## 10. Cross-References

```latex
% Referencing a figure
As shown in Figure~\ref{fig:fig_label}...
As this figure~\ref{fig:fig_label} illustrates...

% Referencing a table
See Table~\ref{tab:table_label} for details.

% Referencing an equation
From Equation~\ref{eq:einstein}, we derive...

% Referencing a section
As discussed in Section~\ref{sec:section_label}...

% Referencing an algorithm
Algorithm~\ref{alg:algo_label} describes the procedure.

% Non-breaking space before \ref is mandatory
% The tilde ~ prevents a line break between "Figure" and the number
```

### Label naming convention

| Type | Prefix | Example |
|---|---|---|
| Figure | `fig:` | `\label{fig:architecture_diagram}` |
| Table | `tab:` | `\label{tab:results_summary}` |
| Equation | `eq:` | `\label{eq:loss_function}` |
| Section | `sec:` | `\label{sec:methodology}` |
| Algorithm | `alg:` | `\label{alg:gradient_descent}` |
| Chapter | `chap:` | `\label{chap:introduction}` |

---

## 11. Spacing & Layout Utilities

```latex
\bigskip          % Large vertical space (~12pt)
\medskip          % Medium vertical space (~6pt)
\smallskip        % Small vertical space (~3pt)
\vspace{1cm}      % Explicit vertical space
\hspace{1em}      % Explicit horizontal space
\noindent         % Suppress paragraph indent on this line
\clearpage        % End page + flush all pending floats
\newpage          % End page (floats may carry over)
\\[0.5cm]         % Line break with extra vertical space
\rule{\textwidth}{1pt}   % Full-width horizontal rule, 1pt thick
```

### Chapter/section page break behavior

```latex
\include{content/chapterX/chapterX}   % Always starts on new page; preferred for chapters
\input{preamble/frontmatter}          % No page break; used for preamble fragments
```

> Use `\include{}` for chapters (it generates `.aux` files enabling `\includeonly` for faster compilation during drafting). Use `\input{}` for preamble fragments and sub-section files.
# Roadmap & Learning Path

This file tracks two things in parallel:
- **Pending fixes** — known issues in the current project to resolve
- **Learning path** — advanced LaTeX techniques to study and eventually integrate

Each topic links directly to what would change in the project architecture when applied.

---

## Pending Fixes

> Small issues already identified in the current codebase.

- [ ] Add page numbers to LoF and LoT entries
- [ ] Customize figure label display format (e.g., `Fig. 1 —` prefix)
- [ ] Center and increase top margin of TOC, LoF, LoT titles
- [ ] Fix `hyperref` anchor placement for figures (link should jump to the image, not its caption)
- [ ] Merge duplicate `\lstset{}` blocks in `preamble/commands.tex` into one canonical block
- [ ] Replace all `\usepackage` calls in `template/report.cls` with `\RequirePackage`
- [ ] Define missing `cligray` color before it is used in `clistyle` in `preamble/commands.tex`
- [ ] Consolidate `minitoc` configuration — single source of truth in `template/mymtcstyle.sty`

---

## Learning Path

Topics are ordered from immediately applicable to advanced. Each entry includes what to study, why it matters, and where it would plug into this project's architecture.

---

### 1. Treat LaTeX Like a Programming Language — Abstraction via Commands

**What to study:** `\newcommand`, `\renewcommand`, and the `xparse` package for flexible argument handling.

```latex
% Basic — no arguments
\newcommand{\R}{\mathbb{R}}

% xparse — optional and mandatory arguments, stars, defaults
\usepackage{xparse}
\NewDocumentCommand{\vect}{m}{\mathbf{#1}}       % \vect{v} → bold v
\NewDocumentCommand{\norm}{O{2} m}{\|#2\|_{#1}}  % \norm{v} or \norm[p]{v}
```

**Why it matters:** Changing notation across a 60-page document becomes a one-line edit instead of a find-and-replace.

**Where it plugs in:** `preamble/commands.tex` — the file already exists for exactly this purpose.

---

### 2. Build a Style System — Separate Content from Presentation

**What to study:** Consolidate all visual decisions into `template/report.cls` or a dedicated `template/style.sty`. Use these packages as the tooling:

| Package | Controls |
|---|---|
| `titlesec` | Section, subsection, and chapter heading typography |
| `tocloft` | TOC/LoF/LoT entry spacing, fonts, dot leaders |
| `geometry` | Margins, paper size, header/footer clearance |
| `fancyhdr` | Header and footer content and rules |

**Why it matters:** Once formatting is centralized, editing content never breaks layout and vice versa — the same separation CSS brings to HTML.

**Where it plugs in:** `template/report.cls` for document-class-level rules; extract inline formatting from `preamble/commands.tex` and `preamble/config.tex` progressively.

---

### 3. Master Floats — Figures and Tables at Published Quality

**What to study:** Float placement mechanics and the `booktabs` package for professional tables.

```latex
% Replace \hline-based tables with booktabs rules
\usepackage{booktabs}

\begin{tabular}{lcc}
    \toprule
    Header A    & Header B  & Header C \\
    \midrule
    Row 1       & Value     & Value    \\
    Row 2       & Value     & Value    \\
    \bottomrule
\end{tabular}
```

Also study: `subcaption` for side-by-side figures, `caption` package for fine-grained caption styling, and the difference between `[H]`, `[htbp]`, and `[!t]` placement specifiers.

**Why it matters:** `booktabs` tables alone visually elevate a document from student report to publication standard.

**Where it plugs in:** `preamble/packages.tex` (add `booktabs`, `subcaption`, `caption`); update table snippets in `SNIPPETS.md` and `docs/snippets.tex`.

---

### 4. Smart Cross-Referencing with `cleveref`

**What to study:** The `cleveref` package, which replaces manual `Figure~\ref{}` with automatic type-aware labels.

```latex
\usepackage{cleveref}   % must be loaded AFTER hyperref

% Instead of:
As shown in Figure~\ref{fig:arch}

% Write:
As shown in \cref{fig:arch}       % → "Figure 2"
As shown in \Cref{fig:arch}       % → "Figure 2" (capitalised, for sentence start)

% Multiple references at once:
\cref{fig:a,fig:b,tab:results}    % → "Figures 1 and 2 and Table 3"
```

**Why it matters:** Eliminates the whole class of errors where the label says "Figure" but the object is actually a table.

**Where it plugs in:** `preamble/packages.tex` (add after `hyperref`); update cross-reference snippets in `SNIPPETS.md`.

---

### 5. Bibliography Mastery — `biblatex` + `biber` Full Control

**What to study:** Advanced `biblatex` features beyond basic `\parencite` — style switching, per-type formatting, field suppression, and custom drivers.

```latex
% Style variants to explore:
\usepackage[backend=biber, style=numeric]{biblatex}      % [1]
\usepackage[backend=biber, style=authoryear]{biblatex}   % (Smith, 2023)
\usepackage[backend=biber, style=ieee]{biblatex}         % IEEE standard

% Suppress specific fields globally:
\AtEveryBibitem{\clearfield{url}}      % Remove URLs from all entries
\AtEveryBibitem{\clearfield{isbn}}     % Remove ISBNs
```

**Why it matters:** The current setup works but is minimal. Full mastery means customizing what every reference type prints and how.

**Where it plugs in:** `preamble/packages.tex` (biblatex options); `preamble/bibliography.tex` (source declarations); `preamble/backmatter.tex` (print options).

---

### 6. Conditional and Modular Compilation

**What to study:** `\includeonly` for fast partial builds, and `\newif` for feature flags.

```latex
% In main.tex — compile only selected chapters during drafting
\includeonly{content/chapter1/chapter1, content/chapter2/chapter2}

% Custom boolean flags
\newif\ifdraft
\drafttrue          % Set to \draftfalse to disable

\ifdraft
    \usepackage{todonotes}   % Only loaded in draft mode
\fi
```

**Why it matters:** On a large document, a full build takes 30+ seconds. `\includeonly` drops this to 3–5 seconds during active writing.

**Where it plugs in:** `main.tex` (add `\includeonly` during drafting); `preamble/packages.tex` (guard draft-only packages with `\ifdraft`).

---

### 7. Developer Tools — Debugging and Annotation

**What to study:** Three packages that make development and review dramatically easier.

```latex
\usepackage{showframe}    % Draws visible boxes around margins and text areas
\usepackage{todonotes}    % Inline margin comments during writing
\usepackage{nag}          % Warns about obsolete LaTeX commands on compile
```

```latex
% todonotes usage:
\todo{Rewrite this section}
\todo[color=green]{Add figure here}
\missingfigure{Placeholder until the real figure is ready}

% Print all todos as a list:
\listoftodos
```

**Why it matters:** `todonotes` alone replaces scattered inline `% TODO` comments with a trackable, printable task list.

**Where it plugs in:** `preamble/packages.tex` (guarded by `\ifdraft`); `\listoftodos` call in `preamble/frontmatter.tex` during drafting.

---

### 8. TikZ — Programmatic Diagrams

**What to study:** The `tikz` package — start with basic shapes and arrows, then progress to libraries.

```latex
\usepackage{tikz}
\usetikzlibrary{arrows.meta, shapes.geometric, positioning, fit}

% Minimal flowchart node:
\begin{tikzpicture}
    \node[draw, rectangle] (A) {Start};
    \node[draw, diamond, below=of A] (B) {Condition?};
    \draw[->] (A) -- (B);
\end{tikzpicture}
```

Useful libraries to explore in order: `arrows.meta` → `shapes` → `positioning` → `calc` → `graphs`.

**Why it matters:** Any diagram produced in TikZ is resolution-independent, editable as code, and version-controllable — unlike exported PNG/SVG files.

**Where it plugs in:** `assets/` could gain a `tikz/` subfolder for reusable diagram definitions; figures in `content/chapterN/figures/` become `.tex` files instead of `.png`.

---

### 9. Custom Environments

**What to study:** `\newenvironment` and `tcolorbox` for semantic, reusable content blocks.

```latex
% Basic environment with \newenvironment:
\newenvironment{important}
    {\begin{quote}\bfseries\color{darkblue}}
    {\end{quote}}

% Richer environment with tcolorbox:
\newtcolorbox{definitionbox}[1]{
    colback=blue!5!white,
    colframe=darkblue,
    title={Definition: #1},
    fonttitle=\bfseries
}
```

```latex
% Usage:
\begin{definitionbox}{Gradient Descent}
    An iterative optimization algorithm that minimizes a function
    by moving in the direction of the negative gradient.
\end{definitionbox}
```

**Why it matters:** Theorems, definitions, remarks, and examples become consistent and visually distinctive with no inline formatting effort.

**Where it plugs in:** `preamble/commands.tex` (new environment definitions); document already has `warningbox` as a working example to build on.

---

### 10. Compile Optimization and Workflow Automation

**What to study:** `latexmk` configuration via a `.latexmkrc` file.

```perl
# .latexmkrc — place in project root
$pdf_mode = 5;          # Use xelatex
$xelatex = 'xelatex -interaction=nonstopmode -synctex=1 %O %S';
$bibtex_use = 2;        # Run biber automatically
$clean_ext = 'aux bbl bcf blg fdb_latexmk fls log run.xml synctex.gz toc lof lot';
```

Then compile with simply:
```bash
latexmk        # Full build
latexmk -c    # Clean auxiliary files
latexmk -C    # Clean everything including PDF
```

**Why it matters:** Eliminates the manual xelatex → biber → xelatex → xelatex sequence. One command handles all passes in the correct order.

**Where it plugs in:** `.latexmkrc` file at project root; update `README.md` Quick Start section once configured.

---

### 11. Micro-typography

**What to study:** The `microtype` package — load it and it works automatically.

```latex
% In preamble/packages.tex — add near the end, after fonts are loaded
\usepackage{microtype}
```

Optionally fine-tune:
```latex
\usepackage[
    protrusion=true,     % Allows punctuation to hang slightly into margins
    expansion=true,      % Slight font width adjustment for even spacing
    tracking=true        % Letter-spacing control for small caps
]{microtype}
```

**Why it matters:** Reduces overfull `\hbox` warnings, eliminates rivers in justified text, and produces the subtle visual polish that distinguishes professionally typeset documents — even when you cannot identify the source of the improvement.

**Where it plugs in:** `preamble/packages.tex` — one line, zero maintenance cost, immediate visible improvement.

---

## Suggested Study Order

For a structured progression, tackle topics in this sequence:

```
Immediate wins (1–2 days each):
  11. microtype          → one line, instant improvement
   4. cleveref           → drop-in replacement for \ref
   7. developer tools    → todonotes improves your writing workflow

Medium effort (1 week each):
   1. xparse commands    → start abstracting your notation
   3. booktabs tables    → replace all \hline tables
   6. conditional comp.  → add \includeonly to main.tex

Architecture investments (ongoing):
   2. style system       → migrate formatting into report.cls
   5. biblatex advanced  → customize per reference type
   9. environments       → build a full theorem/definition system
  10. latexmkrc          → automate your build

Long-term mastery:
   8. TikZ               → replace all external diagram images
```
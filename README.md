# latex-intro

A fully modular, production-grade LaTeX project template designed for structured academic and technical reports. Originally developed as an introductory LaTeX project, this repository has been refactored into a clean, scalable architecture suitable for multi-chapter documents with multilingual support (French, Arabic), custom class files, and a separated bibliography system.

---

## Table of Contents

- [Quick Start](#quick-start)
- [Prerequisites](#prerequisites)
- [Project Architecture](#project-architecture)
- [Directory Breakdown](#directory-breakdown)
- [Compilation Flow](#compilation-flow)
- [File Relations](#file-relations)
- [Multilingual Support](#multilingual-support)
- [Bibliography System](#bibliography-system)
- [Customization Guide](#customization-guide)
- [Pending Improvements](#pending-improvements)

---

## Quick Start

> **New to this project?** Follow these steps to clone, set up, and compile the document in under five minutes.

### 1. Clone the Repository

```bash
git clone https://github.com/<your-username>/latex-intro.git
cd latex-intro
```

### 2. Install Prerequisites

| Tool | Purpose | Install |
|---|---|---|
| TeX Live 2023+ or MiKTeX | LaTeX distribution | [tug.org/texlive](https://tug.org/texlive/) |
| XeLaTeX engine | Required for `fontspec` & Arabic support | Included in TeX Live |
| Biber | Bibliography processor | Included in TeX Live |
| Amiri font | Arabic rendering | [amirifont.org](https://www.amirifont.org/) |
| Latexmk *(optional)* | Automated build tool | Included in TeX Live |

### 3. Compile the Document

**Recommended — using Latexmk (auto-handles all passes):**
```bash
latexmk -xelatex main.tex
```

**Manual — step-by-step (if Latexmk is unavailable):**
```bash
xelatex main.tex        # First pass: generates .aux files
biber main              # Processes bibliography
xelatex main.tex        # Second pass: resolves references
xelatex main.tex        # Third pass: finalises TOC and page numbers
```

> ⚠️ **Always use `xelatex`**, not `pdflatex`. The `fontspec` and `polyglossia` packages require the XeTeX engine for Unicode and Arabic font support.

### 4. Output

The compiled PDF will be generated as `main.pdf` in the project root.

---

## Prerequisites

- **LaTeX engine:** XeLaTeX (XeTeX engine)
- **TeX distribution:** TeX Live 2023 or MiKTeX (with all packages updated)
- **Bibliography backend:** Biber (not BibTeX — see [Bibliography System](#bibliography-system))
- **System font:** Amiri (must be installed at the OS level for XeLaTeX to locate it)

---

## Project Architecture

```
latex-intro/
├── main.tex                    ← Master entry point
├── main.pdf                    ← Compiled output (do not edit)
├── README.md                   ← This file
├── ROADMAP.md                  ← Pending fixes and advanced LaTeX learning path
├── SNIPPETS.md                 ← Copy-paste LaTeX command reference
├── .gitignore                  ← Excludes build artifacts (*.aux, *.log, etc.)
├── template/
│   ├── report.cls              ← Custom document class (chapter style, TOC, headers)
│   └── mymtcstyle.sty          ← Custom minitoc styling package
├── preamble/
│   ├── packages.tex            ← All \usepackage declarations
│   ├── config.tex              ← Global settings (geometry, spacing, colors)
│   ├── commands.tex            ← Custom macros and environments
│   ├── titlepage.tex           ← Title page layout
│   ├── frontmatter.tex         ← TOC, list of figures, list of tables
│   ├── bibliography.tex        ← \addbibresource declarations (preamble only)
│   └── backmatter.tex          ← \printbibliography, appendix configuration
├── content/
│   ├── general_introduction.tex
│   ├── chapter1/
│   │   ├── chapter1.tex        ← Chapter root file (\input{} sections)
│   │   ├── introduction.tex
│   │   ├── section1.tex
│   │   ├── section2.tex
│   │   ├── conclusion.tex
│   │   └── figures/            ← Chapter-scoped images
│   ├── chapter2/
│   │   └── ...                 ← Same structure as chapter1/
│   ├── annexes/
│   │   └── annexA.tex
│   └── general_conclusion.tex
├── bibliography/
│   ├── academic/
│   │   ├── journals.bib
│   │   ├── conferences.bib
│   │   └── theses.bib
│   ├── books.bib
│   ├── reports.bib
│   ├── websites.bib
│   └── style.bst               ← Custom bibliography style
├── docs/
│   ├── snippets.tex            ← Compilable snippet gallery (rendered reference)
│   ├── bibliography-architecture.tex
│   └── citation-style-guide.tex
└── assets/
    ├── images/                 ← Global/shared images
    └── code/                   ← Source code files for listings
```

---

## Directory Breakdown

| Directory / File | Role |
|---|---|
| `main.tex` | Master file. Loads the class, inputs all preamble files, then inputs all content files in order. **The only file XeLaTeX is called on directly.** |
| `main.pdf` | Compiled output. Committed to the repo for reference; regenerated on every build. |
| `README.md` | Project documentation (this file). |
| `SNIPPETS.md` | Quick-reference cheat sheet of copy-paste LaTeX commands with field-by-field explanations. |
| `.gitignore` | Excludes all LaTeX build artifacts (`*.aux`, `*.log`, `*.bbl`, `*.synctex.gz`, etc.) from version control. |
| `template/report.cls` | Custom document class extending the built-in `report` class. Defines chapter heading style, section numbering format, header/footer rules, and TOC customization. |
| `template/mymtcstyle.sty` | Custom package for `minitoc` styling. Centralizes all minitoc font, spacing, rule, and title settings. Loaded via `\usepackage{template/mymtcstyle}` in `packages.tex`. |
| `preamble/packages.tex` | Single source of truth for all `\usepackage{}` declarations. No packages should be loaded anywhere else. |
| `preamble/config.tex` | Global configuration: page geometry, line spacing, color palette definitions, `hyperref` setup, and section numbering/depth counters. |
| `preamble/commands.tex` | All custom `\newcommand`, `\renewcommand`, and `\newenvironment` definitions (colors, `lstset`, algorithm keywords, minitoc/TOC formatting). Input before `content/`. |
| `preamble/titlepage.tex` | Standalone title page layout. Kept separate so it can be redesigned without touching `main.tex`. |
| `preamble/frontmatter.tex` | Generates the table of contents, list of figures, and list of tables. Controls page numbering reset (`\pagenumbering{roman}`). |
| `preamble/bibliography.tex` | All `\addbibresource{}` calls pointing into `bibliography/`. **Input in the preamble only** (before `\begin{document}`). Contains no print commands. |
| `preamble/backmatter.tex` | `\printbibliography` calls (Bibliography + Webography), appendix declaration, and any end-of-document material. **Input inside `\begin{document}`**. |
| `content/` | All writing lives here. Each chapter is self-contained in its own subdirectory. |
| `content/chapterN/chapterN.tex` | Chapter root file. Declares the chapter heading and `\input{}`s its own `introduction.tex`, `section*.tex`, and `conclusion.tex`. |
| `content/chapterN/figures/` | Images used **only** by that chapter. Keeps assets co-located with the content that references them. |
| `bibliography/` | All `.bib` source files, split by reference type. `style.bst` is the custom bibliography style. |
| `bibliography/academic/` | Peer-reviewed references (journals, conferences, theses). |
| `docs/snippets.tex` | Compilable LaTeX snippet gallery — renders every example from `SNIPPETS.md` with live output for visual verification. Run `xelatex docs/snippets.tex` standalone. |
| `docs/` | Internal project documentation. Not compiled into the final output. |
| `assets/images/` | Global images shared across chapters (logos, institutional headers, etc.). |
| `assets/code/` | Raw source code files (`*.java`, `*.py`, etc.) included via `\lstinputlisting{}` in listings. |

---

## Compilation Flow

The diagram below shows how XeLaTeX processes `main.tex` on a full build:

```
xelatex main.tex
│
├── \documentclass{template/report}      ← Loads report.cls + mymtcstyle.sty
│
├── \input{preamble/packages}            ← Loads all packages
├── \input{preamble/config}              ← Applies global settings
├── \input{preamble/commands}            ← Registers custom macros
├── \input{preamble/bibliography}        ← \addbibresource (PREAMBLE — before \begin{document})
│
├── \begin{document}
│   ├── \dominitoc{}                     ← Activates per-chapter mini TOCs
│   ├── \input{preamble/titlepage}       ← Renders title page
│   ├── \input{preamble/frontmatter}     ← TOC, LoF, LoT (Roman page numbers)
│   │
│   ├── \pagenumbering{arabic}
│   │
│   ├── \include{content/general_introduction}
│   │
│   ├── \include{content/chapter1/chapter1}
│   │   ├── \input{.../introduction}
│   │   ├── \input{.../section1}
│   │   ├── \input{.../section2}
│   │   └── \input{.../conclusion}
│   │
│   ├── \include{content/chapter2/chapter2}
│   │   └── ...
│   │
│   ├── \include{content/general_conclusion}
│   │
│   └── \input{preamble/backmatter}
│       ├── \nocite{*}
│       ├── \printbibliography           ← Bibliography (non-web sources)
│       ├── \printbibliography           ← Webography (online sources)
│       └── \input{content/annexes/annexA}
└── \end{document}

biber main    ← Reads main.bcf, processes bibliography/**.bib, writes main.bbl
```

> **Key rule:** `main.tex` only contains `\input{}` calls and structural commands. All content, packages, and configuration live in their respective subdirectories.

---

## File Relations

### How `main.tex` Orchestrates Everything

`main.tex` acts as a pure **orchestrator** — it contains no body text or package declarations of its own. Its only responsibilities are:

1. Declaring the document class (`\documentclass{template/report}`)
2. Inputting the entire `preamble/` in dependency order (packages → config → commands → bibliography)
3. Opening `\begin{document}` and including the `content/` files in reading order
4. Delegating all back-matter output (bibliography, webography, appendices) to `\input{preamble/backmatter}`
5. Closing `\end{document}`

### How Custom Commands Flow

Commands defined in `preamble/commands.tex` are available in every content file because `commands.tex` is input before any `\begin{document}`. To add a new macro:

1. Define it in `preamble/commands.tex`
2. Use it in any `content/**/*.tex` file — no additional imports needed

### How Chapters Are Included

Each chapter follows this two-level inclusion pattern:

```
main.tex
  └─ \input{content/chapter1/chapter1.tex}
         └─ \chapter{...}
            \input{content/chapter1/introduction.tex}
            \input{content/chapter1/section1.tex}
            \input{content/chapter1/section2.tex}
            \input{content/chapter1/conclusion.tex}
```

This means you can **draft or exclude an entire chapter** by commenting out a single `\input{}` line in `main.tex`, with zero impact on other chapters.

---

## Multilingual Support

This project is configured for **French (primary), Arabic, and English** using `polyglossia` and `fontspec`.

```latex
% In preamble/packages.tex
\usepackage{polyglossia}
\usepackage{fontspec}

% In preamble/config.tex
\setmainlanguage{french}
\setotherlanguage{arabic}
\newfontfamily\arabicfont[Script=Arabic]{Amiri}
```

To write Arabic text inline, use:
```latex
\textarabic{النص العربي هنا}
```

> The Amiri font must be installed at the **operating system level**. XeLaTeX locates fonts through the OS font manager, not the TeX installation.

---

## Bibliography System

Bibliography source registration and output rendering are intentionally split across two files to respect LaTeX's preamble/body constraint.

**`preamble/bibliography.tex`** (input before `\begin{document}`) registers all sources:

```latex
\addbibresource{bibliography/books.bib}
\addbibresource{bibliography/reports.bib}
\addbibresource{bibliography/academic/journals.bib}
% \addbibresource{bibliography/academic/conferences.bib}
% \addbibresource{bibliography/academic/theses.bib}
\addbibresource{bibliography/websites.bib}
```

**`preamble/backmatter.tex`** (input inside `\begin{document}`) renders two separate lists:

```latex
\nocite{*}  % Include all .bib entries, even uncited ones

\printbibliography[title={Bibliography}, heading=bibintoc,
                   notkeyword=web, nottype=online]

\printbibliography[title={Webography}, heading=bibintoc,
                   keyword=web, type=online]
```

To add a new reference, place it in the appropriate `.bib` file and tag website entries with `keywords = {web}` — no other changes needed. Cite using `\textcite{key}` (author in sentence) or `\parencite{key}` (parenthetical) per the style configured in `preamble/packages.tex`.

See `docs/citation-style-guide.tex` and `docs/bibliography-architecture.tex` for internal conventions.

---

## Customization Guide

| Goal | File to Edit |
|---|---|
| Change page margins | `preamble/config.tex` → `\geometry{...}` |
| Add a new package | `preamble/packages.tex` |
| Define a new macro | `preamble/commands.tex` |
| Change the title page | `preamble/titlepage.tex` |
| Change chapter heading style | `template/report.cls` |
| Change minitoc appearance | `template/mymtcstyle.sty` |
| Add a new chapter | Create `content/chapterN/`, add `\include{}` in `main.tex` |
| Add a new `.bib` source file | Add `\addbibresource{}` in `preamble/bibliography.tex` |
| Add a new reference entry | Add to the appropriate `bibliography/*.bib` file |
| Change bibliography print style | `preamble/backmatter.tex` → `\printbibliography[...]` options |
| Change code listing style | `preamble/commands.tex` → `\lstset{...}` |
| Change document class options | `main.tex` → `\documentclass[options]{template/report}` |
| Add a snippet to the cheat sheet | `SNIPPETS.md` (quick reference) + `docs/snippets.tex` (rendered gallery) |

---

## Resources

- [Overleaf LaTeX Documentation](https://www.overleaf.com/learn) — comprehensive LaTeX reference
- [CTAN Package Index](https://ctan.org/) — documentation for every LaTeX package
- [Biber / BibLaTeX Manual](https://ctan.org/pkg/biblatex) — bibliography system reference
- [Polyglossia Documentation](https://ctan.org/pkg/polyglossia) — multilingual setup reference
- [The Not So Short Introduction to LaTeX](https://tobi.oetiker.ch/lshort/lshort.pdf) — recommended beginner-to-intermediate guide
- [`ROADMAP.md`](./ROADMAP.md) — pending fixes and advanced learning path for this project
# `tufte-style-thesis`

`tufte-style-thesis` is a LaTeX class with a design similar to Edward Tufte's works. His designs are known for their simplicty, legibleness, extensive use of sidenotes in a wide dedicated margin and tight text and graphic integration. This class is however not a rigourous copy of E.Tufte's works, it is more of an inspiration. It also includes design features from Robert Bringhurst's *Elements of Typographic Style*.

The overall look and features of this class can be seen in `documentation.pdf`, with more in-depth explanation. This is meant to typeset long documents like theses and books ; so the template is quite heavy.

## Latest changes

- **[18/02/2022] listings**: rejected `minted`, embraced `listings`. This means no more `--shell-escape` and way shorter compilation times! -syntax coloring is a little bit less expressive though.
- **[19/02/2022] global**: i think it works now properly for the first time.

## Installation

This class' source file is `tufte-style-thesis.cls`, avaliable here:

[www.github.com/sylvain-kern/tufte-style-thesis](www.github.com/sylvain-kern/tufte-style-thesis)

The file can just be put in the same folder as your main `.tex` file.
Overleaf users will have to do this, since it does not support custom
class installation. For Windows or Linux users with an installed LaTeX
distribution, please see respectively the two following sections, on how
to install `tufte-style-thesis` on your system.


###  MikTeX users on Windows

1.  Create a `localtexmf` directory if you do not already have one,
    for instance
    ```
    C:\Users\<you>\localtexmf
    ```

2.  Create a `tex\latex\` directory in the
    `localtexmf` one, and inside it, create a folder named `tufte-style-thesis`.

3.  Paste the `tufte-style-thesis.cls` file in that `tufte-style-thesis`
    folder and you should be good. Eventually, the class file is located at
    ```
    C:\Users\<you>\localtexmf\tex\latex\tufte-style-thesis\tufte-style-thesis.cls
    ```

4.  Open MikTeX console, go to `Settings`,
    `Directories` tab. Click on `add`, and enter your `texmf` path.
    ```
    C:\Users\<you>\localtexmf
    ```

5.  Finally, go to the `tasks` tab, and hit
    `Refresh file name database`.

`tufte-style-thesis` is now installed on your system ! MikTeX will recognize
and find the class file without it having to be in your project folder.

### TeX Live users on Linux

1.  Create a `localtexmf` directory if you do not already
    have one, for instance

    ```
    $HOME/.texmf
    ```

2.   Create a `tex/latex/` directory in the `.texmf` one,
    and inside it, create a folder named `tufte-style-thesis`.


3. Paste the `tufte-style-thesis.cls` file in that
    `tufte-style-thesis` folder and you should be good.
    Eventually, the class file is located at:

    ```
    HOME/.texmf/tex/latex/tufte-style-thesis tufte-style-thesis.cls
    ```

4.  Update the `texmf` with
    ```
    mktexlsr $HOME/.texmf
    ```

5.  Check if it worked with

    ```
    kpsewhich tufte-style-thesis.cls
    ```

`tufte-style-thesis` is now installed on your system ! TeX Live will
recognize and find the class file without it having to be in your
project folder.

## Usage

Please see the documentation for more in-depth explanations and examples. This section gives a quick overview on how to produce a simple document.

### Packages loaded

This class is already packed with packages, so check this before adding any package that may be already included.

`geometry` `emptypage` `fullwidth` `sidenotes` `caption` `fontenc` `libertinus` `libertinust1math` `gillius` `droidsansmono` `ragged2e` `titlesec` `titletoc` `tocloft` `fancyhdr` `graphicx` `microtype` `amsfonts` `amsmath` `mathtools` `physics` `xcolor` `mdframed` `tabularx` `booktabs` `enumitem` `hyperref` `etoolbox` `changepage` `placeins` `xparse` `xpatch` `biblatex` `listings`

### Preamble

Call the class with the following:
```
\documentclass[options]{tufte-style-thesis}
```

The options are listed and explained below:

| Option                | What it does      |
|---                    |---                |
| stuff is coming soon  |--                 |


#### Macros for titlepage

`\maketitle` has been customized and now displays with style:
-   the university,
-   the lab,
-   your name,
-   the title,
-   an optional subtitle,
-   the mention "Doctoral thesis" (can be changed with `\type{}`),
-   the date,
-   the supervisors and jury members (and any person you want to see appear here),
-   logos (as many as you like).


### Main document

All native LaTeX commands work with this class. However, some new macros are added to spice up the document.

#### Margin notes

`\sidenote{<your note>}` displays a numbered note in the margin.

`\sidetext{<your note>}` displays unnumbered text in the margin.

#### Figure shortcuts

- `\textfig[<optional with>]{<image path>}{<caption>}{<label>}` creates a figure with the caption in the margin. Optional width is relative to `\textwidth`: 1 will make the figure as wide as the text.

- `\marginfig{<image path>}{<caption>}{<label>}` creates a figure completely in the margin.

- `\widefig[<optional with>]{<image path>}{<caption>}{<label>}` creates a figure that completely spreads in the margin.


### Todo list

This has a todo list system. It helped me getting through the development of this class and I kept it as it seems as an useful tool to draft things on the same document.

How to use it :

-   `\todo{<what you have to do>}` to add a numbered todo note, which appears in red ;
-   `\todolist` to place a list (like list of figures) of all todos.

A time will come when you can render a version ignoring all todo-related stuf with one option in the class declaration.

## Compilation

This class compiles with `pdflatex`. Just use:

```
pdflatex document.tex
```
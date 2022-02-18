# `tufte-style-thesis`

`tufte-style-thesis` is a LaTeX class with a design similar to Edward Tufte's works. His designs are known for their simplicty, legibleness, extensive use of sidenotes in a wide dedicated margin and tight text and graphic integration. This class is however not a rigourous copy of E.Tufte's works, it is more of an inspiration. It also includes design features from Robert Bringhurst's *Elements of Typographic Style*.

The overall look and features of this class can be seen in `documentation.pdf`, with more in-depth explanation. This is meant to typeset long documents like theses and books ; so the template is quite heavy.

## Installation

This class' source file is `tufte-style-thesis.cls`, avaliable on the
following repository:

[www.github.com/sylvain-kern/tufte-style-thesis](www.github.com/sylvain-kern/tufte-style-thesis)

The file can just be put in the same folder as your main `.tex` file.
Overleaf users will have to do this, since it does not support custom
class installation. For Windows or Linux users with an installed LaTeX
distribution, please see respectively the two following sections, on how
to install `tufte-style-thesis` on your system.

In order to make the code environments and syntax highlighting work, it
is needed to have Python installed on your system, along with the
`pygments` package. With `pip` simply execute

```
pip install pygments
```

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
    `Directories` tab. Click on `add`, and enter yout `texmf` path.
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
-   the mention "Doctoral thesis"
-   the date,
-   the supervisors and jury members (and any person you want to see appear here),
-   logos (as many as you like).


### Main document

All native LaTeX commands work with this class. However, some new macros are added to spice up the document.

#### Margin notes

`\side{<your note>}` displays a numbered note in the margin.

`\sidetext{<your note>}` displays unnumbered text in the margin.

#### Figure shortcuts

`\textfig[<optional with>]{<image path>}{<caption>}{<label>}` creates a figure with the caption in the margin. Optional width is relative to `\textwidth`: 1 will make the figure as wide as the text.

`\marginfig{<image path>}{<caption>}{<label>}` creates a figure completely in the margin.

`\widefig[<optional with>]{<image path>}{<caption>}{<label>}` creates a figure that completely spreads in the margin.



## Compilation

This class compiles with `pdflatex`. It needs to be called with the `--shell-escape` flag, as shown below:

```
pdflatex --shell-escape document.tex
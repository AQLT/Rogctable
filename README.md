
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Rogctable

Uses packages `ocg-p`, `datatool`, `tikz` and `booktabs` to create
sortable table with LaTeX output. Only works with Adobe Acrobat Reader.

## Usage

You must import the package `ocg-p`, `datatool`, `tikz`, `booktabs` and
`colortbl`, for example using:

``` r
header-includes:
   - \usepackage{ocg-p,datatool,tikz,booktabs,colortbl}
```

The `results='asis'` must be used in the chunks. Then you just need to
use the function `ogc_table` with `cat`:

``` r
library(Rogctable)
d1 = head(iris)
cat(ogc_table(d1))
```

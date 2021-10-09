
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Rogctable

Uses packages `ocg-p`, `datatool`, `tikz` and `booktabs` to create
sortable table with LaTeX output. Build on PDF Layers (Optional Content
Groups (OCG)): only works with Acrobat Reader, Foxit Reader,
PDF-XChange-Viewer or Evince.

## Usage

You must import the package `ocg-p`, `datatool`, `tikz`, `booktabs` and
`colortbl`, for example using:

``` r
header-includes:
   - \usepackage{ocg-p,datatool,tikz,booktabs,colortbl}
```

The `results='asis'` must be used in the chunks. Then you just need to
use the function `ogc_table` with `cat`:

```` md
```{r data, result = 'asis'}
library(Rogctable)
x = data.frame(`First name` = c("Paul","John","Ever","Werner","Peggy"),
               `Last name` = c("Bauer", "Doe", "Last", "Moshammer", "Sue"),
               `Grade` = c(1,5,4,1,3),
               check.names = FALSE)
cat(ogc_table(x),
    sep = "\n")
```
````

Download the
[PDF](https://github.com/AQLT/Rogctable/blob/master/vignettes/Rogctable.pdf),
open it and click on the columns!

<img src="https://user-images.githubusercontent.com/24825189/136651382-212ea2d6-83d0-4b89-98ef-cbcc2cd65b45.gif" style="width:70.0%" />

In the current version of `Rogctable`, only ascending sort is available
and in the first layer (the one visible if you use a software
non-compatible with OCG-layer) the data is sort by the first column.

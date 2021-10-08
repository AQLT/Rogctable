#' Create OGC table with `Tiks`
#' @param x a \code{data.frame}.
#' @param align,label,vline see knitr::kable.
#' @param striped boolean
#' @export
ogc_table <- function(x, align, label = NULL, vline = "", striped = FALSE){
  if(missing(align)){
    isn = rep(is.numeric(x), ncol(x))
    align = ifelse(isn, "r", "l")
  }
  align = paste(align, collapse = vline)

  if(is.null(label))
    label <- knitr::opts_current$get("label")
  if(is.null(label))
    label <- "sdata"
  data_table = sprintf("\\DTLnewdb{%s}", label)
  id_col <- letters[seq_len(ncol(x))]
  nom_col <- colnames(x)
  oc_id_col <- sprintf("oc%s%sid", label , id_col)

  rows = apply(x,1, function(t){
    c(sprintf("\\DTLnewrow{%s}", label),
      sprintf("\\DTLnewdbentry{%s}{col%s}{%s}",label,
              id_col,
              t)
    )
  }, simplify = FALSE)
  data_table = c(data_table,
                 unlist(rows))
  nom_col_ocgs <- sapply(seq_along(nom_col), format_ocg_title,
                         nom_col = nom_col,
                         oc_id_col = oc_id_col)

  ocg_tikz <- sapply(seq_along(nom_col), format_ocg_tikz,
                     nom_col = nom_col,
                     id_col = id_col,
                     align = align,
                     nom_col_ocgs = nom_col_ocgs,
                     label = label,
                     striped = striped)
  c(data_table,
    "",
    "\\begin{tikzpicture}",
    ocg_tikz,
    "\\end{tikzpicture}"
  )
}


format_ocg_title <- function(i, nom_col, oc_id_col){
  sprintf("\\bfseries \\setocgs{}{%s}{%s}{%s}",
          oc_id_col[i],
          paste(oc_id_col[-i], collapse = " "),
          nom_col[i])
}
format_ocg_tikz <- function(i, nom_col, id_col, align, nom_col_ocgs, label, striped = FALSE){
  if(striped){
    row_data <- sprintf("\\DTLifoddrow{\\cellcolor{gray!6}{\\cmd%s}}{\\cmd%s}", id_col, id_col)
  }else{
    row_data <- sprintf("\\cmd%s", id_col)
  }

  c(sprintf("\\begin{ocg}[exportocg=%s]{%s}{oc%s%sid}{%i}",
            ifelse(i==1, "always", "never"),
            nom_col[i],
            label,
            id_col[i],
            ifelse(i==1, 1,0)),#0 for invisible, 1 for visible
    sprintf("\\node[%s] (p%i) {", ifelse(i==1,"", "overlay"), i),
    paste0("  ",c(
      sprintf("\\begin{tabular}{%s}", align),
      "\\toprule",
      paste(nom_col_ocgs, collapse = " & "),
      sprintf("\\DTLsort*{col%s}{%s}", id_col[i], label),
      sprintf("\\DTLforeach{%s}{%s}{",
              label,
              paste(sprintf("\\cmd%s =col%s",id_col, id_col),
                    collapse = ", ")),
      "\\DTLiffirstrow{\\\\ \\midrule}{\\\\}",
      paste(row_data,
            collapse = " & "),
      "}",
      "\\\\ \\bottomrule",
      "\\end{tabular}"
    )),
    "};",
    "\\end{ocg}"
  )
}

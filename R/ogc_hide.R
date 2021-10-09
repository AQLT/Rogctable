#' Sortable Table
#' @inheritParams ogc_sort
#' @param show the layer to show by default.
#' The first layer contains all the date, the second layer hide the second column, etc.
#' @export
ogc_hide <- function(x, align, show = 1, label = NULL, vline = "", striped = FALSE){
  if(missing(align)){
    isn = rep(is.numeric(x), ncol(x))
    align = ifelse(isn, "r", "l")
  }
  align = paste(align, collapse = vline)

  visibility <- rep(0, ncol(x))
  visibility[show] <- 1

  if(is.null(label))
    label <- knitr::opts_current$get("label")
  if(is.null(label))
    label <- "sdata"
  data_table = sprintf("\\DTLnewdb{%s}", label)
  if(ncol(x)>25)
    stop("The data must have at most 25 columns")
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
                     visibility = visibility,
                     nom_col_ocgs = nom_col_ocgs,
                     label = label,
                     striped = striped, hide = TRUE,
                     sort = FALSE)
  c(data_table,
    "",
    "\\begin{tikzpicture}",
    ocg_tikz,
    "\\end{tikzpicture}"
  )
}



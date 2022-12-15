#' The `{{{sessname}}}_plotting.R` file is part of the set of R files templated in for each
#' session. Recall: at the prompt, `{{{pkgname}}}::{{{sessname}}}_`+tab will
#' suggest all the functions in this package associated with `{{{sessname}}}`.
#'
#' This can be useful for learners trying to find the relevant code for an
#' exercise or to inspect out of curiosity. Therefore in each topic, we
#' *strongly recommend* that you write functions in the `TOPIC_...` style.
#'
#' @seealso `vignette("useclinic-naming")`
#'
#' The `{{{sessname}}}_plotting.R` script should house those functions you pre-
#' write to support visualization as part of your learning activites, specific
#' to the particular topic. These won't necessarily be exclusive functions that
#' generate plots - they could be data preparate steps, feature extraction,
#' formatting, etc.

#' @title An Example Plot
#'
#' @param df a data.frame, of the flavor in the default topic script
#'
#' @param cols a vector of color codes
#'
#' @export
#' @examples
#' df1 <- {{{sessname}}}_dataframer(seed = 8675309)
#' {{{sessname}}}_egplotter(df1, c("firebrick", "dodgerblue"))
{{{sessname}}}_egplotter <- function(df, cols) {
  plot(df$xs, df$ys, col = cols[df$ci])
}

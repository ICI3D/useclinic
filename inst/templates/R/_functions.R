#' The `{{{topic}}}_functions.R` file is part of the set of R files templated
#' in for each topic. Recall: at the prompt, `{{{pkgname}}}::{{{topic}}}_`+tab
#' will suggest all the functions in this package associated with `{{{topic}}}`.
#'
#' This can be useful for learners trying to find the relevant code for an
#' exercise or to inspect out of curiosity. Therefore in each topic, we
#' *strongly recommend* that you write functions in the `TOPIC_...` style.
#'
#' @seealso `vignette("useclinic-naming")`
#'
#' The `{{{topic}}}_functions.R` script should house those functions you pre-
#' write to for analytical or simulation or munging tasks the learners don't
#' benefit from writing or having to wade through.

#' @title The `{{{topic}}}` Topic
#'
#' @description An outline of the point of this topic.
#'
#' @details Includes functions
#'  - [{{{topic}}}_dataframer()], brief description
#'  - ... other functions
#'
#' Also has data:
#'  - [{{{topic}}}_EXAMPLE_A], brief description
#'  - [{{{topic}}}_EXAMPLE_A], brief description
#'
#' @rdname {{{topic}}}

#' @title An Example Function
#'
#' @param seed a random seed
#'
#' @return a `data.frame`, with columns `xs`, `ys`, and `ci`
#'
#' @examples
#' df1 <- {{{topic}}}_dataframer(seed = 8675309)
#' {{{topic}}}_egplotter(df1, c("firebrick", "dodgerblue"))
#'
#' @family {{{topic}}}
#'
#' @export
{{{topic}}}_dataframer <- function(seed = 0) {
  set.seed(seed)
  return(within(data.frame(
    xs = runif(100, 0, 100),
    ys = runif(100, 0, 100)),
    ci <- (ys > xs)+1
  ))
}


#' @title Create a New Clinic Package
#'
#' @description Creates a new ICI3D style clinic package
#'
#' @inheritParams usethis::create_package
#'
#' @param sessions named list-of-lists; each entry name corresponds to a session
#' shorthand title, with the entry list corresponding to the arguments to
#' [create_session()].
#'
#' @details This function extends [usethis::create_package()] to reflect the
#' ICI3D-style clinic package approach to learning materials:
#'
#'  - Clinic packages typically include some traditional R code for export, i.e.
#'  the package is used a bit like a conventional package.
#'  - The packages also include scripts and/or tutorials, which clinic
#'  participants use during practical exercises, homework, etc.
#'
#' The organizing structure is the list of "sessions" - the shorthand titles
#' for the scripts and/or tutorials. This package builds directory and files
#' consistent with this structure, as well as R code. Imagine your clinic has
#' two sessions, "intro" and "advanced", and you use this function to create
#' a new clinic package. You should then find yourself with the following in
#' the package directory:
#'
#' ```
#' DESCRIPTION
#' NAMESPACE
#' data/
#' data-raw/
#' man/
#' R/
#'   aaa_internal.R
#'   advanced_data.R
#'   advanced_functions.R
#'   advanced_plotting.R
#'   checks.R
#'   intro_data.R
#'   intro_functions.R
#'   intro_plotting.R
#'   plotting.R
#'   utilities.R
#' inst/
#'   scripts/                   # ... if the sessions have practicals
#'     advanced/Step_00.R
#'     intro/Step_00.R
#'     solutions/
#'       advanced/Step_00.R
#'       intro/Step_00.R
#'   tutorials/                 # ... if the sessions have tutorials
#'     advanced/advanced.Rmd
#'     intro/intro.Rmd
#' ```
#'
#' At the top level, there are the typical elements ()
#'
#' A clinic package's R code is intended for use with the scripts and/or
#' tutorials: it eliminates coding that isn't pertinent to the learning (e.g.
#' munging data, complicated plots, sophisticated analytical steps that
#' represent assumed prior learnings).
#'
#' @export
create_clinic <- function (
  path, fields = list(), rstudio = rstudioapi::isAvailable(),
  roxygen = TRUE, check_name = TRUE, open = rlang::is_interactive(),
  sessions = list()
) {

  # TODO check session structure
  # should be list(sessionname=list(...sessionneeds...))

  # do all the usethis::create_package() work
  usethis::create_package(
    path = path, fields = fields, rstudio = rstudio,
    roxygen = roxygen, check_name = check_name, open = FALSE
  )

  anytutorials <- FALSE
  for (sess in names(sessions)) {
    sopts <- session_opt(sessions[[sess]])
    create_session(
      sopts,
      package = path
    )
    anytutorials <- anytutorials || (length(sopts$tutorial) > 0)
  }

  if (anytutorials) use_package("learnr")

  if (open) {
    if (proj_activate(proj_get())) {
      withr::deferred_clear()
    }
  }

  invisible(proj_get())
}

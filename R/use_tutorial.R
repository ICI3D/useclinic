
#' @title Create a Session Tutorial
#'
#' @description Creates a `learnr` tutorial skeleton, associated with a
#' particular package topic, in the current package.
#'
#' @param name a string: the title of the tutorial; after sanitization, will
#' also be the initial filename for the tutorial.
#'
#' @param sessionname a string: the shorthand session title
#'
#' @TODO accept multiple tutorial names at once? attempt to import existing
#' files?
#'
#' @export
use_tutorial <- function(
  name, sessionname
) {

  stopifnot(
    "'name' must be a string" = rlang::is_string(name),
    "'sessionname' must be a string" = rlang::is_string(sessionname)
  )

  fname <- name |> fs::path_sanitize() |> gsub("[[:space:]]+", "_", x = _)

  # TODO warn if session doesn't yet exist

  pkgname <- usethis::proj_path() |> basename()
  use_directory("inst", "tutorial", sessionname)
  tpath <- fs::path("inst", "tutorial", sessionname, fname, ext = "Rmd")

  usethis::use_template(
    "tutorial/session_tutorial.Rmd", save_as = tpath,
    data = list(pkgname = pkgname, name = name, sessname = sessionname),
    ignore = FALSE, open = open,
    package = "useclinic"
  )

  usethis::ui_todo("Finish the tutorial Rmarkdown in {ui_value(tpath)}")

}

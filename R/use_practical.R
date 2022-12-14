
#' @title Create a Session Practical
#'
#' @description Creates a practical script skeleton, associated with a
#' particular package topic, in the current package.
#'
#' @param name a string: the title of the tutorial; after sanitization, it will
#' be the initial filename for the tutorial.
#'
#' @param sessionname a string: the shorthand session title
#'
#' @TODO accept multiple names at once? attempt to import existing
#' files?
#'
#' @export
use_practical <- function(
    name, sessionname
) {

  stopifnot(
    "'name' must be a string" = rlang::is_string(name),
    "'sessionname' must be a string" = rlang::is_string(sessionname)
  )

  fname <- name |> fs::path_sanitize() |> gsub("[[:space:]]+", "_", x = _)

  # TODO warn if session doesn't yet exist

  pkgname <- usethis::proj_path() |> basename()
  use_directory("inst", "practical", sessionname)
  tpath <- fs::path("inst", "practical", sessionname, fname, ext = "R")

  usethis::use_template(
    "R/session_practical.R", save_as = tpath,
    data = list(pkgname = pkgname, name = name, sessname = sessionname),
    ignore = FALSE, open = open,
    package = "useclinic"
  )

  usethis::ui_todo("Finish the practical R code in {ui_value(tpath)}")

}


#' Create Clinic Session Data
#'
#' `use_data()` and `use_data_raw()` wrap the respective [usethis::use_data()]
#' and [usethis::use_data_raw()] methods
#'
#' @inheritParams usethis::use_data
#'
#' @param sessionname the session label this data is associated with.
#'
#' @import usethis
#' @export
use_data <- function(
  ...,
  internal = FALSE, overwrite = FALSE, compress = "bzip2",
  version = 2, ascii = FALSE, sessionname = NULL
) {

  if (!is.null(session)) {
    # TODO check `sessionname` is a string => stopifnot
    # TODO check `sessionname` exists; if not, alert that `R/SESSION_data.R`
    # will be created
    objs <- usethis:::get_objs_from_dots(usethis:::dots(...))
    badobjs <- !grepl(paste0("^", sessionname), objs)
    if (any(badobjs)) {
      usethis::ui_warn(c("Some object names do not start with {sessionname}:", objs[badobjs]))
    }
  }

  usethis::use_data(
    ...,
    internal = internal, overwrite = overwrite,
    compress = compress, version = version, ascii = ascii
  )

  if (!is.null(sessionname)) {
    # TODO update the R/SESSION_data.R documentation file
  }
}

#' @rdname use_data
#' @import usethis rlang fs
#' @export
use_data_raw <- function(
  name = "DATASET",
  open = rlang::is_interactive(),
  sessionname = NULL
) {
  # n.b.: this is rework of usethis::use_data_raw, since the internals
  # of that aren't exposed
  stopifnot(rlang::is_string(name))
  if (!is.null(sessionname)) {
    # TODO check `sessionname` is a string => stopifnot
    # TODO check for existence of sessionname among repo sessions,
    # warn if not
    name <- paste0(sessionname, "_", name)
  }
  r_path <- fs::path("data-raw", usethis:::asciify(name), ext = "R")
  usethis::use_directory("data-raw", ignore = TRUE)
  usethis::use_template(
    "R/data-raw.R", save_as = r_path,
    data = list(name = name, sessname = sessionname),
    ignore = FALSE, open = open,
    package = "useclinic"
  )
  ui_todo("Finish the data preparation script in {ui_value(r_path)}")
  ui_todo("Use {ui_code('useclinic::use_data()')} to add prepared data to package")
}

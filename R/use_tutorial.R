
#' @title Add Learning Activites
#'
#' @description Creates `learnr` tutorials or R script skeletons,
#' associated with a particular topic.
#'
#' @param name a string: the title of the activity; after sanitization, will
#' also be the initial file name.
#'
#' @param topic a string: the shorthand topic title
#'
#' @param overwrite logical: overwrite existing materials?
#'
#' @param open logical: open the resulting file?
#'
#' @name use_activity
#' @export
use_tutorial <- function(
  name, topic, overwrite = FALSE, open = rlang::is_interactive()
) {
  # TODO warn if topic doesn't yet exist
  stopifnot(
    "'name' must be a string" = rlang::is_string(name),
    "'topic' must be a string" = rlang::is_string(topic)
  )

  fname <- name |> fs::path_sanitize() |> gsub("[[:space:]]+", "_", x = _)

  use_tutorial_directory(topic)

  tpath <- use_clinic_template("tutorials", fname, topic, name, overwrite = overwrite, open = open)

  usethis::ui_todo("Finish the tutorial Rmarkdown in {ui_value(tpath)}")

}

use_tutorial_directory <- function(topic) {
  usethis::use_directory(file.path("inst", "tutorials", topic))
}

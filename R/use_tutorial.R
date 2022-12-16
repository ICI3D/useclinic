
#' @title Add a Tutorial
#'
#' @description Creates a `learnr` tutorial skeleton in the current package,
#' associated with a particular topic.
#'
#' @param name a string: the title of the tutorial; after sanitization, will
#' also be the initial filename for the tutorial.
#'
#' @param topic a string: the shorthand topic title
#'
#' @export
use_tutorial <- function(
  name, topic
) {
  # TODO warn if topic doesn't yet exist
  stopifnot(
    "'name' must be a string" = rlang::is_string(name),
    "'topic' must be a string" = rlang::is_string(topic)
  )

  fname <- name |> fs::path_sanitize() |> gsub("[[:space:]]+", "_", x = _)

  use_directory("inst", "tutorial", topic)

  tpath <- use_clinic_template("tutorial", fname, pkgname, topic, name)

  usethis::ui_todo("Finish the tutorial Rmarkdown in {ui_value(tpath)}")

}

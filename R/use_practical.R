
#' @title Create a Practical
#'
#' @description Creates a practical script skeleton, associated with a
#' particular package topic, in the current package.
#'
#' @param name a string: the title of the practical; after sanitization, it will
#' be the initial filename for the practical
#'
#' @param topic a string: the shorthand topic title
#'
#' @export
use_practical <- function(
  name, topic
) {
  # TODO warn if topic doesn't yet exist
  stopifnot(
    "'name' must be a string" = rlang::is_string(name),
    "'topic' must be a string" = rlang::is_string(topic)
  )

  fname <- name |> fs::path_sanitize() |> gsub("[[:space:]]+", "_", x = _)

  use_directory("inst", "practical", topic)

  tpath <- use_clinic_template("practical", fname, topic, name)

  usethis::ui_todo("Finish the practical R code in {ui_value(tpath)}")

}

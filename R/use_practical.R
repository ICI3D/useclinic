
#' @rdname use_activity
#' @export
use_practical <- function(
  name, topic, overwrite = FALSE, open = rlang::is_interactive()
) {
  # TODO warn if topic doesn't yet exist
  stopifnot(
    "'name' must be a string" = rlang::is_string(name),
    "'topic' must be a string" = rlang::is_string(topic)
  )

  fname <- name |> fs::path_sanitize() |> gsub("[[:space:]]+", "_", x = _)

  use_practical_directory(topic)

  tpath <- use_clinic_template("practicals", fname, topic, name, overwrite = overwrite, open = open)

  usethis::ui_todo("Finish the practical R code in {ui_value(tpath)}")

}

use_practical_directory <- function(topic) {
  usethis::use_directory(file.path("inst", "practicals", topic))
  usethis::use_directory(file.path("inst", "practicals", "solutions", topic))
}

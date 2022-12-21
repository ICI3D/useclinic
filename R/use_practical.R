
#' @rdname use_activity
#' @export
use_practical <- function(
  name, topic, overwrite
) {
  # TODO warn if topic doesn't yet exist
  stopifnot(
    "'name' must be a string" = rlang::is_string(name),
    "'topic' must be a string" = rlang::is_string(topic)
  )

  fname <- name |> fs::path_sanitize() |> gsub("[[:space:]]+", "_", x = _)

  usethis::use_directory(file.path("inst", "practical", topic))

  tpath <- use_clinic_template("practical", fname, topic, name, overwrite)

  usethis::ui_todo("Finish the practical R code in {ui_value(tpath)}")

}

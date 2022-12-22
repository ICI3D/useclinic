
#' Create Clinic Topic Data
#'
#' `use_data()` and `use_data_raw()` wrap the respective [usethis::use_data()]
#' and [usethis::use_data_raw()] methods
#'
#' @inheritParams usethis::use_data
#'
#' @param topicname the topic label this data is associated with.
#'
#' @import usethis
#' @export
use_data <- function(
  ...,
  internal = FALSE, overwrite = FALSE, compress = "bzip2",
  version = 2, ascii = FALSE, topicname = NULL
) {

  if (!is.null(topicname)) {
    # TODO check `topicname` is a string => stopifnot
    # TODO check `topicname` exists; if not, alert that `R/TOPIC_data.R`
    # will be created
    objs <- usethis:::get_objs_from_dots(usethis:::dots(...))
    badobjs <- !grepl(paste0("^", topicname), objs)
    if (any(badobjs)) {
      usethis::ui_warn(c("Some object names do not start with {topicname}:", objs[badobjs]))
    }
  }

  usethis::use_data(
    ...,
    internal = internal, overwrite = overwrite,
    compress = compress, version = version, ascii = ascii
  )

  if (!is.null(topicname)) {
    # TODO update the R/TOPIC_data.R documentation file
  }
}

#' @rdname use_data
#' @import usethis rlang fs
#' @export
use_data_raw <- function(
  name = "DATASET",
  open = rlang::is_interactive(),
  topic = NULL
) {
  # n.b.: this is rework of usethis::use_data_raw, since the internals
  # of that aren't exposed
  stopifnot(rlang::is_string(name))
  if (!is.null(topic)) {
    # TODO check `topic` is a string => stopifnot
    # TODO check for existence of topicname among repo topics,
    # warn if not
    name <- paste0(topic, "_", name)
    usethis::use_directory(file.path("data-raw", topic), ignore = TRUE)
  } else {
    usethis::use_directory("data-raw", ignore = TRUE)
  }

  pkgname <- desc::desc_get("Package", usethis::proj_path())

  r_path <- use_clinic_template(
    "dataraw", usethis:::asciify(name),
    topic, name, open = open
  )

  ui_todo("Finish the data preparation script in {ui_value(r_path)}")
  ui_todo("Use {ui_code('useclinic::use_data()')} to add prepared data to package")
}

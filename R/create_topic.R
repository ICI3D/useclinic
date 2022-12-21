
#' @title Create or Update Topic Skeleton
#'
#' @inheritDotParams topic_opt
#'
#' @export
create_topic <- function(
  ...
) {
  opts <- topic_opt(...)
  usethis::local_project(force = TRUE)
  topic <- opts$shorthand
  overwrite <- opts$overwrite
  if (length(opts$practicals)) {
    usethis::use_directory(file.path("inst", "practical", "solution", topic))
    for (nm in opts$practicals) use_practical(nm, topic, overwrite)
  }
  if (length(opts$tutorials)) {
    usethis::use_directory(file.path("inst", "tutorial", topic))
    for (nm in opts$tutorial) use_tutorial(nm, topic, overwrite)
  }

  use_topic_templates(opts$shorthand, data = length(opts$data) != 0)

}

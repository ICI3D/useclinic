
#' @title Create or Update Session Skeleton
#'
#' @inheritDotParams session_opt
#'
#' @param package the package directory
#'
#' @export
create_session <- function(
  ...,
  package
) {
  sessopt <- session_opt(...)
  usethis::local_project(package, force = TRUE)
  sessname <- sessopt$shorthand
  if (length(sessopt$practicals)) {
    usethis::use_directory(file.path("inst", "practical", "solution", sessname))
    for (nm in sessopt$practicals) use_practical(nm, sessname)
  }

}

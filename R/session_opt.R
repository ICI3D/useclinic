
#' @title Create Session Options
#'
#' @description Creates a standardized options object for sessions templating.
#'
#' @param opts a list: the reference options to use. Unspecified options will
#' take the default values specified for other arguments
#'
#' @param shorthand a string: the session shorthand name
#'
#' @param fullname a string: the session full name
#'
#' @param tutorials a character vector: if non-zero length, creates
#' corresponding tutorial file skeletons
#'
#' @param practicals a character vector: if non-zero length, creates
#' corresponding practical script file skeletons
#'
#' @param data a character vector: if non-zero length, creates a session data
#' file for documentation.
#'
#' @return a list, matching the argument requirements for [create_clinic()] and
#' [create_session()].
#'
#' @export
session_opt <- function(
  opts = list(),
  shorthand = "DUMMY",
  fullname = "NOT FOR DUMMIES",
  tutorials = c(),
  practicals = c(),
  data = c()
) {
  if (is.null(opts$shorthand)) {
    opts$shorthand <- shorthand
  }
  if (is.null(opts$fullname)) {
    opts$fullname <- fullname
  }
  if (is.null(opts$tutorials)) {
    opts$tutorials <- tutorials
  }
  if (is.null(opts$practicals)) {
    opts$practicals <- practicals
  }
  if (is.null(opts$data)) {
    opts$data <- data
  }
  if(!any(c(length(opts$tutorials), length(opts$practicals), length(opts$data)) != 0)) {
    warning(sprintf("No session content (i.e. tutorials, practicals, data) provided for %s.", opts$shorthand))
  }
}

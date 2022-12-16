
library({{{pkgname}}})        # for overall course functions
# any other packages you might need to support this practical

#' @title {{{name}}}
#'
#' @description Note how we use the roxygen-style comments and annotations in
#' the script - that enables syntax highlighting and using roxygen's parsing
#' functions to dissect the practical.
#'
#' @section Use at-Section to Define Sections
#'
#' Then within a section, you can intersperse code for students to run for
#' exploration

set.seed(8675309)
plot(runif(100), runif(100))

#' ... or as part of question and answer tags:
#'
#' @question Complete this `helloworld()` function such that it greets whatever
#' argument it is supplied:
helloworld <- function(...) {

}

#' @answer
helloworld <- function(...) {
  dots(...) |> lapply(\(x) sprintf("Hello, %s!", x))
}

#' In addition to the custom question and answer tags, we also use hint and aside:
#'
#' @hint You will need to extract the arguments from the `...`s.
#'
#' @aside This note may safely be ignored until a student has done the whole
#' assignment, and is revisiting materials for revision.
#'
#' @section Another Section
#'
#' This one just some notes. When writing these practical scripts, we suggest
#' that you leverage the package-ness of this distribution method. Where some
#' chunk of functionality isn't really the point of the learning activity, you
#' should implement it as `{{{pkgname}}}::{{{topic}}}_somefunction(...)`.
#'
#' Then it is there, inspectable by the students, but not distracting them with
#' code noise from the content you want them to focus upon.

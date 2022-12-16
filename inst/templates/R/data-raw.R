#'
#' This a templated outline for creating and storing data (in `data/`) for the
#' topic "{{{topic}}}".
#'
#' As supplied, this script assumes that either you only need one script, e.g.
#' because you only have one chunk of data to generate, or because all your
#' datasets are interdependent (so should be created together), etc.
#'
#' If you need to use multiple scripts to generate data for this topic, then
#' you can create another file in this directory also starting with
#' `{{{topic}}}_...`: [useclinic::use_data_raw()] is a convenient way to do that.
#' That wraps [usethis::use_data_raw()], adding a `topic` argument.
#'
#' For what to do in `data-raw/` scripts (and `data/`, packages generally, ...),
#' see the [R packages](https://r-pkgs.org/data.html#sec-data-data-raw) e-book.

# make some example data
{{{name}}} <- data.frame(
  x = 1:10, y = 10:1
)

# if you end up making multiple objects in this script, simply add them as
# additional arguments.
useclinic::use_data(
  {{{name}}},
  overwrite = TRUE,
  topic = {{{topicname}}}
)

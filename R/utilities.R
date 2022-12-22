
use_topic_templates <- function(
  topic, ignore = FALSE, data = FALSE,
  overwrite = FALSE
) {
  temps <- list(functions = "R/_functions.R", plotting = "R/_plotting.R")
  if (data) temps[["data"]] <- "R/_data.R"

  pkgname <- desc::desc_get("Package", usethis::proj_path())

  regrep <- \(template) gsub("_", paste0(topic, "_"), template)

  if ((temps |> sapply(regrep) |> sapply(fs::file_exists) |> any()) & !overwrite) {
    newtemps <- temps[-(temps |> sapply(regrep) |> sapply(fs::file_exists) |> which())]
    # TODO emit warning, fail if nothing left to do
    temps <- newtemps
  }


  temps |> lapply(\(template) usethis::use_template(
    template, save_as = template |> regrep(),
    data = list(pkgname = pkgname, topic = topic),
    ignore = ignore, open = FALSE,
    package = "useclinic"
  ))

}

use_clinic_template <- function(
  template = c(
    "tutorials", "practicals", "dataraw"
  ),
  filename, topic = "", name, ignore = FALSE, open, overwrite = FALSE
) {
  template <- match.arg(template)

  pkgname <- desc::desc_get("Package", usethis::proj_path())

  reftemp <- c(
    tutorials = "tutorial/topic_tutorial.Rmd",
    practicals = "practical/topic_practical.R",
    dataraw = "R/data-raw.R"
  )
  tpath <- switch(template,
    dataraw = fs::path("data-raw", topic, filename, ext = "R"),
    fs::path("inst", template, topic, filename, ext = "Rmd")
  )
  if (fs::file_exists(tpath) & !overwrite) stop(
    sprintf("%s already exists and overwrite = FALSE.", tpath)
  )
  usethis::use_template(
    reftemp[template], save_as = tpath,
    data = list(pkgname = pkgname, topic = topic, name = name),
    ignore = FALSE, open = open,
    package = "useclinic"
  )
  return(tpath)
}

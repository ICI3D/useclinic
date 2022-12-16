
use_clinic_template <- function(
  template = c("tutorial", "practical", "dataraw"), filename,
  topic, name, ignore = FALSE, open = open
) {
  template <- match.arg(template)
  pkgname <- usethis::proj_path() |> basename()
  reftemp <- c(
    tutorial = "tutorial/topic_tutorial.Rmd",
    practical = "practical/topic_practical.R",
    dataraw = "R/data-raw.R"
  )
  tpath <- switch(template,
    dataraw = fs::path("data-raw", topic, filename, ext = "R"),
    fs::path("inst", template, topic, filename, ext = "Rmd")
  )
  usethis::use_template(
    reftemp[template], save_as = tpath,
    data = list(pkgname = pkgname, topic = topic, name = name),
    ignore = FALSE, open = open,
    package = "useclinic"
  )
  return(tpath)
}

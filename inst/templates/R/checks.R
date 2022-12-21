#' internalization of approach (C) Carl A. B. Pearson from
#' [cabputils](https://github.com/pearsonca/cabputils)

#' This script provides a light-weight approach to checking function arguments.
#'
#' *Argument checking in code used for learning IS ABSOLUTELY ESSENTIAL*.
#'
#' The pedagogical context means working with novices (even if not _coding_
#' novices): helpful misuse checking / error messages is a *MUST-have*.
#'
#' Your particular course might need more sophisticated error checking.
#' If you think that's true (minding need to balance also not requiring novices
#' to install a bunch of other packages), look into e.g.
#' [this write up](https://blog.r-hub.io/2022/03/10/input-checking/) for
#' alternative options. If using one of those options, this script can be
#' removed.
#'
#' Now, on to this approach:
#'
#' The `checks.R` script is intended to include `check_...` validators that are
#' used within various topic functions. These functions are not intended to be
#' exported (though can be viewed with `{{{pkgname}}}:::check_...`). They are meant
#' to seen by students if they inspect exported functions (i.e. they should be
#' named informatively to indicate what arguments are being checked how), but
#' their guts ignored. More importantly, they should provide informative errors
#' when the functions that *are* exported are misapplied.
#'
#' In general, `check_...`s are intended to:
#'  - concern one feature (therefore, one logical test) at a time
#'  - have a succinct, discernible response when that test is violated
#'  - be applied via pipe in exported functions
#'
#' Note the [get_piped_call_var()] and [checker()] functions are not exported;
#' as a user of this template, you shouldn't (1) touch them or (2) have to
#' understand their internals. All you should need to do is define new checkers
#' like `check_something <- checker(SOMELOGIC, "Some message about %s")`.
#'
#' Lastly: while [checker()] below provides a convenient way to check single
#' arguments, your argument validations may need to pass more than one argument
#' at a time. Several approaches are plausible: you could defined
#' `check_something(x, y)` by hand, you could pass a list combining multiple
#' values, etc: [checker()] is simply a convenience, not a requirement.
#'
#' Using the example `check_...`s at the bottom of this script, a
#' `helloworld(...)` function might look like:
#'
#' @examples
#' helloworld <- function(name) {
#'   name |> check_character() |> check_scalar() |> check_nonemptychar()
#'   sprintf("Hello, %s!", name)
#' }
#'
#' helloworld
#' helloworld("Carl") # works
#' try(helloworld(1)) # nope
#' a <- 1
#' try(helloworld(a)) # nope
#' a <- "Carl"
#' helloworld(a) # works
#' try(helloworld(c("Alice", "Bob"))) # nope
#' try(helloworld("")) # nope

#' Get Initial Variable |>'d into Call Chain
#'
#' Defined primarily to denoise [checker()] result.
#'
#' @param sc the result of [sys.call()]
#'
#' @details This converts a [sys.call()] to its character representation
#' ([as.character()]), then takes the last bit of it ([tail()]), then extracts
#' the innermost parenthetical expression ([gsub()])
#'
#' @nodelete
get_piped_call_var <- function(sc) {
  return(
    sc |> as.character() |> tail(1) |>
    gsub(".*\\(([^\\(\\)]+)\\).*", "\\1", x = _)
  )
}

#' `check_` Generator
#'
#' Conveniently defines `check_...` functions
#'
#' @param reqexpr a logical expression to check e.g. `is.integer(x)`; must
#' *only* be written in terms of a single variable `x`
#'
#' @param msg a [sprintf()] `fmt` argument, with a single `%s`, which will be
#' filled by the variable name from [get_piped_call_var()]
#'
#' @details This somewhat gnarly bit of code satisfies several demands:
#'  - it needs only bits a developer needs to specify (the variable test &
#'  the error message)
#'  - it creates a function that works
#'  - that function is human-readable when inspected
#'
#' [alist()] creates the (single) argument list
#'
#' @nodelete
checker <- function(reqexpr, msg) {
  c(alist(x=), substitute(
    if (!(reqexpr)) {
      sys.call() |> get_piped_call_var() |> sprintf(fmt = msg) |>
        stop(call. = FALSE)
    } else invisible(x)
  )) |> as.function()
}

#' These are the definitions that you would replace for your specific course.
#' For the messages, you can write anything you like, but must include one
#' (and only one) %s, which is where the variable name will appear in error
#' messages.
#'
#' In general, you should try to write these messages in a consistent voice. For
#' example, below the messages are all framed as "...must be a..."; alternatively,
#' they could all be "...is not a...".

check_character <- checker(is.character(x), "`%s` must be a 'character'.")

check_scalar <- checker(length(x) == 1, "`%s` must be a scalar (length == 1).")

check_nonemptychar <- checker(all(nchar(x) > 0), "`%s` must be non-empty.")

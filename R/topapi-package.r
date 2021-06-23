#' topapi: Tools for handling the TOP dataset
#'
#' @details
#'
#' The __topapi__ package implements helper functions for
#' smooth querying of the TOP factor dataset.
#'
#' Rather than manually downloading the dataset,
#' the __topapi__ package keeps the dataset in memory,
#' meaning the data is both easily accessible and
#' always up to date.
#'
#' Main exported methods are:
#'    * Data retrieval: [journal_name()], [journal_issn()], [publisher_name()]
#'    * Fuzzy matching: [find_journal()]
#'
#' @docType package
#' @name topapi
#' @aliases NULL topapi-package
"_PACKAGE"
#' Find journals through fuzzy matching
#'
#' @description
#' Search the TOP dataset for journals that are within a certain
#' string distance of the input string.
#'
#' Generally useful for finding journals that may have typos or
#' regional differences in naming.
#'
#' @param input the string to check
#' @param method
#' the method for measuring string distance, see
#' ?stringdist::stringdist-metrics for more information
#' @param max_distance
#' the maximum valid string distance the returned input can be
#' @export
find_journal <- function(input, method = "osa", max_distance = 3) {
    retrieve_data()

    comparison <- data.frame(
        journal_names = top_env$data$Journal
    )

    # is x scalar?
    if (length(input) == 1) {
        find_helper(input, comparison, max_distance, method)
    } else {
        return(
            purrr::map_dfr(
                .x = input,
                .f = find_helper,
                comparison,
                max_distance,
                method
            )
        )
    }
}

find_helper <- function(input, comparison, max_distance, method) {
    comparison$distance <- stringdist::stringdist(
        a = comparison$journal_names,
        b = input,
        method = method
    )

    fuzzy_name <- comparison[which.min(comparison$distance), ]

    tryCatch(
        expr = {
            # code
            if (fuzzy_name$distance > max_distance) {
                return(NULL)
            }

            possible_journal <- top_env$data[
                top_env$data$Journal == fuzzy_name$journal_names,
            ]
            message(
                sprintf(
                    "Input was: %s,\nMatch was: %s,\nString distance of: %s",
                    input,
                    possible_journal$Journal,
                    fuzzy_name$distance
                )
            )
            return(possible_journal)
        }, warning = function(w) {
            message(
                sprintf("Warning in %s: %s", deparse(w[["call"]]), w[["message"]])
            )
        }, error = function(e) {
            message(
                sprintf("Error in %s: %s", deparse(e[["call"]]), e[["message"]])
            )
        }
    )
}
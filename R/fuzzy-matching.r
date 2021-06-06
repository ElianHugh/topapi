#' Find journals through fuzzy matching
#'
#' @description
#'
#' @export
find_journal <- function(input, method = "osa", max_distance = 3) {
    comparison <- data.frame(
        journal_names = top_env$data$Journal
    )
    comparison$distance <- stringdist::stringdist(
        a = comparison$journal_names,
        b = input,
        method = method
    )

    fuzzy_name <- comparison[which.min(comparison$distance), ]

    tryCatch(
        {
            # code
            if (fuzzy_name$distance > max_distance) return(NA)

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

#' Find journal policy scores
#'
#' @description
#' Find journals in the TOP dataset, through either the journal name,
#' ISSN, or publisher name.
#' @param x character or numeric vector
#' @param exact_match
#' whether to only return exact matches, or use input as a sub-string
#' for grepping
#' @param detail level of detail to return, either "minimal" or NULL
#' @name find_journals
#' @importFrom stats complete.cases
NULL

#' @export
#' @rdname find_journals
journal_name <- function(x, exact_match = TRUE, detail = level_detail$minimal) {
    retrieve_data()
    data <- set_detail(top_env$data, detail)

    # is x scalar?
    if (length(x) == 1) {
        name_helper(x, exact_match, data)
    } else {
        return(
            purrr::map2_dfr(
                .x = x,
                .y = exact_match,
                name_helper,
                data
            )
        )
    }
}

name_helper <- function(x, exact_match, data) {
    if (exact_match) {
        ret <- data[data$Journal == x, ]
        return(ret[complete.cases(ret$Journal), ])
    } else {
        ret <- data[grep(x, data$Journal, ignore.case = TRUE), ]
        return(ret[complete.cases(ret$Journal), ])
    }
}

#' @export
#' @rdname find_journals
journal_issn <- function(x, exact_match = TRUE, detail = level_detail$minimal) {
    retrieve_data()
    data <- set_detail(top_env$data, detail)

    # is x scalar?
    if (length(x) == 1) {
        issn_helper(x, exact_match, data)
    } else {
        return(
            purrr::map2_dfr(
                .x = x,
                .y = exact_match,
                issn_helper,
                data
            )
        )
    }
}

issn_helper <- function(x, exact_match, data) {
    # Silently convert ISSNs into appropriate format
    if (nchar(x) == 8 && (is.numeric(x) || !grepl("-", x))) {
        x <- sub("^(.{4})(.*)$", "\\1-\\2", x)
    }
    if (exact_match) {
        ret <- data[data$Issn == x, ]
        return(ret[complete.cases(ret$Issn), ])
    } else {
        ret <- data[grep(x, data$Issn, ignore.case = TRUE), ]
        return(ret[complete.cases(ret$Issn), ])
    }
}

#' @export
#' @rdname find_journals
publisher_name <- function(x, exact_match = TRUE, detail = level_detail$minimal) {
    retrieve_data()
    data <- set_detail(top_env$data, detail)

    # is x scalar?
    if (length(x) == 1) {
        publisher_helper(x, exact_match, data)
    } else {
        return(
            purrr::map2_dfr(
                .x = x,
                .y = exact_match,
                publisher_helper,
                data
            )
        )
    }
}

publisher_helper <- function(x, exact_match, data) {
    if (exact_match) {
        ret <- data[data$Publisher == x, ]
        return(ret[complete.cases(ret$Publisher), ])
    } else {
        ret <- data[grep(x, data$Publisher, ignore.case = TRUE), ]
        return(ret[complete.cases(ret$Publisher), ])
    }
}

#' Get TOP factor data
#'
#' Returns the full TOP factor dataset
#' as a tibble
#'
#' @return tibble
#' @export
full_data <- function() {
    retrieve_data()
    return(top_env$data)
}

# Misc -------------------------------------------------------------------------

level_detail <- enumr::enum(
    minimal = "minimal",
    detailed = "detailed"
)

set_detail <- function(data, level) {
    if (level == level_detail$minimal) {
        data <- data[
            c(
                "Journal",
                "Issn",
                "Publisher",
                names(data[grep("score", names(data), ignore.case = TRUE)]),
                "Total"
            )
        ]
    }
    data
}
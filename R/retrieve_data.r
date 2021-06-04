# TOP data is stored in a csv
data_url <- "https://osf.io/qatkz/download"
pkg_env <- new.env()

level_detail <- enumr::enum(
    minimal = "minimal",
    detailed = "detailed"
)

retrieve_data <- function() {
    if (is.null(pkg_env$data)) {
        response <- httr::RETRY(
            "GET",
            url = data_url,
            type = httr::content_type("text/csv")
        )
        pkg_env$response <- response
        pkg_env$data <- suppressMessages(
            httr::content(response, encoding = "utf8")
        )
    }
}

set_detail <- function(data, level) {
    if (level == level_detail$minimal) {
        data <- data[
            c(
                "Journal",
                "Issn",
                "Publisher",
                names(data[grep("score", names(data), ignore.case = TRUE)])
            )
        ]
    }
    data
}

#' @export
journal_name <- function(x, exact_match = TRUE, detail = level_detail$minimal) {
    retrieve_data()
    data <- set_detail(pkg_env$data, detail)

    if (exact_match) {
        ret <- data[data$Journal == x, ]
        return(ret[complete.cases(ret$Journal), ])
    } else {
        ret <- data[grep(x, data$Journal, ignore.case = TRUE), ]
        return(ret[complete.cases(ret$Journal), ])
    }
}

#' @export
journal_issn <- function(x, exact_match = TRUE, detail = level_detail$minimal) {
    retrieve_data()
    data <- set_detail(pkg_env$data, detail)

    # Silently convert ISSNs into appropriate format
    if (is.numeric(x)) {
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
publisher_name <- function(x, exact_match = TRUE, detail = level_detail$minimal) {
    retrieve_data()
    data <- set_detail(pkg_env$data, detail)

    if (exact_match) {
        ret <- data[data$Publisher == x, ]
        return(ret[complete.cases(ret$Publisher), ])
    } else {
        ret <- data[grep(x, data$Publisher, ignore.case = TRUE), ]
        return(ret[complete.cases(ret$Publisher), ])
    }
}

#' @export
data <- function() {
    retrieve_data()
    return(pkg_env$data)
}

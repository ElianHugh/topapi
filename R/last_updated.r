#' When was the TOP data last updated?
#'
#' Access the open science framework API and
#' check when the TOP data was last modified
#'
#' @return a POSIX formatted date
#' @export
last_updated <- function() {
    # get timestamp
    response <- httr::GET(
        url = sprintf("https://api.osf.io/v2/files/%s/?format=jsonapi", OSF_id),
        httr::accept_json()
    )
    check_http_status(response)

    cont <- httr::content(
        response,
        as = "parsed",
        type = "application/json"
    )
    as.POSIXct(cont$data$attributes$date_modified)
}

#' @export
last_updated <- function() {
    # get timestamp
    response <- httr::GET(
        url = sprintf("https://api.osf.io/v2/files/%s/?format=jsonapi", OSF_id),
        httr::accept_json()
    )
    cont <- httr::content(
        response,
        as = "parsed",
        type = "application/json"
    )
    as.POSIXct(cont$data$attributes$date_modified)
}

check_http_status <- function(x) {
    if (httr::status_code(x) != 200) {
        stop("Unable to access TOP data")
    }
}
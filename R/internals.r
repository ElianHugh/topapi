# contains the TOP dataset,
# and is accessed by topapi's
# contributed methods
top_env <- new.env()

endpoint <- enumr::enum(
    id = "qatkz",
    download = sprintf(
            "https://osf.io/%s/download",
            .$id
    ),
    file = sprintf(
            "https://api.osf.io/v2/files/%s/?format=jsonapi",
            .$id
    )
)

data_structure <- enumr::enum(
    DataCitation = "DataCitationScore",
    DataTransparency = "DataTransparencyScore",
    CodeTransparency = "CodeTransparencyScore",
    MaterialsTransparency = "MaterialsTransparencyScore",
    DesignAnalysisReporting = "ReportingGuidelinesScore",
    StudyPrereg = "StudyPreregistrationScore",
    PlanPrereg = "AnalysisPlanPreregistrationScore",
    Replication = "ReplicationScore",
    RegReports = "RegReportsScore",
    BadgeScore = "OpenScienceBadgesScore"
)

retrieve_data <- function() {
    if (is.null(top_env$data)) {
        response <- httr::RETRY(
            "GET",
            url = endpoint$download,
            type = httr::content_type("text/csv")
        )
        check_http_status(response)

        top_env$response <- response
        top_env$data <- suppressMessages(
            httr::content(response, encoding = "utf8")
        )

        colnames(top_env$data)[colnames(top_env$data) == "Journal"] <- "Title"
        colnames(top_env$data)[colnames(top_env$data) == "Issn"] <- "ISSN"

        for (i in names(top_env$data[grep("score", names(top_env$data), ignore.case = TRUE)])) {
            x <- switch(i,
                "Data citation score" = data_structure$DataCitation,
                "Data transparency score" = data_structure$DataTransparency,
                "Analysis code transparency score" = data_structure$CodeTransparency,
                "Materials transparency score" = data_structure$MaterialsTransparency,
                "Design & analysis reporting guidelines score" = data_structure$DesignAnalysisReporting,
                "Study preregistration score" = data_structure$StudyPrereg,
                "Analysis plan preregistration score" = data_structure$PlanPrereg,
                "Replication score" = data_structure$Replication,
                "Registered reports & publication bias score" = data_structure$RegReports,
                "Open science badges score" = data_structure$BadgeScore
            )
            names(top_env$data)[names(top_env$data) == i] <- x
        }

        lockEnvironment(top_env, bindings = TRUE)
    }
}
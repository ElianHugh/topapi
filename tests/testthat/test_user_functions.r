test_that("exported methods function appropriately", {
    ret <- journal_name("Autoimmunity Reviews")
    expect_s3_class(ret, "tbl_df")
    expect_length(nrow(ret), 1)

    ret <- journal_name("Crim", exact_match = FALSE)
    expect_s3_class(ret, "tbl_df")
    expect_gte(nrow(ret), 1)

    ret <- journal_issn("1568-9972")
    expect_s3_class(ret, "tbl_df")
    expect_length(nrow(ret), 1)

    ret <- journal_issn("59", exact_match = FALSE)
    expect_s3_class(ret, "tbl_df")
    expect_gte(nrow(ret), 1)

    ret <- journal_name("Elsevier")
    expect_s3_class(ret, "tbl_df")
    expect_length(nrow(ret), 1)

    ret <- publisher_name("Els", exact_match = FALSE)
    expect_s3_class(ret, "tbl_df")
    expect_gte(nrow(ret), 1)

    ret <- full_data()
    expect_s3_class(ret, "tbl_df")
    expect_gte(nrow(ret), 1)
})

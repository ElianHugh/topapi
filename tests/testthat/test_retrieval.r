test_that("retrieve_data correctly sets internal env", {
    expect_true(is.null(top_env$data))
    retrieve_data()
    expect_false(is.null(top_env$data))
})

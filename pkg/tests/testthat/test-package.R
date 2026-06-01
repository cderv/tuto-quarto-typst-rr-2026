test_that("le paquet se charge et expose son nom", {
  expect_true(nzchar(utils::packageDescription("tutotypst")$Package))
})

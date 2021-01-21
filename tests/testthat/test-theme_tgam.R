test_that('tgam_cols has 10 colours', {
  expect_length(tgam_cols(), 10)
})

test_that('tgam_cols returns the graphics palettes', {
  expect_equal(tgam_colors %in% tgam_cols(), rep(TRUE, 10))
})

test_that('tgam_pal interpolates properly for both palettes', {
  expect_match(tgam_pal()(1), '#852E57')
  expect_match(tgam_pal(palette = 'alternate')(1), '#2D5783')
})

# TGAM theme

<!-- badges: start -->
[![R build status](https://github.com/globeandmail/tgamtheme/workflows/R-CMD-check/badge.svg)](https://github.com/globeandmail/tgamtheme/actions)
<!-- badges: end -->

This  is a companion package to The Globe and Mail's data journalism template, [**startr**](https://www.github.com/globeandmail/startr). It contains a series of functions meant to be consumed by the template project, plus additional helpful functions for day-to-day data journalism.

### Installation

```r
devtools::install_github('globeandmail/tgamtheme')
library(tgamtheme)
```

### Usage

```r
mtcars %>%
  rownames_to_column() %>%
  ggplot(aes(x = reorder(rowname, mpg), y = mpg)) +
  geom_col() +
  coord_flip() +
  theme_tgam(position = 'left') +
  labs(
    title = 'Fuel consumption for several types of vehicles',
    subtitle = 'Vehicle models from 1973 to 1974',
    caption = 'THE GLOBE AND MAIL, SOURCE: MOTOR TREND'
  )
```

There's also a palette, `tgam_pal`, along with `scale_color_tgam` and `scale_fill_tgam`.

### Reference

You can find the full reference manual for `tgamtheme`'s functions [**here**](https://globeandmail.github.io/tgamtheme).


### Get in touch

If you've got any questions, feel free to send us an email, or give us a shout on Twitter:

[![Tom Cardoso](https://avatars0.githubusercontent.com/u/2408118?v=3&s=200)](https://github.com/tomcardoso)
---
[Tom Cardoso](mailto:tcardoso@globeandmail.com) <br> [@tom_cardoso](https://www.twitter.com/tom_cardoso)

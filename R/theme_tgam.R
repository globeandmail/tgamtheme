# TGAM graphics colours
tgam_colors <- c(
  `burgundy` = '#852E57',
  `sky`      = '#89CAD3',
  `salmon`   = '#D56161',
  `gold`     = '#C7A274',
  `gray`     = '#CCCCCC',

  `alt1`     = '#2D5783',
  `alt2`     = '#2A929E',
  `alt3`     = '#5FBF9B',
  `alt4`     = '#BAAD9C',
  `alt5`     = '#D8CFC3'
)

#' Function to extract The Globe and Mail's colors as hex codes
#'
#' @param ... Character names of tgam_colors. Colour names include 'burgundy',
#'   'sky', 'salmon', 'gold', 'gray', 'alt1', 'alt2', 'alt3', 'alt4', 'alt5'.
#'
#' @examples tgam_cols()
#' @examples tgam_cols('burgundy')
#' 
#' @return A character vector of one or more colours in The Globe's palette
#'
#' @export
tgam_cols <- function(...) {
  cols <- c(...)
  if (is.null(cols))
    return (tgam_colors)
  tgam_colors[cols]
}

tgam_palettes <- list(
  `main`      = tgam_cols('burgundy', 'sky', 'salmon', 'gold', 'gray'),
  `alternate` = tgam_cols('alt1', 'alt2', 'alt3', 'alt4', 'alt5')
)

#' Return function to interpolate a Globe and Mail color palette
#'
#' @param palette Character name of palette in tgam_palettes. Currently, one of 'main' or 'alternate'.
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
#' @examples tgam_pal()(3)
#' @examples tgam_pal(palette = 'alternate')(3)
#'
#' @return A character vector of interpolated colour values
#'
#' @export
tgam_pal <- function(palette = 'main', reverse = FALSE, ...) {
  pal <- tgam_palettes[[palette]]
  if (reverse) pal <- rev(pal)
  grDevices::colorRampPalette(pal, ...)
}

#' Color scale constructor for The Globe and Mail's colors
#'
#' @param palette Character name of palette in tgam_palettes. Currently, one of 'main' or 'alternate'.
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @examples
#' library(ggplot2)
#' ggplot(diamonds, aes(depth, color = cut)) +
#'   geom_density() +
#'   xlim(55, 70) +
#'   scale_color_tgam()
#'
#' @return A ggplot2 colour scale object, to be passed to a ggplot2 object
#'
#' @export
scale_color_tgam <- function(palette = 'main', discrete = TRUE, reverse = FALSE, ...) {
  pal <- tgam_pal(palette = palette, reverse = reverse)
  if (discrete) {
    ggplot2::discrete_scale('colour', paste0('tgam_', palette), palette = pal, ...)
  } else {
    ggplot2::scale_color_gradientn(colours = pal(256), ...)
  }
}

#' @rdname scale_color_tgam
#' @export
scale_colour_tgam <- scale_color_tgam

#' Fill scale constructor for The Globe and Mail's colors
#'
#' @param palette Character name of palette in tgam_palettes. Currently, one of 'main' or 'alternate'.
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @examples
#' library(ggplot2)
#' ggplot(diamonds, aes(carat, fill = cut)) +
#'   geom_density(position = 'fill') +
#'   scale_fill_tgam()
#'
#' @return A ggplot2 colour scale object, to be passed to a ggplot2 object
#'
#' @export
scale_fill_tgam <- function(palette = 'main', discrete = TRUE, reverse = FALSE, ...) {
  pal <- tgam_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale('fill', paste0('tgam_', palette), palette = pal, ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }
}

#' ggplot Globe and Mail theme
#'
#' Theme function to be passed as an argument during ggplot2 charting.
#'
#' @param size Base font size
#' @param family Font family
#' @param title Font to use for title text
#' @param position How should headings be positioned? Options are 'center' or 'left'. (Default: 'center',)
#'
#' @return A ggplot2 theme object, to be passed to a ggplot2 object
#'
#' @export
theme_tgam <- function(size = 12, family = 'GMsanC-Regular', title = 'GMsanC-Bold', position = 'center') {
  el_text <- ggplot2::element_text
  el_line <- ggplot2::element_line
  el_blank <- ggplot2::element_blank
  el_rect <- ggplot2::element_rect
  m <- ggplot2::margin
  title_pos <- ifelse(position == 'left', 'plot', 'panel')
  hjust_pos <- ifelse(position == 'left', 0, 0.5)

  ggplot2::theme(
    # Base settings
    line = el_line(size = 0.5, linetype = 1, lineend = 'butt', colour = 'black'),
    text = el_text(family = family, size = size),
    plot.margin = m(t = 5, r = 5, b = 5, l = 5, unit = 'pt'),
    title = el_text(size = size),
    panel.background = el_blank(),
    plot.background = el_blank(),

    # Title, subtitle and caption
    plot.title = el_text(size = size + 2, family = title, face = 'bold', lineheight = 1, hjust = hjust_pos, margin = m(t = 0, r = 0, b = 5, l = 0, unit = 'pt')),
    plot.subtitle = el_text(hjust = hjust_pos, margin = m(t = 0, r = 0, b = 10, l = 0, unit = 'pt')),
    plot.caption = el_text(hjust = 0, size = size - 2, colour = '#777777', margin = m(t = 5, r = 0, b = 0, l = 0, unit = 'pt')),
    plot.title.position = title_pos,
    plot.caption.position = 'plot',

    # Axis stuff
    axis.text = el_text(m = c(0, 0, 0, 0), size = size, color = 'black'),
    axis.title = el_blank(),
    axis.line.x = el_blank(),
    axis.ticks.y = el_blank(),
    panel.grid.major = el_blank(),
    panel.grid.minor = el_blank(),
    axis.ticks.x = el_line(colour = 'black', size = 0.5),
    axis.ticks.length = ggplot2::unit(5, 'pt'),
    panel.grid.major.y = el_line(color = '#d0d0d0', size = 0.5),

    # Legend stuff
    legend.key = el_blank(),
    legend.title = el_blank(),
    legend.text = el_text(size = size),
    legend.position = 'top',
    legend.direction = 'horizontal',
    legend.justification = 'top',
    legend.box = 'vertical',
    legend.margin = m(0, 0, 0, 0),

    # Faceting stuff
    panel.spacing = ggplot2::unit(size - 4, 'pt'),
    strip.placement = 'outside',
    strip.background = el_blank(),
    strip.text = el_text(size = size - 1)
  )
}

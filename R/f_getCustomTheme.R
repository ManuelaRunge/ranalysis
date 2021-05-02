#' library(ggplot2)
#'

f_getCustomTheme <- function(fontscl=0){

  customTheme <- theme(
    strip.text.x = element_text(size = 16 + fontscl , face = "bold"),
    strip.text.y= element_text(size = 16 + fontscl, face = "bold"),
    strip.background = element_blank(),
    plot.title = element_text(size = 20 + fontscl , vjust = -1, hjust = 0),
    plot.subtitle = element_text(size = 18 + fontscl),
    plot.caption = element_text(size = 14 + fontscl),
    legend.title = element_text(size = 16 + fontscl ),
    legend.text = element_text(size = 16 + fontscl),
    axis.title.x = element_text(size = 18 + fontscl),
    axis.text.x = element_text(size = 16 + fontscl),
    axis.title.y = element_text(size = 18 + fontscl),
    axis.text.y = element_text(size = 16 + fontscl),
	axis.ticks = element_line(),
	panel.border = element_rect(colour = "black", fill = NA, size = 0.5)
  )
  
  return(customTheme)
}

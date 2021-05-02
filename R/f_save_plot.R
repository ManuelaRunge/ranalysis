#' library(ggplot2)
#'

f_save_plot <- function(pplot, plot_name, plot_dir, width = 14, height = 8) {
  ggsave(paste0(plot_name, ".png"), plot = pplot, path = plot_dir, 
         width = width, height = height, device = "png")
  if(!dir.exists(file.path(plot_dir,"pdf"))){dir.create(file.path(plot_dir, "pdf"))}
  ggsave(paste0(plot_name, ".pdf"), plot = pplot, path = file.path(plot_dir, "pdf"),
         width = width, height = height, device = "pdf",useDingbats=FALSE)
}
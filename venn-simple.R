# Use eulerr package to create simple Venn diagrams for memes etc

library(tidyverse)
library(eulerr)

plot_venn <- function(venn_title = NULL, labels,
                      proportion_2_overlap = 1/3, proportion_3_overlap = 1/3,
                      label_text_size = 12, fill_colour = "steelblue", alpha_adjust = 1) {
  all_labels <- c(labels["A"], labels["B"], labels["C"], labels["AB"], labels["AC"], labels["BC"], labels["ABC"])
  venn_structure <- c("A" = 1, "B" = 1, "C" = 1,
                      "A&B" = proportion_2_overlap, "A&C" = proportion_2_overlap, "B&C" = proportion_2_overlap,
                      "A&B&C" = proportion_3_overlap)
  alpha_pattern <- c(0.1, 0.1, 0.1, 0.25, 0.25, 0.25, 0.5)
  
  venn_plot <- plot(
    euler(venn_structure),
    quantities = list(labels = all_labels, fontsize = label_text_size),
    labels = list(labels = c("", "", "")),
    fills = list(fill = rep(fill_colour, 5), alpha = alpha_pattern * alpha_adjust))
  
  patchwork::wrap_elements(venn_plot) +
    patchwork::plot_annotation(title = venn_title,
                               theme = theme(plot.title = element_text(size = 20, face = "bold")))
}

plot_venn("Lockdown sceptics",
          labels = c(A = "Too stupid to\nfollow the science",
                     B = "Will say any old shit\nif it spreads fear\nand might help\nright wing parties",
                     C = "Too callous to care about\nvulnerable people dying",
                     AB = "", AC = "", BC = "",
                     ABC = "Talkback\nhosts\n& opinion\ncolumnists"),
          fill_colour = "firebrick", alpha_adjust = 1.5
)

ggsave("lockdown-sceptics.png", width = 6, height = 6, dpi = 100, type = "cairo")

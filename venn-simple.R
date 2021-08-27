# Use eulerr package to create simple Venn diagrams for memes etc

library(tidyverse)
library(eulerr)

venn_title <- "Lockdown sceptics"
label_A <- "Too stupid to\nfollow the science"
label_B <- "Will say any old shit\nif it spreads fear\nand might help\nright wing parties"
label_C <- "Too callous to care about\nvulnerable people dying"
label_AB <- ""
label_AC <- ""
label_BC <- ""
label_centre <- "Talkback\nhosts\n& opinion\ncolumnists"

area_tot <- 3
area_2 <- 1
area_3 <- 1

fill_colour <- "firebrick"
alpha_adjust <- 1.5

all_labels <- c(label_A, label_B, label_C, label_AB, label_AC, label_BC, label_centre)
venn_structure <- c("A" = area_tot, "B" = area_tot, "C" = area_tot,
                    "A&B" = area_2, "A&C" = area_2, "B&C" = area_2,
                    "A&B&C" = area_3)
alpha_pattern <- c(0.1, 0.1, 0.1, 0.25, 0.25, 0.25, 0.5)

venn_plot <- plot(
  euler(venn_structure),
  quantities = list(labels = all_labels, fontsize = 14),
  labels = list(labels = c("", "", "")),
  fills = list(fill = rep(fill_colour, 5), alpha = alpha_pattern * alpha_adjust))

patchwork::wrap_elements(venn_plot) +
  patchwork::plot_annotation(title = venn_title,
                             theme = theme(plot.title = element_text(size = 20, face = "bold")))

ggsave("lockdown-sceptics.png", width = 6, height = 6, dpi = 100, type = "cairo")

#!/usr/bin/env Rscript

# This file povides usefull code for automatic converting .Rmd to .md with all
# necessary options and files/image moving to desire folders

rmd.file <- commandArgs(trailingOnly = TRUE)

PublishRmd <- function(rmd.file) {

  # Rmd's file path
  rmd.path <- file.path("Rmarkdown", "")

  # Posts path
  posts.path <- file.path("_posts", "")

  filename <- unlist(strsplit(rmd.file, split='.', fixed = TRUE))[1]

  # Figures path
  figs.path <- file.path("assets", filename, "")

  # Set up knitr
  require(knitr)
  render_jekyll(highlight="pygments")
  opts_knit$set(base.url = file.path("..", ""))
  opts_chunk$set(fig.path=figs.path)

  # Proceed Rmd
  file <- file.path(rmd.path, rmd.file)
  knit(file, output = file.path(posts.path, paste0(filename, ".md")))
}

PublishRmd(rmd.file)

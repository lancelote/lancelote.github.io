#!/usr/bin/env Rscript

# This file povides usefull code for automatic converting .Rmd to .md with all
# necessary options and files/image moving to desire folders

# All credits go to https://github.com/dfeng/dfeng.github.com/blob/master/make.R

Rmd.file <- commandArgs(trailingOnly = TRUE)

publish_rmd <- function(Rmd.file) {
  
  # Rmd's file path
  rmd.path <- file.path("Rmarkdown", "")
  
  # Posts path
  posts.path <- file.path("_posts", "")
  
  filename <- unlist(strsplit(Rmd.file, split='.', fixed = TRUE))[1]
  
  # Figures path
  figs.path <- file.path("assets", filename, "")
  
  # Set up knitr
  require(knitr)
  render_jekyll(highlight="pygments")
  opts_knit$set(base.url = file.path("..", ""))
  opts_chunk$set(fig.path=figs.path)
  
  # Proceed Rmd
  file <- file.path(rmd.path, Rmd.file)
  knit(file, output = file.path(posts.path, paste0(filename, ".md")))
}

publish_rmd(Rmd.file)

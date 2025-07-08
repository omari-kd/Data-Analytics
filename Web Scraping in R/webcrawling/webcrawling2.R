# Web Crawling and Web Scraping 
# install packages
# install.packages("rvest")
# install.packages("tidyverse")
# install.packages("pdftools")
# install.packages("streamR")
# install.packages("readtext")
# install.packages("flextable")
# install.packages("webdriver")
# webdriver::install_phantomjs()


# install klippy for copy-to-clipboard button in code chunks
install.packages("remotes")
remotes::install_github("rlesur/klippy")

# set options
options(stringsAsFactors = F)  # no automatic data transformation
options("scipen" = 100, "digits" = 4)

# load packages
library(tidyverse)
# library(rvest)
# library(readtext)
# library(flextable)
library(webdriver)
# activate klippy for copy-to-clipboard button
klippy::klippy()


library(webdriver)
pjs_instance <- run_phantomjs()
pjs_session <- Session$new(port = pjs_instance$port)



url <- "https://www.theguardian.com/world/2017/jun/26/angela-merkel-and-donald-trump-head-for-clash-at-g20-summit"

library(rvest)

install.packages("Rcrawler")
system("java -version")
library("Rcrawler")
library("rvest")
Rcrawler(Website = "http://r3ap3rpy.pythonanywhere.com/",no_cores = 4, no_conn = 4, Obeyrobots = TRUE)
page <- LinkExtractor(url = "http://r3ap3rpy.pythonanywhere.com/", ExternalLInks = TRUE)
page
Rcrawler(Website = "https://agriweb.org/", no_cores = 4, no_conn = 4, Obeyrobots = TRUE)
page2 <- LinkExtractor(url = "https://agriweb.org/", ExternalLInks = TRUE)
page2
page2$ExternalLinks
page2$InternalLinks

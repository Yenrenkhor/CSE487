library(rtweet)
library(dplyr)
library(stringr)

create_token(
  app = "www.twitter.com",
  consumer_key = "BoWXRggutLO4NqoCNv3GAPR06",
  consumer_secret = "oYgQYNRkLYwnWWcCO0BtqTBSi1NI3GhdLdoyk0NIKC6NG4WXwn",
  access_token = "2438035310-vbjwfTLJsxdqKjjQkujP6suc1MbTgvZha6Ov3u4",
  access_secret = "NoB0NDkf1B8k8xCNnpXmaXn4QwtQrbxFsAmna7mmdfyOE")

since <- "2019-03-01"
until <- "2019-03-30"
search_query = "#technology OR #technologynews OR #tech"
eco_query = "#economics OR #economy OR #economic"
market_query = "#markets OR #stocks OR #investing OR #money"
energy_query = "#energy OR #solar OR #RenewableEnergy"
entre_query = "#entrepreneur OR #business OR #entrepreneurship"
main_query = "#stocks OR #trading OR #news"

stock_tweets <- search_tweets(
  q = main_query, n = 100000, since = since, until = until, include_rts = FALSE,
  geocode = lookup_coords("usa")
  )

tech_file <- data.frame(tech_tweets$text)
filter_tech <- unique(tech_file)
save_as_csv(filter_tech, "sample_tech.csv", prepend_ids = TRUE, fileEncoding = "UTF-8")

eco <- data.frame(eco_tweets$text)
filter_eco <- unique(eco)
save_as_csv(filter_eco, "sample_eco.csv", prepend_ids = TRUE, fileEncoding = "UTF-8")

market_file <- data.frame(market_tweets$text)
filter_mark <- unique(market_file)
save_as_csv(filter_mark, "sample_market.csv", prepend_ids = TRUE, fileEncoding = "UTF-8")

energy_file <- data.frame(energy_tweets$text)
filter_energy <- unique(energy_file)
save_as_csv(filter_energy, "sample_energy.csv", prepend_ids = TRUE, fileEncoding = "UTF-8")

entre_file <- data.frame(entre_tweets$text)
filter_entre <- unique(entre_file)
save_as_csv(filter_entre, "sample_entre.csv", prepend_ids = TRUE, fileEncoding = "UTF-8")

stock_file <- data.frame(stock_tweets$text)
filter_stock <- unique(stock_file)
save_as_csv(filter_stock, "sample_stock.csv", prepend_ids = TRUE, fileEncoding = "UTF-8")

sample_data <- filter_duplicate
sample_data <- rbind(filter_duplicate, filter_eco, filter_energy, filter_entre, filter_mark)

filter_all <- read.csv("sample_stock.csv")
filter_all <- unique(filter_all)
save_as_csv(filter_all, "sample_tweets.csv", prepend_ids = TRUE, fileEncoding = "UTF-8" )

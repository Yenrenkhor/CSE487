library(rtweet)
library(dplyr)
library(stringr)
library(tidyverse)
library(maps)
library(tidyr)

create_token(
  app = "www.twitter.com",
  consumer_key = "BoWXRggutLO4NqoCNv3GAPR06",
  consumer_secret = "oYgQYNRkLYwnWWcCO0BtqTBSi1NI3GhdLdoyk0NIKC6NG4WXwn",
  access_token = "2438035310-vbjwfTLJsxdqKjjQkujP6suc1MbTgvZha6Ov3u4",
  access_secret = "NoB0NDkf1B8k8xCNnpXmaXn4QwtQrbxFsAmna7mmdfyOE")

since <- "2019-2-25"
until <- "2019-3-05"

search_query_more = "#cough OR #influeza OR #fever OR #vaccines OR #health OR #sick OR #flushot"
search_query = "#flu OR # cough OR #H3N2 OR #fluseason OR #fightflu "
even_more_query = "#swineflu OR #CDC OR #fatigue OR #sorethroat OR #headache OR #sneeze OR #flu2019"

lastday_even_more <- search_tweets(
  q= search_query, n = 10000, type="recent",include_rts= TRUE,
  geocode = lookup_coords("usa")
)
extra_lastday <- search_tweets(
  q= search_query_more, n = 10000, type="recent",include_rts= TRUE,
  geocode = lookup_coords("usa")
)
extra_lastdayt <- search_tweets(
  q= even_more_query, n = 10000, type="recent", include_rts= TRUE,
  geocode = lookup_coords("usa")
)
past_more <- search_tweets(
  q= even_more_query, n = 10000, type="recent",since = since, until = until, include_rts= TRUE,
  geocode = lookup_coords("usa")
)

lastday_all <- rbind(extra_lastday, extra_lastdayt, lastday_even_more)

save_as_csv(lastday_all, "lastday_all.csv" , prepend_ids = TRUE, na = "",
            fileEncoding = "UTF-8")

all_tweet <- merge("all_tweet.csv", lastday_all)
#===============================================
#filter
#===============================================

file <- read.csv('all_tweets.csv')
file <-  data.frame(file$text, file$place_full_name, file$geo_coords, file$coords_coords)
#filter duplicate 
filter_duplicate <- unique(file)
#filter rt
filter_rt <- filter_duplicate[grep("RT", filter_duplicate$file.text, invert = TRUE) , ]
#filter coordinate
filter_coordinate <- dplyr::filter(filter_rt, filter_rt$file.coords_coords != 'c(Na, Na)')



save_as_csv(filter_coordinate, "map_coordinate.csv" , prepend_ids = TRUE, na = "",
            fileEncoding = "UTF-8")

#===============================================
#mapping
#===============================================

usmap_data <- read.csv('map_coordinate.csv')
coord <- data.frame(usmap_data$file.coords_coords)





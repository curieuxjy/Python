library(dplyr)
source('preprocess/load_data/data_loader.R')


# 아래 부터 책에 게재
library(RMeCab)

word_matrix <-
  docDF('data/txt', pos=c('NNG', 'NNP','NNB','VV'), type=1, weight='tf*idf*norm')

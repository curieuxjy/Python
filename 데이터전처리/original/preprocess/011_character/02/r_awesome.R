library(dplyr)
source('preprocess/load_data/data_loader.R')

load_txt_df()

# 아래 부터 책에 게재
library(RMeCab)

# poc 매개변수에 대상 품사를 지정한다.
# type은 문자 단위 또는 단어 단위를 지정한다(단어 단위 처리는 1).
word_matrix <- docDF('data/txt', pos=c('NNG', 'NNP','NNB','VV'), type=1)



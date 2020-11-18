source('preprocess/load_data/data_loader.R')
load_lucky_txt()
load_txt_df()

# 아래 부터 책에 게재
# MeCab을R에서 사용하기 위한 라이브러리 로드
library(dplyr)
library(RMeCab)

# luckyd에는 운수 좋은날의 문장 데이터가 담겨있다.
# MeCab을 사용하여 형태소 분석 실행
words <- RMeCabC(lucky)

# 형태소 분석 결과 리스트를 data.frame으로 변환
words <- data.frame(part=names(unlist(words)), word=unlist(words))

# 단어를 품사별로 추출
word_list <- words %>% filter(part == "NNG" |part == "NNP" |part == "NNB" | part == "VV") %>% select(part,word)

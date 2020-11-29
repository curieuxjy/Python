library(dplyr)

# 아래 부터 책에 게재
library(tidyr)
library(RPostgreSQL)

# 분석 대상 데이터를 SQL로 구하기
con <- dbConnect(dbDriver('PostgreSQL'),
                 host='IP주소 또는 호스트며',
                 port='연결 포트 번호',
                 dbname='DB 이름',
                 user='접속 유저 이름',
                 password='접속 패스워드')
sql <- paste(readLines('01_select_base_log.sql'), collapse='\n')
base_log <- dbGetQuery(con,sql)

# 연령대의 카테고리 만들기
base_log$age_rank <- as.factor(floor(base_log$age/10)*10)
levels(base_log$age_rank) <- c(levels(base_log$age_rank),'60 이상')
base_log[base_log$age_rank %in% c('60', '70', '80'), 'age_rank'] <- '60 이상'
base_log$age_rank <- droplevels(base_log$age_rank)

# 연령대, 성별로 경향 파악하기
age_sex_summary <- 
  base_log %>%
    group_by(age_rank, sex) %>%
    summarise(customer_cnt=n_distinct(customer_id),
              rsv_cnt=n(),
              people_num_avg=mean(people_num),
              price_per_person_avg=mean(total_price/people_num)
    )

# 각 지표별로 성별을 가로 데이터로 전개
age_sex_summary %>%
  select(age_rank, sex, customer_cnt) %>% 
  spread(age_rank, customer_cnt)

age_sex_summary %>%
  select(age_rank, sex, rsv_cnt) %>% 
  spread(age_rank, rsv_cnt)

age_sex_summary %>%
  select(age_rank, sex, people_num_avg) %>% 
  spread(age_rank, people_num_avg)

age_sex_summary %>%
  select(age_rank, sex, price_per_person_avg) %>% 
  spread(age_rank, price_per_person_avg)
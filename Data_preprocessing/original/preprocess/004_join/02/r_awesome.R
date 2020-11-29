library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# small_area_name 별로 호텔 수를 계산, 결합 키를 판정하기 위한 테이블
small_area_mst <-
  hotel_tb %>%
    group_by(big_area_name, small_area_name) %>%

    # -1로 자신을 제외
    summarise(hotel_cnt=n() - 1) %>%

    # 집약 처리 후에 그룹화를 해제
    ungroup() %>%

    # 20건 이상이면 join_area_id에 small_area_name을 지정
    # 20건 미만이면 join_area_id에 big_area_name을 지정
    mutate(join_area_id=
             if_else(hotel_cnt >= 20, small_area_name, big_area_name)) %>%
    select(small_area_name, join_area_id)

# 추천 대상 호텔에 small_area_mst를 결합하여 join_area_id를 설정
base_hotel_mst <-
  inner_join(hotel_tb, small_area_mst, by='small_area_name') %>%
    select(hotel_id, join_area_id)

# 필요에 따라 메모리 해제(필수는 아니지만 메모리에 여유가 없을 때 이용)
rm(small_area_mst)

# recommend_hotel_mst는 추천 후보 테이블 
recommend_hotel_mst <-
  bind_rows(
    # join_area_id를 big_area_name으로한 추천 후보 마스터 
    hotel_tb %>%
      rename(rec_hotel_id=hotel_id, join_area_id=big_area_name) %>%
      select(join_area_id, rec_hotel_id),

    # join_area_id를 small_area_name으로한 추천 후보 마스터
    hotel_tb %>%
      rename(rec_hotel_id=hotel_id, join_area_id=small_area_name) %>%
      select(join_area_id, rec_hotel_id)
  )

# base_hotel_mst와 recommend_hotel_mst를 결합하여 추천 후보 정보를 부여
inner_join(base_hotel_mst, recommend_hotel_mst, by='join_area_id') %>%

  # 추천 후보에서 자신을 제외
  filter(hotel_id != rec_hotel_id) %>%
  select(hotel_id, rec_hotel_id)

library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# Spatial 오브젝트를 다루기 위한 sp 패키지 로드
library(sp)
library(rgdal)
# 대상 고객의 테이블에서 집의 위도 경도를 구함
home_locations <- customer_tb %>% select(home_longitude, home_latitude)

# 분 초를 도로 변환하는 함수 정의
convert_to_continuous <- function(x){
  x_min <- (x * 100 - as.integer(x * 100)) * 100
  x_sec <- (x - as.integer(x) - x_min / 10000) * 100
  return(as.integer(x) + x_sec / 60 + x_min / 60 / 60)
}

# 분 초를 도로 변환
home_locations['home_longitude'] <-
  sapply(home_locations['home_longitude'], convert_to_continuous)
home_locations['home_latitude'] <-
  sapply(home_locations['home_latitude'], convert_to_continuous)

# Spatial 오브젝트(위도, 경도값을 가지는 데이터형)로 변환
coordinates(home_locations) <- c('home_longitude', 'home_latitude')

# 한국 측지계 설정
# 지면 관계상 문장을 분할 하여 pasete0 함수로 연결
proj4string(home_locations) <-CRS(
  paste0('+proj=longlat +ellps=bessel ',
         '+towgs84=-146.336,506.832,680.254,0,0,0,0 +no_defs')
)

# 세계 측지계(WGS84)로 변환
# rgdal 패키지를 spTransform 함수 내부에서 이용
home_locations <-
  spTransform(home_locations,
              CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'))

# data.frame으로 변환
home_locations <- data.frame(home_locations)

# customer_tb의 위도 경도를 세계 측지계로 갱산
customer_tb$home_longitude <- home_locations$home_longitude
customer_tb$home_latitude <- home_locations$home_latitude

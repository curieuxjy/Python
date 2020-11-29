library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# Spatial 오브젝트를 다루기 위한 sp 패키지 로드
library(sp)

# 대상 고객 테이블의 집의 위도, 경도 얻기
home_locations <- customer_tb %>% select(home_longitude, home_latitude)

# 분,초를 도로 변환하는 함수 정의
convert_to_continuous <- function(x){
  x_min <- (x * 100 - as.integer(x * 100)) * 100
  x_sec <- (x - as.integer(x) - x_min / 10000) * 100
  return(as.integer(x) + x_sec / 60 + x_min / 60 / 60)
}

# 분, 초를 도로 변환
home_locations['home_longitude'] <-
  sapply(home_locations['home_longitude'], convert_to_continuous)
home_locations['home_latitude'] <-
  sapply(home_locations['home_latitude'], convert_to_continuous)

# Spatial 오브젝트(위도 경도의 데이터형 )로 변환
coordinates(home_locations) <- c('home_longitude', 'home_latitude')

# 동경 측지계 설정
# 서식 떄문에 문장을 분할 하여 pasete0 함수로 연결
proj4string(home_locations) <-CRS(
  paste0('+proj=longlat +ellps=bessel ',
         '+towgs84=-146.336,506.832,680.254,0,0,0,0 +no_defs')
)

# 세계 측지계로 변환
# rgdal 패키지를 spTransform 함수에서 이용
home_locations <-
  spTransform(home_locations,
              CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'))

# data.frame으로 변환
home_locations <- data.frame(home_locations)

# customer_tb의 위도 경도를 세계 측지계로 갱신
customer_tb$home_longitude <- home_locations$home_longitude
customer_tb$home_latitude <- home_locations$home_latitude


# 아래 부터 책에 게재
library(geosphere)

# ・・・측지계 변화 코드는 생략・・・

# 예약 테이블에 고객 테이블과 호텔 테이블을 결합
reserve_all_tb <- inner_join(reserve_tb, hotel_tb, by='hotel_id')
reserve_all_tb <- inner_join(reserve_all_tb, customer_tb, by='customer_id')

# 방위각 계산
bearing(reserve_all_tb[, c('home_longitude', 'home_latitude')],
        reserve_all_tb[, c('hotel_longitude', 'hotel_latitude')])

# Haversin식으로 거리 계산
distHaversine(reserve_all_tb[, c('home_longitude', 'home_latitude')],
              reserve_all_tb[, c('hotel_longitude', 'hotel_latitude')])

# Vincenty식으로 거리 계산
distVincentySphere(reserve_all_tb[, c('home_longitude', 'home_latitude')],
                   reserve_all_tb[, c('hotel_longitude', 'hotel_latitude')])

# Hubeny식 함수 정의
distHubeny <- function(x){
  a=6378137
  b=6356752.314245
  e2 <- (a ** 2 - b ** 2) / a ** 2
  points <- sapply(x, function(x){return(x * (2 * pi) / 360)})
  lon1 <- points[[1]]
  lat1 <- points[[2]]
  lon2 <- points[[3]]
  lat2 <- points[[4]]
  w = 1 - e2 * sin((lat1 + lat2) / 2) ** 2
  c2 = cos((lat1 + lat2) / 2) ** 2
  return(sqrt((b ** 2 / w ** 3) * (lat1 - lat2) ** 2
              + (a ** 2 / w) * c2 * (lon1 - lon2) ** 2))
}

# Hubeny식으로 거리 계산 
apply(
  reserve_all_tb[, c('home_longitude', 'home_latitude',
                     'hotel_longitude', 'hotel_latitude')],
  distHubeny, MARGIN=1
)


import pandas as pd
import pyproj
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()


# 분,초를 도로 변환하는 함수 정의
def convert_to_continuous(x):
    # 아래의 식으로 실행하면 약간의 오차가 발생,
  # 정확한 값으로 계산하고 싶을 땐, 문자열로 변환한 후 도,분,초의 값을 숫자로 변환하여 계산
    x_min = (x * 100 - int(x * 100)) * 100
    x_sec = (x - int(x) - x_min / 10000) * 100
    return int(x) + x_sec / 60 + x_min / 60 / 60

# 분, 초를 도로 변홤
customer_tb['home_latitude'] = customer_tb['home_latitude'] \
  .apply(lambda x: convert_to_continuous(x))
customer_tb['home_longitude'] = customer_tb['home_longitude'] \
  .apply(lambda x: convert_to_continuous(x))

# 세계 측지계(EPSG 코드 4326은 WGS84와 같다)를 구함
epsg_world = pyproj.Proj('+init=EPSG:4326')

# 한국 측지계 획득
epsg_korea = pyproj.Proj('+init=EPSG:4301')

# 한국 측지계를 세계 측지계로 변환
home_position = customer_tb[['home_longitude', 'home_latitude']] \
  .apply(lambda x:
         pyproj.transform(epsg_korea, epsg_world, x[0], x[1]), axis=1)

# customer_tb의 위도 경도 값을 세계 측지계로 갱신
customer_tb['home_longitude'] = [x[0] for x in home_position]
customer_tb['home_latitude'] = [x[1] for x in home_position]


# 아래 부터 책에 게재
# python으로 위도 경도 위치정보를 다루기위한 라이브러리 로드
import math
import pyproj

# 거리를 계산하기 위한 라이브러리 로드
from geopy.distance import great_circle, vincenty

# ・・・측지계 변화 코드는 생략・・・

# 예약 테아블에 고객 테이블과 호텔 테이블을 결합
reserve_tb = \
  pd.merge(reserve_tb, customer_tb, on='customer_id', how='inner')
reserve_tb = pd.merge(reserve_tb, hotel_tb, on='hotel_id', how='inner')

# 집과 호텔의 위도 경도 정보를 획득
home_and_hotel_points = reserve_tb \
  .loc[:, ['home_longitude', 'home_latitude',
           'hotel_longitude', 'hotel_latitude']]

# 적도 반경을 WGS84기준으로 설정
g = pyproj.Geod(ellps='WGS84')

# 방위각 반방위각, Vincenty식을 이용한 거리 계산
home_to_hotel = home_and_hotel_points \
  .apply(lambda x: g.inv(x[0], x[1], x[2], x[3]), axis=1)

# 방위각을 구함
[x[0] for x in home_to_hotel]

# Vincenty식을 이용한 거리를 구함
[x[2] for x in home_to_hotel]

# Haversine식을 이용한 거리 계산
home_and_hotel_points.apply(
  lambda x: great_circle((x[1], x[0]), (x[3], x[2])).meters, axis=1)

# Vincenty식을 이용한 거리 계산
home_and_hotel_points.apply(
  lambda x: vincenty((x[1], x[0]), (x[3], x[2])).meters, axis=1)


# Hubeny식의 함수 정의
def hubeny(lon1, lat1, lon2, lat2, a=6378137, b=6356752.314245):
    e2 = (a ** 2 - b ** 2) / a ** 2
    (lon1, lat1, lon2, lat2) = \
      [x * (2 * math.pi) / 360 for x in (lon1, lat1, lon2, lat2)]
    w = 1 - e2 * math.sin((lat1 + lat2) / 2) ** 2
    c2 = math.cos((lat1 + lat2) / 2) ** 2
    return math.sqrt((b ** 2 / w ** 3) * (lat1 - lat2) ** 2 +
                     (a ** 2 / w) * c2 * (lon1 - lon2) ** 2)

# Hubeny식을 이용한 거리 계산
home_and_hotel_points \
  .apply(lambda x: hubeny(x[0], x[1], x[2], x[3]), axis=1)

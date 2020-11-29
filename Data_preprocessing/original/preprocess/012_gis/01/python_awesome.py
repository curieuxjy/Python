from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
import pyproj


# 분,초를 도로 변환하는 함수를 정의
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
epsg_korea = pyproj.Proj('+init=EPSG:4301')#4162

# 한국 측지계를 세계 측지계로 변환
home_position = customer_tb[['home_longitude', 'home_latitude']] \
  .apply(lambda x:
         pyproj.transform(epsg_korea, epsg_world, x[0], x[1]), axis=1)

# customer_tb의 위도 경도 값을 세계 측지계로 갱신
customer_tb['home_longitude'] = [x[0] for x in home_position]
customer_tb['home_latitude'] = [x[1] for x in home_position]

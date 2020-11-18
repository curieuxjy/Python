from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
from sklearn.preprocessing import StandardScaler

# 소수점 이하를 다룰수 있게 하기 위해 float형으로 변환
reserve_tb['people_num'] = reserve_tb['people_num'].astype(float)

# 정규화를 실행할 오브젝트를 생성
ss = StandardScaler()

# fit_transform 함수는 fit 함수(정규화 하기위한 준비 계산)와 
# transform 함수 (준비된 정보에서 정규화 변환 처리를 실행)를 모두 실행
result = ss.fit_transform(reserve_tb[['people_num', 'total_price']])

reserve_tb['people_num_normalized'] = [x[0] for x in result]
reserve_tb['total_price_normalized'] = [x[1] for x in result]

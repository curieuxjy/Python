from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# sex가 man일 때 TRUE 값을 가지는 불린 형을 추가
# 이 코드는 as.type 함수가 아니여도 불린형으로 변환된다
customer_tb[['sex_is_man']] = (customer_tb[['sex']] == 'man').astype('bool')

# sex를 카테고리 형으로 변환
customer_tb['sex_c'] = \
  pd.Categorical(customer_tb['sex'], categories=['man', 'woman'])

# astype 함수로도 변환 가능
# customer_tb['sex_c'] = customer_tb['sex_c'].astype('category')

# 인덱스 데이터는 codes에 저장된다
customer_tb['sex_c'].cat.codes

# 마스터 데이터는 categories에 저장된다
customer_tb['sex_c'].cat.categories

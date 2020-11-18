from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 집약 단위를 hotel_id와 people_num의 조합으로 지정
# 집약한 데이터에서 total_price를 추출하여, sum함수에 적용하여 매출 합계 금액을 산출
result = reserve_tb \
  .groupby(['hotel_id', 'people_num'])['total_price'] \
  .sum().reset_index()

# 매출 합계 금액의 열 이름이 total_price로 되어 있는 것을price_sum으로 변경
result.rename(columns={'total_price': 'price_sum'}, inplace=True)

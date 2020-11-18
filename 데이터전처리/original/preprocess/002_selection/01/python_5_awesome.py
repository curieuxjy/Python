from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# drop함수로 불필요한 열을 제거
# axis를 1로 하여 열을 제거할 것을 지정
# inplace를 True로 하여 reserve_tb를 갱신
reserve_tb.drop(['people_num', 'total_price'], axis=1, inplace=True)

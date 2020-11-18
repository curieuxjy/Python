from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# round 함수로 반올림한 후 mode 함수로 최빈값 계산
reserve_tb['total_price'].round(-3).mode()

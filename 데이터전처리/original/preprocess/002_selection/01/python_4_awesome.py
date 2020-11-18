from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# loc 함수의 2차원 배열의 2차원 항목에 추출할 열의 이름을 배열로 지정하여 열을 추출
reserve_tb.loc[:, ['reserve_id', 'hotel_id', 'customer_id',
                   'reserve_datetime', 'checkin_date',
                   'checkin_time', 'checkout_date']]

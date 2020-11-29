from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_tb의 배열에 추출할 열 이름을 문자열로 지정
reserve_tb[['reserve_id', 'hotel_id', 'customer_id',
            'reserve_datetime', 'checkin_date', 'checkin_time',
            'checkout_date']]

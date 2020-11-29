from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# 배열에 조건식을 지정하여 조건을 만족하는 행을 추출
# DataFrame의 특정 열에 부등식을 이용하요 True/False값을 가지는 배열을 얻는다
# 조건식을 &로 연결하여 판정 결과가 모두 True가 되는 경우에만 True가 되는 배열을 얻는다.
reserve_tb[(reserve_tb['checkout_date'] >= '2016-10-13') &
           (reserve_tb['checkout_date'] <= '2016-10-14')]

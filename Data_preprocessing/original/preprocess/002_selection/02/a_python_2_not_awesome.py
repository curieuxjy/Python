from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# loc함수의 2차원 배열의 1차원 항목에 조건을 지정하여 조건을 만족하는 행을 추출
# loc함수의 2차원 배열의 2차원 항목에 :를 지정하여 모든 열을 추출
reserve_tb.loc[(reserve_tb['checkout_date'] >= '2016-10-13') &
               (reserve_tb['checkout_date'] <= '2016-10-14'), :]
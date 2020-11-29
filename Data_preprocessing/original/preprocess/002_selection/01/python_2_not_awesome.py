from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# iloc함수의 2차원 배열의 1차원 항목에 :를 지정하여 모든 행을 추출
# iloc함수의 2차원 배열의 2차원 항목에 추출할 행 번호를 배열로 지정하여 열을 추출
# 0:6는 [0, 1, 2, 3, 4, 5]와 같은 의미이다.
reserve_tb.iloc[:, 0:6]

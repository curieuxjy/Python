from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_tb에서 50% 샘플링
reserve_tb.sample(frac=0.5)


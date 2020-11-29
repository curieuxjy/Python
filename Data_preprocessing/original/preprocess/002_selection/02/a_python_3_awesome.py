from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
reserve_tb.query('"2016-10-13" <= checkout_date <= "2016-10-14"')

import numpy as np
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
customer_tb['age_rank'] = \
  (np.floor(customer_tb['age'] / 10) * 10).astype('category')

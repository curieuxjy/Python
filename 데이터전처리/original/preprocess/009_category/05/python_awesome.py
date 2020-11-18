from preprocess.load_data.data_loader import load_production
production = load_production()

# 아래 부터 책에 게재
# 제품 종류별 불량률
fault_cnt_per_type = production \
  .query('fault_flg') \
  .groupby('type')['fault_flg'] \
  .count()

# 제품 종류별 제조수
type_cnt = production.groupby('type')['fault_flg'].count()

production['type_fault_rate'] = production[['type', 'fault_flg']] \
  .apply(lambda x:
         (fault_cnt_per_type[x[0]] - int(x[1])) / (type_cnt[x[0]] - 1),
         axis=1)

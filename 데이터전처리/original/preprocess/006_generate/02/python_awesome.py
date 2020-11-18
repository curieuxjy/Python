from preprocess.load_data.data_loader import load_production
production_tb = load_production()

# 아래 부터 책에 게재
# SMOTE 함수를 라이브러리에서 읽어 들임
from imblearn.over_sampling import SMOTE

# SMOTE 함수 설정
# ratio는 불균형 데이터의 적은 열의 데이터를 많은 열의 몇 할 까지 늘릴지 설정
# ( auto는 수가 같아질 때 까지 늘림, 0.5로 설정하면 5할 까지 데이터를 늘림)
# k_neighbors는 smote의 k파라미터
# random_state는 난수의 시드 ( 난수 생성 패턴의 씨악 값)
sm = SMOTE(ratio='auto', k_neighbors=5, random_state=71)

# 오버 샘플링 실행
blance_data, balance_target = \
  sm.fit_sample(production_tb[['length', 'thickness']],
                production_tb['fault_flg'])

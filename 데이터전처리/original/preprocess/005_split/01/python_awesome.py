from preprocess.load_data.data_loader import load_production
production_tb = load_production()

# 아래 부터 책에 게재
from sklearn.model_selection import train_test_split
from sklearn.model_selection import KFold

# 홀드아웃 검증을 위한 데이터 분할
# 예측 모델의 입력값과 예측 대상의 값을 각각 train_test_split 함수에 설정
# test_size는 검증 데이터의 배율
train_data, test_data, train_target, test_target = \
  train_test_split(production_tb.drop('fault_flg', axis=1),
                   production_tb[['fault_flg']],
                   test_size=0.2)

# train_test_split로 행 이름을 현재의 행번호로 바꿈
train_data.reset_index(inplace=True, drop=True)
test_data.reset_index(inplace=True, drop=True)
train_target.reset_index(inplace=True, drop=True)
test_target.reset_index(inplace=True, drop=True)

# 대상 행번호 리스트를 생성
row_no_list = list(range(len(train_target)))

# 교차 검증을 위한 데이터 분할
k_fold = KFold(n_splits=4, shuffle=True)

# 교차수 만큼 반복 처리, 병렬처리도 가능한 부분
for train_cv_no, test_cv_no in k_fold.split(row_no_list):

  # 교차 검증에 사용할 학습 데이터 추출
  train_cv = train_data.iloc[train_cv_no, :]

  # 교차 검증에 사용할 검증 데이터 추출
  test_cv = train_data.iloc[test_cv_no, :]

  # train_data와 train_target를 학습 데이터로,
  # test_data와 test_target을 검증 데이터로 기계 학습 모델의 구축, 검증

# 교차 검증의 결과 정리

# train을 학습 데ㅣ터로, private_test를 검증 데이터로 하여 기계 학습 모델의 구축, 검증

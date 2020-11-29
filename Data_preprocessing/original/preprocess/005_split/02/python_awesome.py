from preprocess.load_data.data_loader import load_monthly_index
monthly_index_tb = load_monthly_index()

# 아래 부터 책에 게재
# train_window_start에 맨 처음 학습 데이터의 시작 행 번호를 지정
train_window_start = 1
# train_window_end에 맨 처음 학습 데이터의 종류 행 번호를 지정
train_window_end = 24
# horizon에 검증 데이터의 데이터 수를 지정
horizon = 12
# skip에 이동할 데이터 수를 설정
skip = 12

# 연월을 기준으로 데이터 정렬
monthly_index_tb.sort_values(by='year_month')

while True:
  # 검증 데이터의 종료 행 번호를 계산
  test_window_end = train_window_end + horizon

  # 행 번호를 지정하여 원본 데이터에서 학습 데이터를 구함
  # train_window_start를 1로 고정하면 학습 데이터를 늘려나가는 검증으로 변환 가능
  train = monthly_index_tb[train_window_start:train_window_end]

  # 행 번호를 지정하여 원본 데이터에서 검증 데이터를 구함
  test = monthly_index_tb[(train_window_end + 1):test_window_end]

  # 검증 데이터의 종료 행 번호가 원본 데이터의 행 수 이상인지 판정
  if test_window_end >= len(monthly_index_tb.index):
    # 모든 데이터를 처리했으면 종료
    break

  # 데아터를 이동 시킨다
  train_window_start += skip
  train_window_end += skip

# 교차 검증의 결과 정리

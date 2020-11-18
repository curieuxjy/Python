import numpy as np
from preprocess.load_data.data_loader import load_production_missing_category
production_missc_tb = load_production_missing_category()

# 아래 부터 책에 게재
# KNeighborsClassifier를 sklearn 라이브러이에서 읽어 들임
from sklearn.neighbors import KNeighborsClassifier

# replace 함수로 None을 nan으로 변환
production_missc_tb.replace('None', np.nan, inplace=True)

# 결손이 발생하지 않은 데이터를 추출
train = production_missc_tb.dropna(subset=['type'], inplace=False)

# 결손이 발생한 데이터를 추출
test = production_missc_tb \
  .loc[production_missc_tb.index.difference(train.index), :]

# knn 모델 생성, n_neighbors는 knn의 k 파라미터
kn = KNeighborsClassifier(n_neighbors=3)

# knn 모델 학습
kn.fit(train[['length', 'thickness']], train['type'])

# knn 모델로 예측값을 계산하여 type을 보완
test['type'] = kn.predict(test[['length', 'thickness']])

from preprocess.load_data.data_loader import load_production
production_tb = load_production()

# 아래 부터 책에 게재
# PCA 블러오기
from sklearn.decomposition import PCA

# n_components에 주성분 분석으로 변환 후의 차원수를 지정
pca = PCA(n_components=2)

# 주성분 분석 실행
# pca에 주성분 분석 변환 파라미터가 저장되어, 반환 값에 주성분 분석 후의  값이 반환된다.
pca_values = pca.fit_transform(production_tb[['length', 'thickness']])

# 누적 기여율과 기여율 확인
print('누적 기여울: {0}'.format(sum(pca.explained_variance_ratio_)))
print('각 차원의 기여율: {0}'.format(pca.explained_variance_ratio_))

# predict 함수를 이용하여 동일한 차원 압축 처리를 실행
pca_newvalues = pca.transform(production_tb[['length', 'thickness']])

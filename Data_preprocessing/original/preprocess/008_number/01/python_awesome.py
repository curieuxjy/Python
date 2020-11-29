import pandas as pd

# 아래 부터 책에 게재
# 데이터형 확인
type(40000 / 3)

# 정수형으로 변환
int(40000 / 3)

# 부동 소수점형으로 변환
float(40000 / 3)

df = pd.DataFrame({'value': [40000 / 3]})

# 데이터형 확인
df.dtypes

# 정수형으로 변환
df['value'].astype('int8')
df['value'].astype('int16')
df['value'].astype('int32')
df['value'].astype('int64')

# 부동 소수점형으로 변환
df['value'].astype('float16')
df['value'].astype('float32')
df['value'].astype('float64')
df['value'].astype('float128')

# 아래와 같이 python의 데이터형을 지정할 수 있다
df['value'].astype(int)
df['value'].astype(float)

iris['class'].unique()
iris['class'].value_counts()

# [데이터프레임명.groupby(칼럼명).구조화방식()] 처럼 사용한다
iris.groupby('class').sum()

# set_index(칼럼명)를 사용하면 특정 칼럼을 행 인덱스로 적용 가능
df = df.set_index('이름')
df
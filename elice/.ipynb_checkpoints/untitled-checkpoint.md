iris['class'].unique()
iris['class'].value_counts()

# [데이터프레임명.groupby(칼럼명).구조화방식()] 처럼 사용한다
iris.groupby('class').sum()

df.set_index('이름')
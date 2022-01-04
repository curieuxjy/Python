"""
Chapter 2
Python Advanced(2) - Method Overloading
Keyword - overloading, oop, multiple dispatch

"""
"""

메소드 오버로딩 효과
1. 동일 메소드 재정의
2. 네이밍으로 기능 예측
3. 코드 절약, 가독성 향상
4. 메소드 파라미터 기반 호출 방식

"""

# Ex1
# 동일 이름 메소드 사용 예제
# 동적 타입 검사 -> 런타임에 실행(타입 에러가 실행시에 발견)

class SampleA():
    
    def add(self, x, y):
        return x + y

    def add(self, x, y, z):
        return x + y + z
    
    # 팩킹으로 해결 가능
    # def add(self, *args):
    #     return sum(args)

a = SampleA()

# print('Ex1 > ', a.add(2,3)) # 예외 발생

# 모든 속성 개체 확인
print('Ex1 > ', dir(a))


# Ex2
# 동일 이름 메소드 사용 예제
# 자료형에 따른 분기 처리
class SampleB():
    
    def add(self, datatype, *args):
        if datatype =='int': 
            return sum(args)

        if datatype =='str': 
            return ''.join([x for x in args])

b = SampleB()

# 숫자 연산
print('Ex2 > ', b.add('int', 5, 6))
# 문자열 연산
print('Ex2 > ', b.add('str', 'Hi ', 'Geeks'))


# Ex3
# multipledispatch 패키지를 통한 메소드 오버로딩
from multipledispatch import dispatch

class SampleC():
    
    @dispatch(int,int) 
    def product(x, y): 
        return x * y 

    @dispatch(int,int,int) 
    def product(x, y, z): 
        return x * y * z

    @dispatch(float,float,float) 
    def product(x, y, z): 
        return x * y * z
        
c = SampleC()

# 정수 파라미터 2개
print('Ex3 > ', c.product(5, 6))

# 정수 파라미터 3개
print('Ex3 > ', c.product(5, 6, 7))

# 실수 파라미터 3개
print('Ex3 > ', c.product(5.0, 6.0, 7.0))

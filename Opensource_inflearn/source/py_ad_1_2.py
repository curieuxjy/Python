"""
Chapter 1
Python Advanced(1) - Lambda, Reduce, Map, Filter Functions
Keyword - lambda, map, filter, reduce

"""
"""
lambda 장점 : 익명, 힙 영역 사용 즉시 소멸, pythonic?, 파이썬 가비지 컬렉션(Count = 0)
일반함수 : 재사용성 위해 메모리 저장
시퀀스형 전처리에 Reduce, Map, Filter 자주 사용

"""

# Ex1
cul = lambda a, b, c: a * b + c

print('Ex1 >', cul(10, 15, 20))

# Ex2
digits1 = [x * 10 for x in range(1, 11)]
print('Ex2 >', digits1)

def ex2_func(x):
    return x **2

# result = list(map(ex2_func , digits))
result = list(map(lambda i: i ** 2 , digits1))

print('Ex2 >', result)

def also_square(nums):
    def double(x):
        return x ** 2
    return map(double, nums)

print('Ex2 >', list(also_square(digits1)))

# Ex3
digits2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

result = list(filter(lambda x: x % 2 == 0, digits2))

print('Ex3 >', result)

def also_evens(nums):
    def is_even(x):
        return x % 2 == 0
    return filter(is_even, nums)

print('Ex3 >', list(also_evens(digits2)))

# Ex4
from functools import reduce

digits3 = [x for x in range(1, 101)]

result = reduce(lambda x, y: x+y, digits3)

print('Ex4 >', result)

def also_add(nums):
    def add_plus(x, y):
        return x + y
    return reduce(add_plus, nums)

print('Ex3 >', also_add(digits3))
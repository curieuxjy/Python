"""
Chapter 3
Python Advanced(3) - Descriptor(2)
Keyword - descriptor vs property, low level(descriptor) vs high level(property)

"""
"""

디스크립터

1. 상황에 맞는 메소드 구현을 통한 객체 지향 프로그래밍 구현
2. Property와 달리 reuse(재사용) 가능
3. ORM Framework 사용 : https://docs.python.org/ko/3/howto/descriptor.html#orm-example

"""

# Ex1
# Descriptor 예제(1)

import os

class DirectoryFileCount:
    def __get__(self, obj, objtype=None):
        # print(os.listdir(obj.dirname))
        return len(os.listdir(obj.dirname))

class DirectoryPath:
    # Descriptor instance
    size = DirectoryFileCount()             
    # Regular instance attribute
    def __init__(self, dirname):
        self.dirname = dirname          

# 현재 경로
s = DirectoryPath('./')
# 이전 경로 
g = DirectoryPath('../')

# 헷갈릴때 출력 용도
print('Ex1 > ', dir(DirectoryPath))
print('Ex1 > ', DirectoryPath.__dict__)
print('Ex1 > ', dir(s))
print('Ex1 > ', s.__dict__)

# 확인
print(s.size)
print(g.size)

# Ex2
# Descriptor 예제(2)

import logging

logging.basicConfig(
    format='%(asctime)s %(message)s',
    level=logging.INFO,
    datefmt='%Y-%m-%d %H:%M:%S'
)

class LoggedScoreAccess:

    def __init__(self, value=60):
        self.value = value

    def __get__(self, obj, objtype=None):
        logging.info('Accessing %r giving %r', 'score', self.value)
        return self.value

    def __set__(self, obj, value):
        logging.info('Updating %r to %r', 'score', self.value)
        self.value = value

class Student:
    # Descriptor instance
    score = LoggedScoreAccess()             

    def __init__(self, name):
        # Regular instance attribute
        self.name = name                  


s1 = Student('Kim')
s2 = Student('Lee')

# 점수 확인(s1)
print('Ex2 > ', s1.score)
s1.score += 10
print('Ex2 > ', s1.score)

# 점수 확인(s2)
print('Ex2 > ', s2.score)
s2.score += 20
print('Ex2 > ', s2.score)

# __dict__ 확인
print('Ex2 > ', vars(s1))
print('Ex2 > ', vars(s2))
print('Ex2 > ', s1.__dict__)
print('Ex2 > ', s2.__dict__)
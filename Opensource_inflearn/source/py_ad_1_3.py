"""
Chapter 1
Python Advanced(1) - Shallow Copy & Deep Copy
Keyword - shallow & deep cody

"""
"""

객체의 복사 종류 : Copy, Shallow Copy, Deep Copy
정확한 이해 후 사용 프로그래밍 개발 중요(문제 발생 요소)

"""

# Ex1 - Copy

a_list = [1, 2, 3, [4, 5, 6], [7, 8, 9]] # mutable
b_list = a_list

print('Ex1 > ', id(a_list))
print('Ex1 > ', id(b_list))

b_list[2] = 100

print('Ex1 > ', a_list)
print('Ex1 > ', b_list)

b_list[3][2] = 100

print('Ex1 > ', a_list)
print('Ex1 > ', b_list)

# immutable : int, str 변경 불가


# Ex2 - Shallow Copy

import copy

c_list = [1, 2, 3, [4, 5, 6], [7, 8, 9]]
d_list = copy.copy(c_list) 

print('Ex2 > ', id(c_list))
print('Ex2 > ', id(d_list))

# print('Ex2 > ', id(c_list[3]))
# print('Ex2 > ', id(d_list[3]))

d_list[1] = 100

print('Ex2 > ', c_list)
print('Ex2 > ', d_list)

d_list[3].append(1000)
d_list[4][1] = 10000

print('Ex2 > ', c_list)
print('Ex2 > ', d_list)


# Ex3 - Deep Copy

e_list = [1, 2, 3, [4, 5, 6], [7, 8, 9]]
f_list = copy.deepcopy(e_list) 

print('Ex3 > ', id(e_list))
print('Ex3 > ', id(f_list))

# print('Ex3 > ', id(e_list[3]))
# print('Ex3 > ', id(f_list[3]))

f_list[3].append(1000)
f_list[4][1] = 10000

print('Ex3 > ', e_list)
print('Ex3 > ', f_list)
# -*- coding: utf-8 -*-
# UTF-8 encoding when using korean
user_input = input()
temp = user_input.split(' ')
kor = int(temp[0])
math = int(temp[1])
eng = int(temp[2])
score = kor+math+eng
mean = score/3
mean = round(mean,2)
if mean>=90:
	grade = 'A'
elif mean >=80:
	grade = 'B'
elif mean >=70:
	grade = 'C'
elif mean >=60:
	grade = 'D'
else:
	grade = 'F'
print (mean, " ", grade)
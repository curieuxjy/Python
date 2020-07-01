# -*- coding: utf-8 -*-
# UTF-8 encoding when using korean
user_input = input("1000이하의 자연수 입력해주세요.")
number = int(user_input)

temp3list = []
temp5list = []
temp15list = []

for i in range(number):
	
	if (i+1)%3 == 0:
		temp3list.append(i+1)
		
	if (i+1)%5 ==0:
		temp5list.append(i+1)
	
	if (i+1)%15 ==0:
		temp15list.append(i+1)
		
addnum = 0
for i in temp3list:
	addnum +=i
for i in temp5list:
	addnum +=i
for i in temp15list:
	addnum -=i
		
print (addnum)
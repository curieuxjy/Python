# -*- coding: utf-8 -*-
# UTF-8 encoding when using korean
user_input = input()
number = int(user_input)
templist = []
for i in range(number):
	if number%(i+1)==0:
		templist.append(i+1)
		
for i in templist:
	print(i, end=" ")
		
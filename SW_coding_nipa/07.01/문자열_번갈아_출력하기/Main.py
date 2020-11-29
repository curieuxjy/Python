# -*- coding: utf-8 -*-
# UTF-8 encoding when using korean
user_input = input()
stlist = list(user_input)
templist = []
for i in range(len(stlist)):
	if i%2 == 0:
		temp = stlist.pop(0)
		templist.append(temp)
	else:
		temp = stlist.pop(-1)
		templist.append(temp)
result = "".join(templist)

print (result)
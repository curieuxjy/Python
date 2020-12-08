import fitz
import requests

doc = fitz.open("./test.pdf")
# print(len(doc)) # pages of pdf

# 페이지 번호로 가져와서 해당 페이지에 있는 글 가져오기
page = doc.loadPage(0)
text = page.getText()
# print(text)

to_text = ""
for i in doc:
    to_text = to_text + i.getText()

file = open("./to_text.txt", "wb")
file.write(to_text.encode("UTF-8"))
file.close()

# 다시 읽기
file = open("./to_text.txt", "rb")
lines = file.readlines()
file.close()

last_list = list()
temp = ""

for i in lines:
    i = i.decode("UTF-8")
    i = i.replace("\n", " ")

    if len(temp + i) > 5000:
        last_list.append(temp)
        temp = ""
    else:
        temp = temp + i

# print(len(last_list)) # 12
# print(len(last_list[0])) # 4977
# print(len(last_list[1])) # 4961
# print(len(last_list[2])) # 4933

requests_url = "https://openapi.naver.com/v1/papago/n2mt"
headers = {"X-Naver-Client-Id": "NZm09cBOvMD6Fq32PDDN",
           "X-Naver-Client-Secret": "WwgSe3DKjS"}
params = {"source":"en", "target": "ko", "text": sen}
response = requests.post(requests_url, headers=headers, data=params)
result = response.json()
print(result)


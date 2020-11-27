from flask import Flask
app = Flask(__name__) # app 생성
# __name__ <- "pybo"

@app.route('/') # 특정 주소에 접속시 다음 줄에 있는 함수 호출하는 데코레이터
def hello_pybo():
    return 'Hello, Pybo!'
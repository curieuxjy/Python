* [점프 투 플라스크 위키북](https://wikidocs.net/book/4542)
* [소스코드](https://github.com/pahkey/flaskbook)
* [아나콘다 배치파일](https://taeminlee.github.io/virtual-env-miniconda-windows-bat-jupyter/)

# Flask project structure
```
├── pybo/
│      ├─ __init__.py
│      ├─ models.py
│      ├─ forms.py
│      ├─ views/
│      │   └─ main_views.py
│      ├─ static/
│      │   └─ style.css
│      └─ templates/
│            └─ index.html
└── config.py
```

* 데이터베이스를 처리하는 models.py
* 서버로 전송된 폼을 처리하는 forms.py
* 화면을 구성하는 views dir
* CSS, 자바스크립트, 이미지 파일을 저장하는 static dir
* HTML 파일을 저장하는 templates dir
* 파이보 프로젝트를 설정하는 config.py

`set FLASK_APP=pybo`

`set FLASK_ENV=development`
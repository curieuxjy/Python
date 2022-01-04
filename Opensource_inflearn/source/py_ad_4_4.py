"""
Chapter 4
Python Advanced(4) - 나만의 패키지 만들기(3) - PyPI 배포
Keyword - PyPI, build, package deploy

"""

# py_ad_4_3 : 완성된 패키지 임포트
from py_ad_4_3 import GifConverter as gfc

# 클래스 생성
c = gfc("./project/images/*.png", './project/image_out/result.gif', (500,240))

# 실행
c.convert_gif()

"""

패키지 배포 순서(PyPI)
1. https://pypi.org/ 회원가입
2. 프로젝트 구조 확인
3. __init__.py 생성
4. 프로젝트 Root 필수 파일 작성
    - README.md
	- setup.py
	- setup.cfg(optional)
	- LICENSE
	- MANIFEST.in

5. pip install setuptools wheel 설치 후 빌드업 -> 설치판 생성
    - > 설치1 : python -m pip install  --upgrade setuptools wheel 
	->  설치2 : python -m pip install  --user --upgrade setuptools wheel
	- > 빌드 : python setup.py sdist bdist_wheel

6. PyPI 배포
    - > 설치 : pip install twine
	- > 업로드 : python -m twine upload dist/*
7. 설치 확인(pip install pygifconvt)
    - > from pygifconvt import GifConverter as Alias

"""

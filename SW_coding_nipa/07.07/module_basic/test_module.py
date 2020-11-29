PI = 3.141592 #모두 대문자로 변수 선언: 상수형 변수

def number_input():
    output = input("숫자 입력> ")
    return float(output)

def get_circumference(radius):
    return 2*PI*radius

def get_circle_area(radius):
    return PI*radius * radius

print("test_module.py의 __name__: ",__name__)
# testcode
# main.py를 실행 시킬 때는 실행 안됨
# -> __name__이 'test_module'임
# python test_module.py -> __name__ == __main__이 됨
if __name__ == "__main__":
    radius = number_input()
    print(get_circumference(radius)) #원주
    print(get_circle_area(radius)) #면적
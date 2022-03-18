# partial application: 매개변수의 일부를 미리 전달해서 wrapping 함수를 만들고,
#                      이 wrapping된 함수를 사용해 가변적인 매개변수"만" 매개변수로 사용하는 기법
#                      == 일부 매개변수들을 wrapping해서 local variable로 만든 함수를 사용하는 것

def partial(func, *partial_args):

    def wrapper(*extra_args):
        args = list(partial_args)
        args.extend(extra_args)
        print("check: ", args)

        return func(*args)
    return wrapper

def logging(year, month, day, title, content):
    print("%s-%s-%s %s:%s" % (year, month, day, title, content))

def main():
    print("===use logging function===")
    logging("2022", "03", "18", "python2", "End of support in 2020")
    logging("2022", "03", "18", "python3", "Updating")

    print("===use partial function===")
    f = partial(logging, "2022", "03", "19")
    f("python2", "End of support in 2020")
    f("python3", "Updating")


if __name__ == "__main__":
    main()
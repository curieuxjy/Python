# without decorator

def deco(func):

    def wrapper():
        print("before")
        ret = func()
        print("after")
        return ret

    return wrapper

def base():
    print("base function")

if __name__ == "__main__":
    print("===Run decorator 1===")
    deco(base)()

    print("===Run decorator 2===")
    argument = base # just function name
    f = deco(argument)

    f()
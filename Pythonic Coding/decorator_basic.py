# decorator

def deco(func):

    def wrapper():
        print("before")
        ret = func()
        print("after")
        return ret

    return wrapper

@deco
def base():
    print("base function")
    base_return = "base return"
    return base_return

if __name__ == "__main__":
    print("===Run decorator===")
    a = base()
    print(a)
    
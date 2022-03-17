# check closure attribute

def closure1():

    def inner1():
        pass

    return inner1

def closure2():
    x=10
    def inner2():
        y=20
        return x+y

    return inner2


if __name__ == "__main__":
    p1 = closure1()
    p2 = closure2()

    print("===attribute closure1==")
    print(p1.__closure__)
    print("===attribute closure2==")
    print(p2.__closure__)
    print(len(p2.__closure__))
    print(dir(p2.__closure__[0]))
    print(p2.__closure__[0].cell_contents)
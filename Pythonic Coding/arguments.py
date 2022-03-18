# both *args **kwargs
# fixed -> non-keyword args -> keyword args

def test(name, *args, **kwargs):
    print("===fixed argment===")
    print("Fixed argument : %s" %name)

    print("===args list===")
    for arg in args:
        print("Argument : %s" %arg)

    print("===kwargs list===")
    for keyword, arg in kwargs.items():
        print("Argument keyword : %s, arg : %s" % (keyword, arg))

def main():
    args = ["red", "blue", "first", "second"]
    kwargs = {"red": "color", "blue": "color", "first":"number", "second":"number"}

    print("---TEST1---")
    test("jungyeon", *args, **kwargs)
    print("---TEST2---")
    test("jungyeon", "red", "blue", "green", red="color", blue="color")

if __name__ == "__main__":
    main()
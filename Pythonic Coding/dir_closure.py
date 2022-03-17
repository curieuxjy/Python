# closure attribute

def closure():

    def inner():
        pass

    p = dir(inner())

    print("===inner attribute===")
    print(p)
    #closure
    return inner

if __name__=="__main__":
    p = dir(closure())

    print("===attribute===")
    print(p)

    """
    ===inner attribute===
    ['__bool__', '__class__', '__delattr__', '__dir__', '__doc__', '__eq__',
    '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__',
    '__init_subclass__', '__le__', '__lt__', '__ne__', '__new__', '__reduce__',
    '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__',
    '__subclasshook__']
    ===attribute===
    ['__annotations__', '__builtins__', '__call__', '__class__', '__closure__',
    '__code__', '__defaults__', '__delattr__', '__dict__', '__dir__', '__doc__',
    '__eq__', '__format__', '__ge__', '__get__', '__getattribute__', '__globals__',
    '__gt__', '__hash__', '__init__', '__init_subclass__', '__kwdefaults__', '__le__',
    '__lt__', '__module__', '__name__', '__ne__', '__new__', '__qualname__', '__reduce__',
    '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__']
    """

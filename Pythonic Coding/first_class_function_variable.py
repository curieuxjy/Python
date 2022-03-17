# first class function

def square(x):
    return x*x

def main():
    print("Function call")
    print(square(10))

    print("Assign variable")
    f = square
    print(f(10))


if __name__ == "__main__":
    main()
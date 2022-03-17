# global
msg="hello"

def write():
    # local
    msg="world"
    print(msg)

def main():
    print("===print msg===")
    print(msg)

    print("===write function===")
    write()

    print("===print msg===")
    print(msg)

if __name__=="__main__":
    main()
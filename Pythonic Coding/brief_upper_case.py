# higher order function 

LOWER_LIST = ["python", "python2", "python3"]
UPPER_LIST = []

def convert(data):
    return data.upper()

def main():
    print("===print result===")
    UPPER_LIST = map(convert, LOWER_LIST)
    print(LOWER_LIST)
    print("print without list(): ", UPPER_LIST) # map object
    print(list(UPPER_LIST)) # map object is only operated with list()


if __name__ == "__main__":
    main()
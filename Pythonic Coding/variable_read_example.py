######################################
# Scope - namespace
# built-in/global/enclosed/local
# L E G B rule
######################################

# global
msg = "Jungyeon"

def read_work():
    print(msg)
    print("World")

def read_exception():
    print(msg) # recognized as a local variable -> UnboundLocalError: local variable 'msg' referenced before assignment
    msg="World"
    print(msg)

def main():
    print("===first read===")
    read_work()

    print("===second read===")
    read_exception()

if __name__=="__main__":
    main()
# nonlocal keyword
# nested function

def greeting(name):
    greeting_msg = "Hello "

    # run only on call, not immediately
    def add_name():
        return("%s%s" % (greeting_msg, name))

    msg = add_name()
    print(msg)

if __name__ == "__main__":
    greeting("jungyeon")
def greeting(name):
    # at add_name() func stance, greeting_msg is neither "global" nor "local"
    greeting_msg = "hello"

    def add_name():
        greeting_msg += " "
        return ("%s%s" %(greeting_msg, name))

    msg = add_name()
    print(msg)


if __name__ == "__main__":
    greeting("python")

    # UnboundLocalError: local variable 'greeting_msg' referenced before assignment
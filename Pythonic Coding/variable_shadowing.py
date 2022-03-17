var_shadowing = "global" # 1

def outer_function():
    var_shadowing = "outer" # 2
    # if #2 var_shadowing is used in inner_function() using local keyword,
    # it is called "free variable" or "nonlocal variable" (at inner_function stance)

    def inner_function():
        var_shadowing = "inner"
        # if you want to access to #1 var_shadowing -> global keyword
        # if you want to access to #2 var_shadowing -> nonlocal keyword
        print("inner_function scope: %s" % var_shadowing)

    inner_function()
    print("outer_function scope: %s" % var_shadowing)


if __name__ == "__main__":
    outer_function()
    print("global scope: %s" % var_shadowing)
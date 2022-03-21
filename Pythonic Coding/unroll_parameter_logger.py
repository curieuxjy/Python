# why the name of func is weird?

import time
import datetime

def measure_run_time(func):

    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()

        print("'%s' function running time : %s" % (func.__name__, end-start))
        return result

    return wrapper

def parameter_logger(func):

    def wrapper(*args, **kwargs):
        timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
        print("[%s] args : %s, kwargs : %s" % (timestamp, args, kwargs))
        return func(*args, **kwargs)

    return wrapper

def worker(delay_time):
    time.sleep(delay_time)

def main():
    argument = worker
    f1 = parameter_logger(argument)
    f2 = measure_run_time(f1) # f1 is wrapper!!
    f2(5)
    # worker(5)

if __name__ == "__main__":
    main()
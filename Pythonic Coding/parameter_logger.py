# multiple decorator

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

@measure_run_time # second
@parameter_logger # first
def worker(delay_time):
    time.sleep(delay_time)

if __name__ == "__main__":
    worker(5)
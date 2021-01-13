import numpy

# A small handwritten digits dataset
def digits():
	from sklearn.datasets import load_digits
	d=load_digits()
	R = numpy.random.mtrand.RandomState(159).permutation(len(d.data))
	return d.data[R]*1,d.target[R]*1

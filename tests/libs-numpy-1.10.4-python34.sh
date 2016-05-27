python3 <<EOF
import numpy
import sys
import timeit

print("version:", numpy.__version__)
print("maxint:", sys.maxint)
print

x = numpy.random.random((1000,1000))

setup = "import numpy; x = numpy.random.random((1000,1000))"
count = 5

t = timeit.Timer("numpy.dot(x, x.T)", setup=setup)
print("dot:", t.timeit(count)/count, "sec")
EOF

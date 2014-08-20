
ctypedef fused numeric:
    long
    double


cdef bint fastrichcmp(numeric x, numeric y, int op)

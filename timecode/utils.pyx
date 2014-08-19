

cdef bint fastrichcmp(numeric x, numeric y, int op):
    if op == 0:
        return x < y
    elif op == 1:
        return x <= y
    elif op == 2:
        return x == y
    elif op == 3:
        return x != y
    elif op == 4:
        return x > y
    elif op == 5:
        return x >= y

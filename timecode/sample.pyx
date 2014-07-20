
cdef long get_sample_long(x) except? 0:
    if isinstance(x, Sample):
        return x.sample
    elif isinstance(x, int):
        return <long>x
    else:
        raise TypeError('expected Sample or int')

cdef long get_samplecount_long(x) except? 0:
    if isinstance(x, SampleCount):
        return x.count
    elif isinstance(x, int):
        return <long>x
    else:
        raise TypeError('expected Sample or int')


cdef class Sample(object):

    def __cinit__(self, value):
        if isinstance(value, Sample):
            self.sample = value.sample
        else:
            self.sample = value

    def __repr__(self):
        return 'Sample(%s)' % self.sample

    def __int__(self):
        return self.sample

    def __richcmp__(self, other, int op):
        cdef long x = get_sample_long(self)
        cdef long y = get_sample_long(other)
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

    def __add__(self, SampleCount d):
        return Sample(self.sample + d.count)

    def __sub__(self, x):
        if isinstance(x, Sample):
            return SampleCount(self.sample - x.sample)
        elif isinstance(x, SampleCount):
            return Sample(self.sample - x.count)
        else:
            return NotImplemented


cdef class SampleCount(object):

    def __init__(self, value):
        if isinstance(value, SampleCount):
            self.count = value.count
        else:
            self.count = value

    def __repr__(self):
        return 'SampleCount(%s)' % self.count

    def __int__(self):
        return self.count

    def __richcmp__(self, other, int op):
        cdef long x = get_samplecount_long(self)
        cdef long y = get_samplecount_long(other)
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

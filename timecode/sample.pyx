
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
        if not isinstance(other, Sample):
            return NotImplemented
        cdef int x = self.sample
        cdef int y = other.sample
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
        if not isinstance(other, SampleCount):
            return NotImplemented
        cdef int x = self.count
        cdef int y = other.count
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

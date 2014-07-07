
cdef class Time(object):

    def __cinit__(self, value):
        if isinstance(value, Time):
            self.time = value.time
        else:
            self.time = value

    def __repr__(self):
        return 'Time(%s)' % self.time

    def __float__(self):
        return self.time

    def __add__(self, Duration d):
        return Time(self.time + d.duration)

    def __sub__(self, x):
        if isinstance(x, Time):
            return Duration(self.time - x.time)
        elif isinstance(x, Duration):
            return Time(self.time - x.duration)
        else:
            return NotImplemented

    def __richcmp__(self, other, int op):
        if not isinstance(other, Time):
            return NotImplemented
        cdef double x = self.time
        cdef double y = other.time
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


cdef class Duration(object):

    def __cinit__(self, value):
        if isinstance(value, Duration):
            self.duration = value.duration
        else:
            self.duration = value

    def __repr__(self):
        return 'Duration(%s)' % self.duration

    def __float__(self):
        return self.duration

    def __richcmp__(self, other, int op):
        if not isinstance(other, Duration):
            return NotImplemented
        cdef double x = self.duration
        cdef double y = other.duration
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


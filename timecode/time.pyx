
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

    def __add__(Time self, Duration d):
        return Time(self.time + d.duration)

    def __sub__(Time self, x):
        if isinstance(x, Time):
            return Duration(self.time - x.time)
        elif isinstance(x, Duration):
            return Time(self.time - x.duration)
        else:
            return NotImplemented

    def __mul__(self, float x):
        return Time(self.time * x)

    def __richcmp__(self, other, int op):
        if not isinstance(self, Time) or not isinstance(other, Time):
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

    def __abs__(self):
        return Duration(abs(self.duration))

    def __add__(Duration self, Time other):
        return Time(self.duration + other.time)

    def __mul__(Duration self, other):
        if type(other) is not float:
            return NotImplemented
        return Duration(self.duration * other)

    def __truediv__(Duration self, other):
        if type(other) is not float:
            return NotImplemented
        return Duration(self.duration / other)

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


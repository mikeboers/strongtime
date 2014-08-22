from .utils cimport fastrichcmp
from .sample cimport Sample, SampleCount, SampleRate


cdef double EPSILON = 1.0e-12


cdef double get_time_double(x) except *:
    if isinstance(x, Time):
        return x.time
    elif isinstance(x, float):
        return <double>x
    else:
        raise TypeError('expected Time or float')

cdef double get_duration_double(x) except *:
    if isinstance(x, Duration):
        return x.duration
    elif isinstance(x, float):
        return <double>x
    else:
        raise TypeError('expected Duration or float')


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

    def __mul__(Time self, x):
        if isinstance(x, float):
            return Time(self.time * x)
        elif isinstance(x, SampleRate):
            return Sample(self.time * x.rate)
        else:
            raise NotImplemented

    def __richcmp__(self, other, int op):
        return fastrichcmp(
            get_time_double(self),
            get_time_double(other),
            op
        )

    def almost_eq(self, other, double epsilon=EPSILON):
        return abs(get_time_double(self) - get_time_double(other)) <= epsilon

    def almost_lt(self, other, double epsilon=EPSILON):
        return (get_time_double(self) - get_time_double(other)) <= epsilon

    def almost_gt(self, other, double epsilon=EPSILON):
        return (get_time_double(other) - get_time_double(self)) <= epsilon


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
        if isinstance(other, float):
            return Duration(self.duration * other)
        elif isinstance(other, SampleRate):
            return SampleCount(self.duration * other.rate)
        else:
            raise NotImplemented

    def __truediv__(Duration self, other):
        if type(other) is not float:
            return NotImplemented
        return Duration(self.duration / other)

    def __richcmp__(self, other, int op):
        return fastrichcmp(
            get_duration_double(self),
            get_duration_double(other),
            op
        )

    def almost_eq(self, other, double epsilon=EPSILON):
        return abs(get_duration_double(self) - get_duration_double(other)) <= epsilon

    def almost_lt(self, other, double epsilon=EPSILON):
        return (get_duration_double(self) - get_duration_double(other)) <= epsilon

    def almost_gt(self, other, double epsilon=EPSILON):
        return (get_duration_double(other) - get_duration_double(self)) <= epsilon


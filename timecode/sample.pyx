from .utils cimport fastrichcmp
from .time cimport Time, Duration


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

cdef double get_samplerate_double(x) except? 0:
    if isinstance(x, SampleRate):
        return x.rate
    elif isinstance(x, float):
        return <double>x
    else:
        raise TypeError('expected SampleRate or float')


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
        return fastrichcmp(
            get_sample_long(self),
            get_sample_long(other),
            op
        )

    def __add__(self, SampleCount d):
        return Sample(self.sample + d.count)

    def __sub__(self, x):
        if isinstance(x, Sample):
            return SampleCount(self.sample - x.sample)
        elif isinstance(x, SampleCount):
            return Sample(self.sample - x.count)
        else:
            return NotImplemented

    def __div__(Sample self, SampleRate other):
        return Time(<float>self.sample / other.rate)
    def __truediv__(Sample self, SampleRate other):
        return Time(<float>self.sample / other.rate)


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
        return fastrichcmp(
            get_samplecount_long(self),
            get_samplecount_long(other),
            op
        )

    def __div__(SampleCount self, SampleRate other):
        return Duration(<float>self.count / other.rate)
    def __truediv__(SampleCount self, SampleRate other):
        return Duration(<float>self.count / other.rate)


cdef class SampleRate(object):
    """

    SampleRate is a float "number of samples per second".
    SampleRate(base, ntsc=False)

    time = sample / rate
    sample = int(round(time * rate))

    """

    def __init__(self, value):
        if isinstance(value, SampleRate):
            self.rate = value.rate
        else:
            self.rate = value

    def __repr__(self):
        return 'SampleRate(%f)' % self.rate

    def __float__(self):
        return self.rate

    def __richcmp__(self, other, int op):
        return fastrichcmp(
            get_samplerate_double(self),
            get_samplerate_double(other),
            op
        )



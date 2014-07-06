
cdef class Sample(object):

    def __cinit__(self, sample):
        if isinstance(sample, Sample):
            self.sample = sample.sample
        else:
            self.sample = sample

    def __repr__(self):
        return 'Sample(%s)' % self.sample

    def __int__(self):
        return self.sample

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

    def __init__(self, count):
        if isinstance(count, SampleCount):
            self.count = count.count
        else:
            self.count = count

    def __repr__(self):
        return 'SampleCount(%s)' % self.count

    def __int__(self):
        return self.count

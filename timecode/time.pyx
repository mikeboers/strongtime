
cdef class Time(object):

    def __cinit__(self, time):
        if isinstance(time, Time):
            self.time = time.time
        else:
            self.time = time

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


cdef class Duration(object):

    def __cinit__(self, duration):
        if isinstance(duration, Duration):
            self.duration = duration.duration
        else:
            self.duration = duration

    def __repr__(self):
        return 'Duration(%s)' % self.duration

    def __float__(self):
        return self.duration


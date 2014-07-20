import collections
import re

from .sample cimport SampleCount



cdef class Timecode(object):

    def __cinit__(self, value, rate=24):

        if not isinstance(rate, int):
            raise TypeError('rate must be an int')
        
        if isinstance(value, Timecode):
            self.rate = value.rate
            self.hours = value.hours
            self.minutes = value.minutes
            self.seconds = value.seconds
            self.frames = value.frames
            return

        if isinstance(value, int):
            self.rate = rate
            self.seconds, self.frames = divmod(value, rate)
            self.minutes, self.seconds = divmod(self.seconds, 60)
            self.hours, self.seconds = divmod(self.minutes, 60)
            return

        if isinstance(value, basestring):

            m = re.match(r'^(\d{2}):(\d{2}):(\d{2})[:;](\d{2})$', value)
            if not m:
                raise ValueError('bad timecode format')

            self.rate = rate
            self.hours = int(m.group(1))
            self.minutes = int(m.group(2))
            self.seconds = int(m.group(3))
            self.frames = int(m.group(4))

            if self.minutes > 59 or self.seconds > 59 or self.frames > (self.rate - 1):
                raise ValueError('out of range')

            return

        raise TypeError('timecode must be int or str')

    property timecode:
        def __get__(self):
            return '%02d:%02d:%02d:%02d' % (self.hours, self.minutes, self.seconds, self.frames)

    def __str__(self):
        return self.timecode

    property ffm:
        def __get__(self):
            return ((self.hours * 60 + self.minutes) * 60 + self.seconds) * self.rate + self.frames

    def __richcmp__(Timecode self, Timecode other, int op):
        cdef long x = self.ffm
        cdef long y = other.ffm
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

    def __int__(self):
        return self.ffm

    def __sub__(self, other):
        if isinstance(other, Timecode):
            return SampleCount(self.ffm - other.ffm)
        if isinstance(other, SampleCount):
            return Timecode(self.ffm - other.count)
        return NotImplemented




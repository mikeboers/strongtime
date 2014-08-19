import collections
import re

from .sample cimport Sample, SampleCount
from .utils cimport fastrichcmp


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

    cdef long _ffm(self):
        return ((self.hours * 60 + self.minutes) * 60 + self.seconds) * self.rate + self.frames

    property ffm:
        def __get__(self):
            return Sample(self._ffm())

    def __int__(self):
        return self.ffm.sample

    def __richcmp__(Timecode self, Timecode other, int op):
        return fastrichcmp(
            self._ffm(),
            other._ffm(),
            op
        )

    def __sub__(self, other):
        if isinstance(other, Timecode):
            return SampleCount(self.ffm - other.ffm)
        if isinstance(other, SampleCount):
            return Timecode(self.ffm - other.count)
        return NotImplemented




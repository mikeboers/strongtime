import collections
import re


_base = collections.namedtuple('_TimecodeBase', ('timecode', 'fps', 'frames'))


cdef class Timecode(object):

    def __cinit__(self, value, rate=24):

        if isinstance(value, Timecode):
            self.rate = value.rate
            self.hours = value.hours
            self.minutes = value.minutes
            self.seconds = value.seconds
            self.frames = value.frames
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

        raise TypeError('timecode must be timecode or str')

    property timecode:
        def __get__(self):
            return '%02d:%02d:%02d:%02d' % (self.hours, self.minutes, self.seconds, self.frames)

    def __str__(self):
        return self.timecode

    property samples:
        def __get__(self):
            return ((self.hours * 60 + self.minutes) * 60 + self.seconds) * self.rate + self.frames




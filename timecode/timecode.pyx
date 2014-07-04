import collections
import re


_base = collections.namedtuple('_TimecodeBase', ('timecode', 'fps', 'frames'))


class Timecode(_base):

    def __new__(cls, raw, fps=24, field_mode=False, oddfield=False):

        # Passthrough compatible class.
        if isinstance(raw, cls):
            return raw

        elif isinstance(raw, basestring):
            m = re.match(r'^(\d{2}):(\d{2}):(\d{2})[:;](\d{2})$', raw)
            if not m:
                raise ValueError('bad timecode format')
            hours, minutes, seconds, frames = (int(x) for x in m.groups())
            if minutes > 59 or seconds > 59 or frames > (fps - 1):
                raise ValueError('out of range')
            if field_mode:
                ffm = (((hours * 60 + minutes) * 60 + seconds) * fps + frames) * 2 + (1 if oddfield else 0)
            else:
                ffm = ((hours * 60 + minutes) * 60 + seconds) * fps + frames
            return _base.__new__(cls, raw, fps, ffm)

        elif isinstance(raw, int):
            seconds, frames = divmod(raw, fps)
            minutes, seconds = divmod(seconds, 60)
            hours, minutes = divmod(minutes, 60)
            timecode = '%02d:%02d:%02d:%02d' % (hours, minutes, seconds, frames)
            return _base.__new__(cls, timecode, fps, raw)

        else:
            raise TypeError('timecode must be int or str')




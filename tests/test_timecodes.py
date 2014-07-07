import itertools
import operator

from . import *


class TestTimecodes(TestCase):

    def test_rate_types(self):
        self.assertRaises(TypeError, Timecode, '00:00:00:00', 29.97)

    def test_basics_at_zero(self):
        for src in 0, '00:00:00:00':
            tc = Timecode(src, 24)
            self.assertEqual(tc.timecode, '00:00:00:00')
            self.assertEqual(tc.rate, 24)
            self.assertEqual(tc.frames, 0)
            self.assertEqual(tc.ffm, 0)
            self.assertEqual(int(tc), 0)

    def test_basics_at_1hr(self):
        for src in 24, '01:00:00:00':
            tc = Timecode('01:00:00:00', 24)
            self.assertEqual(tc.timecode, '01:00:00:00')
            self.assertEqual(tc.rate, 24)
            self.assertEqual(tc.frames, 0)
            self.assertEqual(tc.ffm, 60 * 60 * 24)
            self.assertEqual(int(tc), 60 * 60 * 24)

    def test_out_of_range(self):
        self.assertRaises(ValueError, Timecode, '12:34:56:78')

    def test_basic_arithmatic(self):
        self.assertEqual(Timecode('01:00:00:00') - Timecode('00:00:00:00'), SampleCount(60 * 60 * 24))

    def test_time_comparisons(self):
        examples = '''
            00:00:00:00
            01:00:00:00
            11:22:33:01
        '''.strip().split()
        for x, y in itertools.permutations(examples, 2):
            for op in (getattr(operator, name) for name in ('lt', 'le', 'eq', 'ne', 'ge', 'gt')):
                self.assertEqual(op(x, y), op(Timecode(x), Timecode(y)))


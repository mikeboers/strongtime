from . import *


class TestTimecodes(TestCase):

    def test_basics_at_zero(self):
        tc = Timecode('00:00:00:00', 24)
        self.assertEqual(tc.timecode, '00:00:00:00')
        self.assertEqual(tc.rate, 24)
        self.assertEqual(tc.frames, 0)
        self.assertEqual(tc.samples, 0)

    def test_basics_at_1hr(self):
        tc = Timecode('01:00:00:00', 24)
        self.assertEqual(tc.timecode, '01:00:00:00')
        self.assertEqual(tc.rate, 24)
        self.assertEqual(tc.frames, 0)
        self.assertEqual(tc.samples, 60 * 60 * 24)

    def test_out_of_range(self):
        self.assertRaises(ValueError, Timecode, '12:34:56:78')


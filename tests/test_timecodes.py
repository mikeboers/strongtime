from . import *


class TestTimecodes(TestCase):

    def test_basics(self):
        tc = Timecode('00:00:00:00', 24)

        self.assertEqual(tc.timecode, '00:00:00:00')
        self.assertEqual(tc[0], '00:00:00:00')

        self.assertEqual(tc.fps, 24)
        self.assertEqual(tc[1], 24)

        self.assertEqual(tc.frames, 0)

    def test_out_of_range(self):
        self.assertRaises(ValueError, Timecode, '12:34:56:78')


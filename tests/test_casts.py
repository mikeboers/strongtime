from . import *


class TestCrossCasts(TestCase):

    def test_sample_to_time(self):
        x = Sample(5)
        self.assertRaises(TypeError, Time, x)

    def test_time_to_sample(self):
        x = Time(2.0)
        self.assertRaises(TypeError, Sample, x)


import itertools

from . import *


class TestCrossCasts(TestCase):

    def test_sample_to_time(self):
        x = Sample(5)
        self.assertRaises(TypeError, Time, x)

    def test_time_to_sample(self):
        x = Time(2.0)
        self.assertRaises(TypeError, Sample, x)

    def test_cross_comparisons(self):
    	for A, B in itertools.permutations((Sample, SampleCount, Time, Duration), 2):
	    	self.assertNotEqual(A(1), B(1))

from __future__ import division

from . import *


class TestSampleRates(TestCase):

    def test_to_from_samples(self):

        rate = SampleRate(24)
        s_a = Sample(240)

        t_a = s_a / rate
        self.assertIsInstance(t_a, Time)
        self.assertAlmostEqual(t_a, 10.0)

        s_b = t_a * rate
        self.assertIsInstance(s_b, Sample)
        self.assertEqual(s_b, 240)
    
    def test_to_from_samplecount(self):

        rate = SampleRate(24)
        s_a = SampleCount(240)

        t_a = s_a / rate
        self.assertIsInstance(t_a, Duration)
        self.assertAlmostEqual(t_a, 10.0)

        s_b = t_a * rate
        self.assertIsInstance(s_b, SampleCount)
        self.assertEqual(s_b, 240)


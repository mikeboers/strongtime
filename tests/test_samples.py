import operator

from . import *


class TestSamples(TestCase):

    def test_cast_to_int(self):

        x = Sample(5)
        y = int(x)
        self.assertEqual(5, y)
        self.assertNotEqual(x, y)

    def test_arithmatic(self):

        a = Sample(5)
        b = Sample(10)

        d = b - a
        self.assertIsInstance(d, SampleCount)
        self.assertEqual(d.count, 5)

        e = a - b
        self.assertIsInstance(d, SampleCount)
        self.assertEqual(e.count, -5)

        x = b + d
        self.assertIsInstance(x, Sample)
        self.assertEqual(x.sample, 15)

        y = a + e + e
        self.assertIsInstance(x, Sample)
        self.assertEqual(y.sample, -5)

    def test_sample_comparisons(self):
        for x, y in [(0, 1), (1, 0), (1, 1)]:
            for op in (getattr(operator, name) for name in ('lt', 'le', 'eq', 'ne', 'ge', 'gt')):
                self.assertEqual(op(x, y), op(Sample(x), Sample(y)))

    def test_sample_count_comparisons(self):
        for x, y in [(0, 1), (1, 0), (1, 1)]:
            for op in (getattr(operator, name) for name in ('lt', 'le', 'eq', 'ne', 'ge', 'gt')):
                self.assertEqual(op(x, y), op(SampleCount(x), SampleCount(y)))



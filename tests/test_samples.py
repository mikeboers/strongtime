from . import *


class TestSamples(TestCase):

    example_points = [-1, 0, 1, 2**32 - 1, 2**32 + 1]

    def test_cast_to_int(self):
        x = Sample(5)
        y = int(x)
        self.assertEqual(5, y)

    def test_arithmatic(self):

        a = Sample(5)
        b = Sample(10)

        d = b - a
        self.assertEqual(d.count, 5)

        e = a - b
        self.assertEqual(e.count, -5)

        x = b + d
        self.assertEqual(x.sample, 15)

        y = a + e + e
        self.assertEqual(y.sample, -5)

    def test_sample_comparisons(self):
        for x, y in itertools.permutations(self.example_points, 2):
            for op in (getattr(operator, name) for name in ('lt', 'le', 'eq', 'ne', 'ge', 'gt')):
                self.assertEqual(op(x, y), op(Sample(x), Sample(y)), '%s(%r, %r) != %s(Sample(%r), Sample(%r))' % (
                    op.__name__, x, y,
                    op.__name__, x, y,
                ))

    def test_sample_count_comparisons(self):
        for x, y in itertools.permutations(self.example_points, 2):
            for op in (getattr(operator, name) for name in ('lt', 'le', 'eq', 'ne', 'ge', 'gt')):
                self.assertEqual(op(x, y), op(SampleCount(x), SampleCount(y)), '%s(%r, %r) != %s(SampleCount(%r), SampleCount(%r))' % (
                    op.__name__, x, y,
                    op.__name__, x, y,
                ))



from . import *


class TestTimes(TestCase):

    example_points = [float(x) for x in [-1, 0, 1, 2**32 - 1, 2**32 + 1]]

    def test_cast_to_from_int(self):
        x = Time(2.0)
        y = float(x)
        self.assertEqual(2.0, y)

    def test_time_comparisons(self):
        for x, y in itertools.permutations(self.example_points, 2):
            for op in (getattr(operator, name) for name in ('lt', 'le', 'eq', 'ne', 'ge', 'gt')):
                self.assertEqual(op(x, y), op(Time(x), Time(y)), '%s(%r, %r) != %s(Time(%r), Time(%r))' % (
                    op.__name__, x, y,
                    op.__name__, x, y,
                ))

    def test_duration_comparisons(self):
        for x, y in itertools.permutations(self.example_points, 2):
            for op in (getattr(operator, name) for name in ('lt', 'le', 'eq', 'ne', 'ge', 'gt')):
                self.assertEqual(op(x, y), op(Duration(x), Duration(y)), '%s(%r, %r) != %s(Duration(%r), Duration(%r))' % (
                    op.__name__, x, y,
                    op.__name__, x, y,
                ))

    def test_approx_comparisons(self):

        for cls in Time, Duration:

            a = cls(0.1 + 0.2)
            b = cls(0.3)

            self.assertFalse(a == b)
            self.assertTrue(a.almost_eq(b))
            self.assertTrue(a.almost_lt(b))
            self.assertTrue(a.almost_gt(b))

            self.assertTrue(cls(1).almost_lt(2.0))
            self.assertFalse(cls(1).almost_eq(2.0))
            self.assertFalse(cls(1).almost_gt(2.0))

            self.assertTrue(cls(2).almost_gt(1.0))
            self.assertFalse(cls(2).almost_eq(1.0))
            self.assertFalse(cls(2).almost_lt(1.0))

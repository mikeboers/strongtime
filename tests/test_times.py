import operator

from . import *


class TestPrimitiveCasts(TestCase):

    def test_cast_to_from_int(self):

        x = Time(2.0)
        y = float(x)
        self.assertEqual(2.0, y)
        self.assertNotEqual(x, y)

    def test_time_comparisons(self):
        for x, y in [(0, 1), (1, 0), (1, 1)]:
            for op in (getattr(operator, name) for name in ('lt', 'le', 'eq', 'ne', 'ge', 'gt')):
                self.assertEqual(op(x, y), op(Time(x), Time(y)))

    def test_duration_comparisons(self):
        for x, y in [(0, 1), (1, 0), (1, 1)]:
            for op in (getattr(operator, name) for name in ('lt', 'le', 'eq', 'ne', 'ge', 'gt')):
                self.assertEqual(op(x, y), op(Duration(x), Duration(y)))

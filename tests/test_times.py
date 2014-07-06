from . import *


class TestPrimitiveCasts(TestCase):

    def test_cast_to_from_int(self):

        x = Time(2.0)
        y = float(x)
        self.assertEqual(2.0, y)
        self.assertNotEqual(x, y)

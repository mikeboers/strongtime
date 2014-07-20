from . import *


class TestTypeStrength(TestCase):

    def test_cross_comparisons(self):
    	for A, B in itertools.permutations(all_types, 2):
            for op in (getattr(operator, name) for name in (
                'lt', 'le', 'eq', 'ne', 'ge', 'gt',
            )):
                try:
                    op(A(1), B(1))
                except TypeError as e:
                    if (A, B) in comparable_type_pairs:
                        self.fail('%s(%s, %s) raised a TypeError' % (op.__name__, A.__name__, B.__name__))
                else:
                    if (A, B) not in comparable_type_pairs:
                        self.fail('%s(%s, %s) did not raise TypeError' % (op.__name__, A.__name__, B.__name__))

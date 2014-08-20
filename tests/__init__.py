from unittest import TestCase
import itertools
import operator
import random
import sys

from strongtime import (
    Timecode,
    Sample, SampleCount, SampleRate,
    Time, Duration,
)



all_types = (Sample, SampleCount, SampleRate, Time, Duration, Timecode, int, float)

def get_type_pairs(*type_sets):
    res = set()
    for type_set in type_sets:
        res.update(itertools.permutations(type_set, 2))
    return res

# Every pair in here should be allowed to compare with all 6 operators
# in either direction.
comparable_type_pairs = frozenset(get_type_pairs(
    (int, float),
    (Sample, int),
    (SampleCount, int),
    (SampleRate, float),
    (Time, float),
    (Duration, float),
))

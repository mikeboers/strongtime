from __future__ import absolute_import

from sqlalchemy.types import TypeDecorator, Integer, Float

from strongtime import Sample, SampleCount, Time


class SampleType(TypeDecorator):

    impl = Integer

    def process_bind_param(self, value, dialect):
        return value.sample if isinstance(value, Sample) else value

    def process_result_value(self, value, dialect):
        return None if value is None else Sample(value)


class SampleCountType(TypeDecorator):

    impl = Integer

    def process_bind_param(self, value, dialect):
        return value.count if isinstance(value, SampleCount) else value

    def process_result_value(self, value, dialect):
        return None if value is None else SampleCount(value)


class TimeType(TypeDecorator):

    impl = Float

    def process_bind_param(self, value, dialect):
        return value.time if isinstance(value, Time) else value

    def process_result_value(self, value, dialect):
        return None if value is None else Time(value)


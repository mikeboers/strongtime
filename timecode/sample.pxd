
cdef class Sample(object):

    cdef readonly long sample


cdef class SampleCount(object):
    
    cdef readonly long count


cdef class SampleRate(object):

    cdef readonly double rate

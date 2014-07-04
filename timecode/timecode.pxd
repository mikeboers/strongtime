
cdef class Timecode(object):

    cdef readonly float rate

    cdef readonly int hours
    cdef readonly int minutes
    cdef readonly int seconds
    cdef readonly int frames


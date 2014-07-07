
cdef class Timecode(object):

    cdef readonly unsigned int rate
    cdef readonly unsigned int hours
    cdef readonly unsigned int minutes
    cdef readonly unsigned int seconds
    cdef readonly unsigned int frames


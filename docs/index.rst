
.. currentmodule:: timecode

**timecode** Documentation
==========================

**timecode** is a Python package for representing various immutable time types used with audio and video. There are two main motivations for the creation and use of this library:

1) parsing/formating/manupulating `SMPTE timecodes <smpte>`_;
2) adding enough type strength to ensure different types of times are not accidentally compared.

There are three sets of classes, representing :ref:`timecode`, :ref:`samples`, and :ref:`time`.


Type Strength
-------------

While the various classes will allow you to explicitly cast to and from whatever base numeric types you want, they will only allow you to compare them to themselves, and the builtin numeric types that are not of the same "category"::

    >>> Time(2) > 1.0
    True

    >>> Time(2) > 1
    Traceback (most recent call last):
    <snip>
    TypeError: expected Time or float

Ergo, :class:`Time`/:class:`Duration` will compare with ``float`` (but not each other), and :class:`Sample`/:class:`SampleCount` will compare with ``int`` (but not each other). :class:`Timecode` will only compare with itself.


API Reference
-------------

.. _timecode:

SMPTE Timecode (strings)
^^^^^^^^^^^^^^^^^^^^^^^^

The :class:`.Timecode` class represents `SMPTE timecode <smpte>`_ strings:

.. autoclass:: timecode.Timecode

    .. attribute:: hours

    .. attribute:: minutes

    .. attribute:: seconds

    .. attribute:: frames

    .. attribute:: ffm

        The number of samples from "midnight" (``"00:00:00:00"``), as a :class:`Sample`.


.. _smpte: http://en.wikipedia.org/wiki/SMPTE_timecode


.. _samples:

Samples (integers)
^^^^^^^^^^^^^^^^^^

The :class:`.Sample` class represents discreet samples (e.g. frames of video), while the :class:`SampleCount` class represents differences between discreet samples (e.g. number of frames in a video).

.. autoclass:: timecode.Sample

    .. attribute:: sample

.. autoclass:: timecode.SampleCount

    .. attribute:: count


.. _time:

Time (floats)
^^^^^^^^^^^^^

The :class:`.Time` class represents real time in seconds, while the :class:`Duration` class represents differences between real times.

.. autoclass:: timecode.Time

    .. attribute:: time

.. autoclass:: timecode.Duration

    .. attribute:: duration


from setuptools import setup, Extension

try:
    from Cython.Distutils import build_ext
except ImportError:
    from setuptools.command.build_ext import build_ext


ext_modules = [Extension(name,
    sources=['%s.pyx' % name.replace('.', '/')],
    include_dirs=['timecode'],
) for name in ('timecode.sample', 'timecode.time', 'timecode.timecode', 'timecode.utils')]


setup(
    
    name='timecode',
    version='0.1.0',
    description='Time and sequence representations for film.',
    url='http://github.com/mikeboers/timecode',
    
    packages=['timecode', 'timecode.ext'],
    ext_modules=ext_modules,

    author='Mike Boers',
    author_email='timecode@mikeboers.com',
    license='BSD-3',

    install_requires=[
        'Cython',
    ],
    cmdclass={'build_ext': build_ext},

)

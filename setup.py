from setuptools import setup, Extension

try:
    from Cython.Distutils import build_ext
except ImportError:
    from setuptools.command.build_ext import build_ext


ext_modules = [Extension(name,
    sources=['%s.pyx' % name.replace('.', '/')],
    include_dirs=['strongtime'],
) for name in ('strongtime.sample', 'strongtime.time', 'strongtime.timecode', 'strongtime.utils')]


setup(
    
    name='strongtime',
    version='0.1.0',
    description='Strongly-typed time and sequence representations for audio/video.',
    url='http://github.com/mikeboers/strongtime',
    
    packages=['strongtime', 'strongtime.ext'],
    ext_modules=ext_modules,

    author='Mike Boers',
    author_email='strongtime@mikeboers.com',
    license='BSD-3',

    install_requires=[
        'Cython',
    ],
    cmdclass={'build_ext': build_ext},

)

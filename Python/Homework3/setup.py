#!/usr/bin/env python

from setuptools import setup, find_packages

setup(
    name='snapshot',
    packages=find_packages(),
    version='1.0',
    author='Andrey_Pavarnitsyn',
    author_email='Andrey_Pavarnitsyn@epam.com',
    description='Monitoring system easy tool',
    install_requires=['psutil', 'prettytable'],
    include_package_data=True
)

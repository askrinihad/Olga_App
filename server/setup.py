from setuptools import setup

setup(
    name='api_classification',
    version='1.0',
    url='http://www.lissi.fr',
    license='',
    author='LISSI',
    author_email='contact-lissi@u-pec.fr',
    description='Flask API for bird and plant identification',
    install_requires=[
        'flask',
        'werkzeug',
        'requests',
        'roboflow',
        'numpy',
        'opencv-python-headless'
    ]
)

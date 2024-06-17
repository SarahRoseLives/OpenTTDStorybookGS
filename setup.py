from setuptools import setup

setup(
    name='OpenTTD-StoryBook-GameScript-Generator',
    version='1.0',
    packages=[''],
    install_requires=[
        'PyQt5==5.15.10',
    ],
    entry_points={
        'console_scripts': [
            'openttd-storybook=main:main',
        ],
    },
    author='Your Name',
    author_email='your.email@example.com',
    description='OpenTTD StoryBook GameScript Generator',
    python_requires='>=3.6',
)

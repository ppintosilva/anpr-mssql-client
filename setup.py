from setuptools import setup

setup(
    name='anpr-mssql-client',
    version='2.0.0',
    py_modules=[],
    install_requires=[
        'click',
        'docker',
        'jinja2'
    ],
    entry_points='''
        [console_scripts]
        client=client:sqlcmd
    ''',
)


from setuptools import setup, find_packages

setup(
    name="CodingChallenges1",
    version="1.0.0",
    description="Coding Challenge",
    author="Iyshwarya",
    author_email="email@example.com",
    packages=find_packages(),  # Automatically find packages within your project
    install_requires=[
        "pyodbc",  # For database connectivity
    ],
)
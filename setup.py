from setuptools import setup, find_packages

setup(
    name="flask-app",
    version="1.0.0",
    packages=find_packages(),
    install_requires=[
        "flask==3.0.2",
        "python-dotenv==1.0.1",
        "gunicorn==21.2.0",
        "pytest==8.0.2",
        "pytest-flask==1.3.0",
    ],
    python_requires=">=3.11",
) 
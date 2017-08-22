#!/usr/bin/env bash

# Exit if a command fails
set -e

# Create the environment

if [ ! -d venv ]; then
    python3 -m venv venv
fi

source venv/bin/activate
mkdir -p lib
pip install -r requirements.txt -t lib

# Zip the lambda
zip -9 lambda.zip main.py

# Zip the dependencies
cd lib
zip -r9 ../lambda.zip .
cd -

# Exit the virtual environment
deactivate
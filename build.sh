#!/usr/bin/env bash

# Exit if a command fails
set -e

# Create the environment

if [ ! -d venv ]; then
    python3 -m venv venv
fi

deactivate || true
source venv/bin/activate
pip install --user -r requirements.txt

# Zip the lambda
zip -9 lambda.zip main.py

# Zip the dependencies
cd venv/lib/python3.6/site-packages/
zip -r9 ../../../../lambda.zip .
cd -

# Exit the virtual environment
deactivate
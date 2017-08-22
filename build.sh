#!/usr/bin/env bash

# Exit if a command fails
set -e

# Create the environment

if [ ! -d venv ]; then
    python3 -m venv venv
fi

source venv/bin/activate
pip install -r requirements.txt

# Zip the lambda
zip -9 lambda.zip main.py

# Zip the dependencies
cd $VIRTUAL_ENV/lib/python3.6/site-packages/
zip -r9 $VIRTUAL_ENV/../lambda.zip .
cd -

# Exit the virtual environment
deactivate
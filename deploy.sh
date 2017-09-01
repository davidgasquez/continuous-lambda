#!/usr/bin/env bash

# Exit if a command fails
set -e

# Create the environment
cd infrastructure
terraform plan

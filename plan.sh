#!/bin/bash

set -o errexit -o nounset

cd infrastructure

terraform init
terraform plan
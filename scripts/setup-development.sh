#!/bin/bash
# Copyright (c) Sunlight Foundation, 2014, BSD-3

set -e

if [ "x${VIRTUAL_ENV}" = "x" ]; then
    echo "Please enter your virtualenv before running this script."
    exit 1
fi

OCD_HOME=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../ && pwd)

cd ${OCD_HOME}
REPOS=$(cat mrconfig  | grep "^\[" | tr -d "[]")

make


for repo in ${REPOS}; do
    cd ${repo}
    if [ -e setup.py ]; then
        python setup.py develop
    fi
    cd -
done

for repo in ${REPOS}; do
    if [ -e ${repo}/requirements.txt ]; then
        pip install -r ${repo}/requirements.txt
    fi
done

pip install Django python-dateutil

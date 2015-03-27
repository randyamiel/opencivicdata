#!/bin/bash
# Copyright (c) Sunlight Foundation, 2014, BSD-3

LOG=$(pwd)/ocd-dev.log
echo "" > ${LOG}

function clone {
    repo=$1
    name=$(basename ${repo} .git)
    if [ -d ${name} ]; then
        echo -e "[   ] clone ${name} skipped"
        echo -ne "[   ] pull ${name}"
        run git -C ${name} pull
    else
        echo -ne "[   ] clone ${name}"
        run git clone --recursive ${repo}
    fi
}

function run {
    echo "Running: $@" >> ${LOG}
    $@ >> ${LOG} 2>&1
    RET=$?
    if [ ${RET} -ne 0 ]; then
        echo -e "\r[ [31mx[0m"
        echo "Ouch. Hit an error. Stopping now."
        exit 1
    else
        echo -e "\r[ [32m✓[0m"
    fi
}

function run-vagrant {
    echo -e "\r[ ."
    machine=$1
    echo -ne "[   ] halting ${machine}"
    run vagrant halt ${machine} || true
    echo -ne "[   ] bringing ${machine} online"
    run vagrant up ${machine}
    echo -ne "[   ] provisioning ${machine}"
    run vagrant provision ${machine}
}

for repo in \
    git@github.com:opencivicdata/imago.git \
    git@github.com:opencivicdata/opencivicdata.org.git \
    git@github.com:opencivicdata/api.opencivicdata.org.git \
    git@github.com:opencivicdata/vagrant-opencivicdata.org.git \
; do
    clone ${repo}
done

cd vagrant-opencivicdata.org
for site in db site api; do
    echo -ne "[   ] vagrant up'ing ${site}"
    run-vagrant ${site}
done
cd ..

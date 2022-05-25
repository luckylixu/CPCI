#!/bin/bash -l

cd "$( dirname "${BASH_SOURCE[0]}")"

echo 'run for :' $1

bsub < CPCI.GDAS_$1.JSUB
bsub < CPCI.GFS_$1.JSUB
bsub < CPCI.GEFS_$1.JSUB




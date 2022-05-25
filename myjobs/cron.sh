#!/bin/bash -l


#---------------------------------------------------------------------------------------------------
# Usage
#
script_name=$(basename "$0")
usage() {
    printf "$script_name HH \n"
    printf "  where  HH is 00 06 12 18 \n"
}

#---------------------------------------------------------------------------------------------------
# Check command-line args
#
if [[ "$#" -ne 1 ]]; then
    usage
    exit 1
fi



cd "$( dirname "${BASH_SOURCE[0]}")"

echo 'run for cyc:' $1

bsub < CPCI.GDAS_$1.JSUB
bsub < CPCI.GFS_$1.JSUB
bsub < CPCI.GEFS_$1.JSUB




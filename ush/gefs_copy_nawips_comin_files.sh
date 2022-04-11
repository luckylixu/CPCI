#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gefs_copy_nawips_comin_files.sh
#
# RFC Contact:
#
# Abstract:
# This script nawips gefs data to $DATA
#
# Input Data Source: GEFS  /com/nawips/prod/gefs.yyyymmdd/
#
# Output Destination: $DATA
#
# Software Package Used: GEMPAK
#
# Script History Log: First Implemented May 2015
# Original Code Development Contact: Vadlamani Kumar, CPC, 301-683-3462
#
###########################################################################################
#!/bin/sh
#
cd $DATA
#
#
for hr in 006 012 018 024 030 036 042 048 054 060 066 072 078 084 090 096 102 108 114 120 \
          126 132 138 144 150 156 162 168 174 180 186 192 198 204 210 216 222 228 234 240 \
          246 252 258 264 270 276 282 288 294 300 306 312 318 324 330 336 342 348 354 360 \
          366 372 378 384 ; do
 cp ${COMINnawips}/gep*_0p50_${PDY}${cyc}f$hr  ${DATA}/
done
#

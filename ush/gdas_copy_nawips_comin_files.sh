#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gdas_copy_nawips_comin_files.sh
#
# RFC Contact:
#
# Abstract:
# This script nawips gdas data to $DATA
#
# Input Data Source: GDAS  /com/nawips/prod/gdas.yyyymmdd/
#
# Output Destination: $DATA
#
# Software Package Used: GEMPAK
#
# Script History Log: First Implemented May 2015
# Original Code Development Contact: Vadlamani Kumar, CPC, 301-683-3462
#
###########################################################################################
#
#!/bin/sh
#
#
cd $DATA
#
#
fh=006
   cp $COMINnawips/gdas_0p25_$PDY${cyc}f${fh} $DATA/
#

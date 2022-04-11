#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gfs_maps_cape_cin_6hrly.sh
#
# RFC Contact:
#
# Abstract:
# This script generates the GFS CAPE and CIN maps (gif format) from the GFS Forecast data files
#
# Input Data Source: GFS  /com/nawips/prod/gfs.yyyymmdd/
#
# Output Destination: COMOUT /com/cpci/prod/gfs.yyyymmdd
#
# Software Package Used: GEMPAK
#
# Script History Log: First Implemented May 2015
# Original Code Development Contact: Vadlamani Kumar, CPC, 301-683-3462
#
###########################################################################################
#
#
#!/bin/sh
#
#Variables passed as arguments from exec script
fh1=$1
fh2=$2
fh3=$3
fh4=$4
task=$5

$USHcpci/gfs_maps_cape_6hrly.sh $fh1 $fh2 $fh3 $fh4 ${task}_1

$USHcpci/gfs_maps_cin_6hrly.sh $fh1 $fh2 $fh3 $fh4 ${task}_2


#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gfs_maps_cape_6hrly.sh
#
# RFC Contact:
#
# Abstract:
# This script generates the GFS CAPE maps (gif format) from the GFS Forecast data files
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
task_dir=$DATA/$task
mkdir -p $task_dir
cd $task_dir
#-----------------------------------------------------
#
cp ${FIXcpci}/gfs_cape_coltbl.xwp coltbl.xwp
#
regions=`cat ${FIXcpci}/regions`

######################################################
# include domain specific resources such as legend etc.
. ${FIXcpci}/domain_resources_file
######################################################

#
pdscl="500;800;1200;1600;2000;2400;2800;3200;3600"
#
######################################################

######################################################
#
for fh in $fh1 $fh2 $fh3 $fh4 ; do
#
#---------------
#
for rgn in $regions ; do
cb=${rgn}_cb
cbar=${!cb}
ltln=${rgn}_ltln
latln=${!ltln}
# 
south=`cut -f 1 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
north=`cut -f 2 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
west=`cut -f 3 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
east=`cut -f 4 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
#
fch=f$fh
gemfile=${DATA}/gfs_0p25_${PDY}${cyc}${fch}
ofile=gfs.${cycle}.cape.f${fh}.${rgn}.gif
#
#
gdplot3 << EOF2

GDFILE   = $gemfile
GDATTIM  = $fch
GLEVEL   = 0
GVCORD   = none
GDPFUN   = cape
PANEL    = 0
SKIP     =  
SCALE    = 
TYPE     = f!s 
CONTUR   = 3/3
CINT     =  
LINE     =  
FINT     = ${pdscl}
FLINE    = 32;11;13;15;17;4;5;6;7;9;10
HILO     =  
HLSYM    =  
CLRBAR   = ${cbar}
WIND     = 
REFVEC   = 2
TITLE    = 1/-3/NOAA GFS ${PDY} ${cycle}CYC FCST  BL CAPE (Joul/Kg)   VALID 20~
TEXT     = 1./1/1/HW
CLEAR    = yes
GAREA    = ${south};${west};${north};${east}
IJSKIP   = 
PROJ     = ced/0;0;0
MAP      = 1/1/2
MSCALE   =  
LATLON   = ${latln}
MARKER   = 
DEVICE  = gif|${ofile}|960;720|C
STNPLT   =  
SATFIL   =  
RADFIL   =  
IMCBAR   =  
LUTFIL   = 
POSN     =  
COLORS   =  
STREAM   = 
GRDLBL   =  
FILTER   = 
BOXLIN   =  1/1/2
REGION   =  plot

r

save gfs_${cycle}_${rgn}_f${fh}_cape.nts 
exit
EOF2


gpend
#

#
#
echo "*******"
echo "Completed" $rgn $fh
echo "*******"
#
cp ${ofile} $COMOUT/
done
done
#

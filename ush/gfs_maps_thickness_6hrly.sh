#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gfs_maps_cape_6hrly.sh
#
# RFC Contact:
#
# Abstract:
# This script generates the 1000-500mb Thickness maps (gif format) from the GFS Forecast data 
#
# Input Data Source: GFS  /com/nawips/prod/gfs.yyyymmdd/
#
# Output Destination: COMOUT /com/cpci/prod/gfs.yyyymmdd
#
# Software Package Used: GEMPAK
#
# Script History Log: First Implemented June 25, 2019
# Original Code Development Contact: Vadlamani Kumar, CPC, 301-683-3462
#
###########################################################################################
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
cp ${FIXcpci}/gfs_precip_coltbl.xwp coltbl.xwp
#
regions=`cat ${FIXcpci}/regions`
#

######################################################
# include domain specific resources such as legend etc.
. ${FIXcpci}/domain_resources_file
######################################################

#
pdscl="4600;4700;4800;4900;5000;5100;5200;5300;5400;5500;5600;5700;5800;5900"
#
# TEXT     = 1./2/2/SW
#-----------------------------------------------------
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
# FINT     = ${pdscl}
# 
south=`cut -f 1 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
north=`cut -f 2 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
west=`cut -f 3 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
east=`cut -f 4 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
#
fch=f$fh
gemfile=${DATA}/gfs_0p25_${PDY}${cyc}${fch}
ofile=gfs.${cycle}.6h_1000-500mbthickness.f${fh}.${rgn}.gif
#
gdplot3 << EOF2

GDFILE   = ${gemfile}
GDATTIM  = ${fch}
GLEVEL   = 500:1000
GVCORD   = pres
PANEL    = 0
SKIP     = 0
SCALE    = 0
GDPFUN   =  ldf(hght)
TYPE     = f
CONTUR   = 3/3
CINT     = 0
LINE     = 2/1/2
FINT     = ${pdscl}
FLINE    = 32;14-22;4-9
HILO     =
HLSYM    =
CLRBAR   = ${cbar}
WIND     =
TITLE    = 1/-3/NOAA GFS ${PDY} ${cycle}cyc FCST  6h 1000-500mb thickness (in dm)  VALID 20~
TEXT     = 1./1/1/HW
CLEAR    = n
GAREA    = ${south};${west};${north};${east}
IJSKIP   = 0
PROJ     = ced/0;0;0
MAP      = 1/1/2
MSCALE   =
LATLON   = ${latln}
MARKER   =
DEVICE  = gif|${ofile}|960;720|C
LUTFIL   =
POSN     =
COLORS   =
GRDLBL   =
FILTER   =
BOXLIN   = 1/1/2
REGION   = plot

r
exit
EOF2

gpend
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

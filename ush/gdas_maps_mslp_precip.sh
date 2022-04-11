#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gdas_maps_cape_6hrly.sh
#
# RFC Contact:
#
# Abstract:
# This script generates the MSLP/Precip maps (gif format) from the GDAS Forecast data
#
# Input Data Source: GDAS  /com/nawips/prod/gdas.yyyymmdd/
#
# Output Destination: COMOUT /com/cpci/prod/gdas.yyyymmdd/
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
#-----------------------------------------------------
#Global Variables from JJOB
#
#Variables passed as arguments from exec script
task=$1
task_dir=$DATA/$task
mkdir -p $task_dir
cd $task_dir
#-----------------------------------------------------
#
cp ${FIXcpci}/gdas_mslp_coltbl.xwp coltbl.xwp
#
regions=`cat ${FIXcpci}/regions`
#

######################################################
# include domain specific resources such as legend etc.
. ${FIXcpci}/domain_resources_file
######################################################

#
pdscl="1;2;3;4;5;6;8;10;12;14;16;18;20;25"
#
# TEXT     = 1./2/2/SW
#-----------------------------------------------------
#
fh=006
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
gemfile=${DATA}/gdas_0p25_${PDY}${cyc}${fch}
ofile=gdas.${cycle}.mslp_6h_totp.f${fh}.${rgn}.gif
#
gdplot3 << EOF2

GDFILE   = ${gemfile}
GDATTIM  = ${fch}
GLEVEL   = 0
GVCORD   = none
PANEL    = 0
SKIP     = 0
SCALE    = 0
GDPFUN   = p06m ! sm5s(pmsl)
TYPE     = f  ! c
CONTUR   = 0/0
CINT     = 0 ! 4
LINE     = 2/1/2 ! 8/1/2/1
FINT     = ${pdscl}
FLINE    = 32;14-22;4-9
HILO     =  
HLSYM    =  
CLRBAR   = ${cbar}
WIND     = 
TITLE    = 1/-3/NOAA GDAS ${PDY} ${cycle}cyc FCST  6h MSLP and Total Precip (mm)   VALID 20~
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

echo "*******"
echo "Completed" $rgn $fh
echo "*******"
cp ${ofile} $COMOUT/
#
done
#

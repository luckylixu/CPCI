#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gdas_maps_cape_6hrly.sh
#
# RFC Contact:
#
# Abstract:
# This script generates the LIFTX maps (gif format) from the GDAS Forecast data 
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
cp ${FIXcpci}/gdas_liftx_coltbl.xwp coltbl.xwp
#
regions=`cat ${FIXcpci}/regions`
#

######################################################
# include domain specific resources such as legend etc.
. ${FIXcpci}/domain_resources_file
######################################################

#
pdscl="-10;-9;-8;-7;-6;-5;-4;-3;-2"
#
######################################################

######################################################
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
ofile=gdas.${cycle}.liftx.f${fh}.${rgn}.gif
#
# GLEVEL   = 850 ! 850
# GDPFUN   = omeg!wnd
# SCALE    = 4  ! 0 
# FINT     = -30;-24;-20;-16;-12;-8;8;12;16;20;24;30
#
gdplot3 << EOF2

GDFILE   = $gemfile
GDATTIM  = $fch
GLEVEL   = 0
GVCORD   = none
GDPFUN   = lift
PANEL    = 0
SKIP     =  
SCALE    = 2
TYPE     = f!s 
CONTUR   = 3/3
CINT     =  
LINE     =  
FINT     = 
FLINE    = 9;8;7;6;5;4;19;17;15;32
HILO     =  
HLSYM    =  
CLRBAR   = ${cbar}
WIND     = 
REFVEC   = 2
TITLE    = 1/-3/NOAA GDAS ${PDY} ${cycle}CYC FCST  Sfc Lifted Index   VALID 20~
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

exit
EOF2


gpend
#
#
#
echo "*******"
echo "Completed" $rgn $fh
echo "*******"
cp ${ofile} $COMOUT/
#
done
#

#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gefs_maps_10m_windspd_spa_6hrly.sh
#
# RFC Contact:
#
# Abstract:
# This script generates 10m wind speed spaghetti maps from the GEFS Forecast data
#
# Input Data Source: GEFS  /com/nawips/prod/gefs.yyyymmdd/
#
# Output Destination: COMOUT /com/cpci/prod/gefs.yyyymmdd/
#
# Software Package Used: GEMPAK
#
# Script History Log: First Implemented January 2016
# Original Code Development Contact: Vadlamani Kumar, CPC, 301-683-3462
#
###########################################################################################
#!/bin/sh
#####################################################################################################
#
#Variables passed as arguments from exec script
fh1=$1
lv=$2
cl1=$3
task=$4
task_dir=$DATA/$task
mkdir -p $task_dir
cd $task_dir
#
regions=`cat $FIXcpci/regions`
#
####################################################################################################TA
#
cp $FIXcpci/gefs_spa_coltbl.xwp coltbl.xwp
######################################################
# include domain specific resources such as legend etc.
. $FIXcpci/domain_resources_file
######################################################
#
pdscl="20;30;40;50;60;70;80;90;95"
#
######################################################

for lvl in $lv ; do
######################################################
#
for fh in $fh1 ; do
#
#
for rgn in $regions ; do
cb=${rgn}_cb
cbar=${!cb}
ltln=${rgn}_ltln
latln=${!ltln}
ofile=gefs.${cycle}.windspd_spag_${cl1}kt.f${fh}.${rgn}.gif
#
south=`cut -f 1 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
north=`cut -f 2 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
west=`cut -f 3 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
east=`cut -f 4 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
#----------------------
clr=yes
let color=31
for mem in 01 02 03 04 05 06 07 08 09 10 \
           11 12 13 14 15 16 17 18 19 20 \
           21 22 23 24 25 26 27 28 29 30 ; do
#----------------------
#
fch=f$fh
gemfile=$DATA/gep${mem}_0p50_${PDY}${cyc}${fch}
#
#
gdplot3 << EOF2

GDFILE   = $gemfile
GDATTIM  = $fch
GLEVEL   = ${lvl}

line = ${color}/1/2
clear = ${clr}

GVCORD   = hght
PANEL    = 0
SKIP     =  
SCALE    = 
GDPFUN   = knts(mag(wnd))
TYPE     = c
CONTUR   = 1
CINT     = $cl1/// 
LINE     = ${color}/1/2 
FINT     = 
FLINE    = 
HILO     =  
HLSYM    =  
CLRBAR   = 
WIND     = 
REFVEC   = 2
TITLE    = 1/-3/NOAA GEFS ${today} ${cyc}zCYC FCST 10m WindSpeed ($cl1 kts) Spaghetti  VALID 20~
TEXT     = 1./1/1/HW
CLEAR    = n
GAREA    = ${south};${west};${north};${east}
IJSKIP   = 4/4
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

#
clr=no
let color=color-1
done

gpend

echo "*******"
echo "Completed" $rgn $fh
echo "*******"
#
cp ${ofile} $COMOUT/
done
done
done
#
exit

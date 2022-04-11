#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gfs_maps_precip_3_5_7day.sh
#
# RFC Contact:
#
# Abstract:
# This script generates the GFS 3,5,7-day Total Precip from the GFS Forecast data
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
#!/bin/sh
#
#
task=$1
task_dir=$DATA/$task
mkdir -p $task_dir
cd $task_dir

#
export MODEL_GFS=$DATA
#
cp ${FIXcpci}/gfs_precip_coltbl.xwp coltbl.xwp
cp ${FIXcpci}/datatype.tbl datatype.tbl
#
regions=`cat ${FIXcpci}/regions`

######################################################
# include domain specific resources such as legend etc.
. ${FIXcpci}/domain_resources_file
######################################################

#
day3_scl="2;5;10;15;20;25;30;40;60;80;100;125;150;200"
day5_scl="5;10;15;20;25;30;40;60;80;100;125;150;200;250"
week1_scl="10;15;20;25;30;40;60;80;100;125;150;200;250;300"
week2_scl="10;15;20;25;30;40;60;80;100;125;150;200;250;300"
#
# TEXT     = 1./2/2/SW
#-----------------------------------------------------
for pday in day3 day5 ; do
pd=${pday}_scl
pdscl=${!pd}
#---------------
if [[ ${pday} = "day3" ]];
then
upd=`$NDATE +72 ${PDY}${cyc}`
dayp="3day"
gdtm=F72
gdpfn=p72m
fi
#
if [[ ${pday} = "day5" ]];
then
upd=`$NDATE +120 ${PDY}${cyc}`
dayp="5day"
gdtm=F120
gdpfn=p120m
fi
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
ofile=gfs.${cycle}.totp.${pday}.${rgn}.gif
#
export MODEL_GFS=$DATA
gdplot3 << EOF2

GDFILE   = GFS
GDATTIM  = $gdtm
GLEVEL   = 0
GVCORD   = none
PANEL    = 0
SKIP     = 0
SCALE    = 0
GDPFUN   = ${gdpfn}
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
TITLE    = 1/-3/NOAA GFS ${PDY} ${cycle} cycle FCST ${dayp} Total Precip (mm)   VALID ${upd}Z
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
#
echo "*******"
echo "Completed" $rgn $pday
echo "*******"
#
cp ${ofile} $COMOUT/
done
done
#

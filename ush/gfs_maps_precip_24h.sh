#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gfs_maps_cape_6hrly.sh
#
# RFC Contact:
#
# Abstract:
# This script generates the GFS 24h Total Precip maps (gif format) from the GFS Forecast data
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
#
#

######################################################
# include domain specific resources such as legend etc.
. ${FIXcpci}/domain_resources_file
######################################################

#
pdscl="2;5;10;15;20;25;30;35;40;50;60;80;100;125"
#
# TEXT     = 1./2/2/SW
#-----------------------------------------------------
#for pday in d1 d2 d3 d4 d5 d6 d7 ; do
dys=$2
for pday in $dys ; do
#---------------
if [[ ${pday} = "d1" ]];
then
upd=`$NDATE +24 ${PDY}${cyc}`
dayp="day1"
gdtm=F24
gdpfn=p24m
fi
#
if [[ ${pday} = "d2" ]];
then
upd=`$NDATE +48 ${PDY}${cyc}`
dayp="day2"
gdtm=F48
gdpfn="sub(p48m,p24m^F24)"
fi
#
if [[ ${pday} = "d3" ]];
then
upd=`$NDATE +72 ${PDY}${cyc}`
dayp="day3"
gdtm=F72
gdpfn="sub(p72m,p48m^F48)"
fi
#
if [[ ${pday} = "d4" ]];
then
upd=`$NDATE +96 ${PDY}${cyc}`
dayp="day4"
gdtm=F96
gdpfn="sub(p96m,p72m^F72)"
fi
#
if [[ ${pday} = "d5" ]];
then
upd=`$NDATE +120 ${PDY}${cyc}`
dayp="day5"
gdtm=F120
gdpfn="sub(p120m,p96m^F96)"
fi
#
if [[ ${pday} = "d6" ]];
then
upd=`$NDATE +144 ${PDY}${cyc}`
dayp="day6"
gdtm=F144
gdpfn="sub(p144m,p120m^F120)"
fi
#
if [[ ${pday} = "d7" ]];
then
upd=`$NDATE +168 ${PDY}${cyc}`
dayp="day7"
gdtm=F168
gdpfn="sub(p168m,p144m^F144)"
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
#
ofile=gfs.${cycle}.24h_totp.${pday}.${rgn}.gif
gdplot3 << EOF2

GDFILE   = GFS
GDATTIM  = $gdtm
GLEVEL   = 0
GVCORD   = none
PANEL    = 0
SKIP     = 0
SCALE    = 0
GDPFUN   = $gdpfn
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
TITLE    = 1/-3/NOAA GFS ${PDY} ${cycle}cyc FCST ${dayp} 24h Total Precip (mm)   VALID ${upd}Z
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
echo "Completed" $rgn $pday
echo "*******"
#
cp ${ofile} $COMOUT/
done
done
#

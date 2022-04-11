#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gfs_maps_days_3_5_7_tmp2m.sh
#
# RFC Contact:
#
# Abstract:
# This script generates the GFS 2m Temp maps (gif format) from the GFS Forecast data files
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
#Variables passed as arguments from exec script
task=$1
task_dir=$DATA/$task
mkdir -p $task_dir
cd $task_dir
#-----------------------------------------------------
#
cp ${FIXcpci}/gfs_temp_coltbl.xwp coltbl.xwp
#
ymd1=`echo $PDY | cut -c 3-`
ymdh=${PDY}${cyc}
regions=`cat ${FIXcpci}/regions`
#=====================================================

######################################################
# include domain specific resources such as legend etc.
. ${FIXcpci}/domain_resources_file
######################################################

#
# TEXT     = 1./2/2/SW
#-----------------------------------------------------
for pday in d1 d2 d3 d4 d5 d6 d7 day3 day5 day7 ; do
#---------------
if [[ ${pday} = "day3" ]];
then
upd=`$NDATE +72 $ymdh`
dayp="3day"
gdtm=${ymd1}/${cyc}00F072
gdpfn1=tmxk72
gdpfn2=tmnk72
fi
#
if [[ ${pday} = "day5" ]];
then
upd=`$NDATE +120 $ymdh`
dayp="5day"
gdtm=${ymd1}/${cyc}00F120
gdpfn1=tmxk120
gdpfn2=tmnk120
fi
#
if [[ ${pday} = "day7" ]];
then
upd=`$NDATE +168 $ymdh`
dayp="7day"
gdtm=${ymd1}/${cyc}00F168
gdpfn1=tmxk168
gdpfn2=tmnk168
fi
#---------------
if [[ ${pday} = "d1" ]];
then
upd=`$NDATE +24 ${PDY}${cyc}`
dayp="day1"
gdtm=${ymd1}/${cyc}00F024
gdpfn1=tmxk24
gdpfn2=tmnk24
fi
#
if [[ ${pday} = "d2" ]];
then
upd=`$NDATE +48 ${PDY}${cyc}`
dayp="day2"
gdtm=${ymd1}/${cyc}00F048
gdpfn1=tmxk24
gdpfn2=tmnk24
fi
#
if [[ ${pday} = "d3" ]];
then
upd=`$NDATE +72 ${PDY}${cyc}`
dayp="day3"
gdtm=${ymd1}/${cyc}00F072
gdpfn1=tmxk24
gdpfn2=tmnk24
fi
#
if [[ ${pday} = "d4" ]];
then
upd=`$NDATE +96 ${PDY}${cyc}`
dayp="day4"
gdtm=${ymd1}/${cyc}00F096
gdpfn1=tmxk24
gdpfn2=tmnk24
fi
#
if [[ ${pday} = "d5" ]];
then
upd=`$NDATE +120 ${PDY}${cyc}`
dayp="day5"
gdtm=${ymd1}/${cyc}00F120
gdpfn1=tmxk24
gdpfn2=tmnk24
fi
#
if [[ ${pday} = "d6" ]];
then
upd=`$NDATE +144 ${PDY}${cyc}`
dayp="day6"
gdtm=${ymd1}/${cyc}00F144
gdpfn1=tmxk24
gdpfn2=tmnk24
fi
#
if [[ ${pday} = "d7" ]];
then
upd=`$NDATE +168 ${PDY}${cyc}`
dayp="day7"
gdtm=${ymd1}/${cyc}00F168
gdpfn1=tmxk24
gdpfn2=tmnk24
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
ofile1=gfs.${cycle}.tmax2m.${pday}.${rgn}.gif
ofile2=gfs.${cycle}.tmin2m.${pday}.${rgn}.gif
#
gdplot3 << EOF2

GDFILE   = ${DATA}/${pday}_tmax2m.grd
GDATTIM  = ${gdtm}
GLEVEL   = 2
GVCORD   = hght
PANEL    = 0
SKIP     = 0
SCALE    = 0
GDPFUN   = sub($gdpfn1,273.15)
TYPE     = f
CONTUR   = 3/3
CINT     = 0
LINE     = 2/1/2
FINT     = -15;-10;0;4;8;12;16;20;24;28;30;32;34;36;40;42
FLINE    = 28;27;26;25;24;22;20;15;13;11;3-10
HILO     =
HLSYM    =
CLRBAR   = ${cbar}
WIND     =
TITLE    = 1/-3/NOAA GFS ${PDY} ${cycle} cycle FCST ${dayp} 2m Maximum Temp (decC)   VALID ${upd}Z
TEXT     = 1./1/1/SW
CLEAR    = n
GAREA    = ${south};${west};${north};${east}
IJSKIP   = 0
PROJ     = ced/0;0;0
MAP      = 1/1/2
MSCALE   =
LATLON   = ${latln}
MARKER   =
DEVICE  = gif|${ofile1}|960;720|C
LUTFIL   =
POSN     =
COLORS   =
GRDLBL   =
FILTER   =
BOXLIN   = 1/1/1
REGION   = plot


r
 
CLEAR    = yes
GDFILE   = ${DATA}/${pday}_tmin2m.grd
GDPFUN   = sub(${gdpfn2},273.15)
TITLE    = 1/-3/NOAA GFS ${PDY} ${cycle} cycle FCST ${dayp} 2m Minimum Temp (decC)   VALID ${upd}Z
DEVICE  = gif|${ofile2}|960;720|C

r

exit

EOF2

gpend
#

#
echo "*******"
echo "Completed" $rgn $pday
echo "*******"
# exit
#
cp ${ofile1} ${ofile2} $COMOUT/
done
done
#

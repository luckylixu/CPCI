#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gfs_maps_dewpt2m_6hrly.sh
#
# RFC Contact:
#
# Abstract:
# This script generates the max. 2m DewPoint Temp maps (gif format) from the GFS Forecast data 
#
# Input Data Source: GFS  /com/nawips/prod/gfs.yyyymmdd/
#
# Output Destination: COMOUT /com/cpci/prod/gfs.yyyymmdd
#
# Software Package Used: GEMPAK
#
# Script History Log: First Implemented January 2016
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
cp ${FIXcpci}/gfs_temp_coltbl.xwp coltbl.xwp
#
regions=`cat ${FIXcpci}/regions`
echo $regions
#

######################################################
# include domain specific resources such as legend etc.
. ${FIXcpci}/domain_resources_file
######################################################

#
pdscl="-15;-10;0;4;8;12;16;20;24;28;30;32;34;36;40;42"
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
echo $latln
# 
south=`cut -f 1 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
north=`cut -f 2 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
west=`cut -f 3 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
east=`cut -f 4 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
echo
echo $south $north $west $east
#
fch=f$fh
gemfile=${DATA}/gfs_0p25_${PDY}${cyc}${fch}
echo $gemfile
#
#FINT     = -15;-10;0;4;8;12;16;20;24;28;30;32;34;36;40;42
#
ofile=gfs.${cycle}.dewpc2m.f${fh}.${rgn}.gif
#
gdplot3 << EOF2

GDFILE   = $gemfile
GDATTIM  = $fch
GLEVEL   = 2
GVCORD   = hght
PANEL    = 0
SKIP     = 0
SCALE    = 0
GDPFUN   = dwpc
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
TITLE    = 1/-3/NOAA GFS ${PDY} ${cycle}CYC ${fh}FCST 6h 2m DewPoint Temp (degC)   VALID 20~
TEXT     = 1./1/1/SW
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
BOXLIN   = 1/1/1
REGION   = plot

r

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
#
done
done

#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gfs_maps_cape_6hrly.sh
#
# RFC Contact:
#
# Abstract:
# This script generates the pr.level Temp maps (gif format) from the GFS Forecast data
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
# April-24-2017 Modified Vadlamani Kumar for pressure level specific ranges for legend (color bar)
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
lvl=$5
task=$6
task_dir=$DATA/$task
mkdir -p $task_dir
cd $task_dir
#-----------------------------------------------------
#
cp ${FIXcpci}/gfs_liftx_coltbl.xwp coltbl.xwp
#
regions=`cat ${FIXcpci}/regions`
#

######################################################
# include domain specific resources such as legend etc.
. ${FIXcpci}/domain_resources_file
######################################################

#
pdscl="28;27;26;25;24;22;20;15;13;12;4-11"
#
######################################################


######################################################
for lvl in $lvl ; do
#
case "$lvl" in
  925)
      fintr="-15;-10;0;4;8;12;16;20;24;28;30;32;34;36;40;42"
      ;;
  850)
      fintr="-15;-10;0;4;8;12;16;20;24;28;30;32;34;36;40;42"
      ;;
  700) 
      fintr="-10;-8;-6;-4;-2;0;2;4;6;8;10;12;15;20"
      ;;
  500)
      fintr="-20;-18;-15;-12;-10;-8;-6;-4;-2;0;2;5"
      ;;
  300)
      fintr="-60;-55;-50;-45;-42;-40;-38;-36;-34;-32;-30;-28;-25"
      ;;
  200)
      fintr="-70;-65;-62;-60;-58;-56;-54;-52;-50;-45;-40;-35"
      ;;
    *)
      echo "This Level is not part of the current process .. exiting"
      exit
      ;;
esac
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
ofile=gfs.${cycle}.${lvl}mb_tmp.f${fh}.${rgn}.gif
#
#
#
gdplot3 << EOF2

GDFILE   = $gemfile
GDATTIM  = $fch
GLEVEL   = ${lvl}
GVCORD   = pres
PANEL    = 0
SKIP     = 0
SCALE    = 0
GDPFUN   = sub(tmpk,273.15)
TYPE     = f
CONTUR   = 3/3
CINT     = 0
LINE     = 2/1/2
FINT     = ${fintr}
FLINE    = ${pdscl}
HILO     =
HLSYM    =
CLRBAR   = ${cbar}
WIND     =
TITLE    = 1/-3/NOAA GFS ${PDY} ${cycle}CYC ${fh}FCST 6h ${lvl}mb Mean Air Temp (degC)   VALID 20~
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
exit
EOF2

gpend
#

echo "*******"
echo "Completed" $rgn $fh
echo "*******"
#
cp ${ofile} $COMOUT/
done
done
done
#

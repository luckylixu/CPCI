#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gdas_maps_cape_6hrly.sh
#
# RFC Contact:
#
# Abstract:
# This script generates the Pr.Level Heights maps (gif format) from the GDAS Forecast data
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
#
#Variables passed as arguments from exec script
lvl=$1
task=$2
task_dir=$DATA/$task
mkdir -p $task_dir
cd $task_dir
rm *.gif
#-----------------------------------------------------
#
cp ${FIXcpci}/gdas_liftx_coltbl.xwp coltbl.xwp
#
regions=`cat ${FIXcpci}/regions`
#

######################################################
# include domain specific resources such as legend etc.
. ${FIXcpci}/domain_resources_file
#
######################################################
for lvl in $lvl ; do
cin925=30
cin850=40
cin700=80
cin500=80
cin300=120
cin200=150

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
pd="cin"$lvl
pdscl=${!pd}
#
skpx=6
skpy=6
if [ "$rgn" == "afghanistan" ]; then
  skpx=4
  skpy=4
fi
if [ "$rgn" == "indian" ]; then
  skpx=8
  skpy=8
fi
if [ "$rgn" == "pacific" ]; then
  skpx=8
  skpy=8
fi
if [ "$rgn" == "australia" ]; then
  skpx=8
  skpy=8
fi
if [ "$rgn" == "global" ]; then
  skpx=16
  skpy=16
fi
#
south=`cut -f 1 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
north=`cut -f 2 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
west=`cut -f 3 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
east=`cut -f 4 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
#
fch=f$fh
gemfile=${DATA}/gdas_0p25_${PDY}${cyc}${fch}
ofile=gdas.${cycle}.${lvl}mb_hghts.f${fh}.${rgn}.gif
#
gdplot3 << EOF2

GDFILE   = $gemfile
GDATTIM  = $fch
GLEVEL   = $lvl ! $lvl
GVCORD   = pres
PANEL    = 0
SKIP     = ! $skpx/$skpy !
SCALE    =    
GDPFUN   = hght ! wnd
TYPE     = f!a
CONTUR   = 1
CINT     =  
LINE     = 2/1/2
FINT     = $pdscl
FLINE    = 32;18-22;4-9
HILO     =  
HLSYM    =  
CLRBAR   = ${cbar}
WIND     = 0 ! am1/0.5/2//0.4
REFVEC   = 10
TITLE    = 1/-3/NOAA GDAS ${PDY} ${cycle}CYC ${fh}FCST ${lvl}mb Heights and Wind Vectors  VALID 20~
TEXT     = 1./1/1/HW
CLEAR    = n
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
echo "*******"
echo "Completed" $rgn $fh
echo "*******"
cp ${ofile} $COMOUT/
#
done
done
#

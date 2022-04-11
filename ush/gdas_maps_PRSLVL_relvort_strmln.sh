#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gdas_maps_cape_6hrly.sh
#
# RFC Contact:
#
# Abstract:
# This script generates the relVort/Streamline maps (gif format) from the GDAS Forecast data
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
#-----------------------------------------------------
#
cp ${FIXcpci}/gdas_vort_coltbl.xwp coltbl.xwp
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
######################################################
for lvl in $lvl ; do

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
strm=${rgn}_strm
strd=${!strm}
# 
south=`cut -f 1 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
north=`cut -f 2 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
west=`cut -f 3 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
east=`cut -f 4 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
#
fch=f$fh
gemfile=${DATA}/gdas_0p25_${PDY}${cyc}${fch}
ofile=gdas.${cycle}.${lvl}mb_rvort.f${fh}.${rgn}.gif
#
gdplot3 << EOF2

GDFILE   = $gemfile
GDATTIM  = $fch
GLEVEL   = $lvl  ! $lvl
GVCORD   = pres
PANEL    = 0
SKIP     =  
SCALE    =   5              ! 0 
GDPFUN   = vor(wnd)!wnd
TYPE     = f!s 
CONTUR   = 1
CINT     =  
LINE     =    ! 1/1/1
FINT     = -10;-8;-6;-4;-2;-1;1;2;4;6;8;10
FLINE    = 25;23;22;21;20;19;32;4-9
HILO     =  
HLSYM    =  
CLRBAR   = ${cbar}
WIND     = 0 ! ! am31/0.2///0.5
REFVEC   = 2
TITLE    = 1/-3/NOAA GDAS ${PDY} ${cycle}CYC FCST ${lvl}mb REL.VORTICITY/STREAMLINES   VALID 20~
TEXT     = 1./1/1/HW
CLEAR    = n
GAREA    = ${south};${west};${north};${east}
IJSKIP   = 0 ! ! 1
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
STREAM   = $strd
WIND	 = an3////.75
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

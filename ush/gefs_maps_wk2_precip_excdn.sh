#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gefs_maps_wk2_precip_excdn.sh
#
# RFC Contact:
#
# Abstract:
# This script generates week2 precip prob maps from the GEFS Forecast data
#
# Input Data Source: GEFS  /com/nawips/prod/gefs.yyyymmdd/
#
# Output Destination: COMOUT /com/cpci/prod/gefs.yyyymmdd/
#
# Software Package Used: GEMPAK
#
# Script History Log: First Implemented May 2015
# Original Code Development Contact: Vadlamani Kumar, CPC, 301-683-3462
#
###########################################################################################
#!/bin/sh
#
#
#Variables passed as arguments from exec script
thr=$1
task=$2
task_dir=$DATA/$task
mkdir -p $task_dir
cd $task_dir
#-----------------------------------------------------
#
cp ${FIXcpci}/gfs_precip_coltbl.xwp coltbl.xwp
cp ${FIXcpci}/datatype.tbl datatype.tbl

#
regions=`cat ${FIXcpci}/regions`
#

######################################################
# include domain specific resources such as legend etc.
. ${FIXcpci}/domain_resources_file
######################################################

#

export MODEL_GEFS=$DATA
for thrs in $thr ; do
#
for rgn in $regions ; do
cb=${rgn}_cb
cbar=${!cb}
ltln=${rgn}_ltln
latln=${!ltln}
ofile=gefs.${cycle}.wk2_precip_tot_gt_${thrs}mm.${rgn}.gif
#
south=`cut -f 1 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
north=`cut -f 2 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
west=`cut -f 3 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
east=`cut -f 4 -d ' ' ${FIXcpci}/${rgn}_latlon_file`
#
pdscl="5;10;20;30;40;50;60;70;80;90;95"
gdplot2 << EOF2

GDFILE   = {GEFS}
GDATTIM  = f336
GLEVEL   = 0  
GVCORD   = none  
SCALE    = 2
GDPFUN   = ens_prob(gt(sub(p336m,p168m^F168),$thrs))  
TYPE     = f 
CONTUR   = 3/3
CINT     = 0
LINE     = 2/1/2
CLRBAR   = ${cbar}
FINT     = $pdscl  
FLINE    = 32;14-18;5-10  
DEVICE   = gif|${ofile}|960;720|C
GAREA    = ${south};${west};${north};${east}
IJSKIP   = 0
PROJ     = ced/0;0;0
TITLE    = 1/-3/NOAA GEFS $PDY 00zCYC FCST Probability of Week2 Precip > ${thrs}mm  VALID 20~
LATLON   = ${latln}
MAP      = 1/1/2
STNPLT   =
SATFIL   =
RADFIL   =
IMCBAR   =
LUTFIL   =
STREAM   =
POSN     =  0
COLORS   =  1
MARKER   =  0
GRDLBL   =  0
FILTER   =  
BOXLIN   =  1/1/2
REGION   =  plot

r

exit

EOF2

gpend

cp ${ofile} $COMOUT/
done
done
#
exit

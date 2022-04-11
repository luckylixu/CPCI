#### UNIX Script Documentation Block  ####################################################
#
# Script Name: gefs_maps_10m_windspd_excdn_6hrly.sh
#
# RFC Contact:
#
# Abstract:
# This script generates 6 hourly 10m wind speed prob maps from the GEFS Forecast data
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
#
#-----------------------------------------------------
#Global Variables from JJOB
inpdir=$DATA
outdir=$DATA
#
#Variables passed as arguments from exec script
fh1=$1
thr1=$2
thr2=$3
thr3=$4
thr4=$5
task=$6
task_dir=$outdir/$task
mkdir -p $task_dir
cd $task_dir
#-----------------------------------------------------
#
cp ${FIXcpci}/gfs_precip_coltbl.xwp coltbl.xwp
cp ${FIXcpci}/datatype.tbl datatype.tbl
#
regions=`cat ${FIXcpci}/regions`
echo $regions
#

######################################################
# include domain specific resources such as legend etc.
. ${FIXcpci}/domain_resources_file
######################################################

#
export MODEL_GEFS=$inpdir
#
for fh in 024 ; do
# for fh in $fh1 ; do
for thrs in 2 3 ; do
# for thrs in ${thr1} ${thr2} ${thr3} ${thr4} ; do
#
for rgn in global ; do
# for rgn in $regions ; do
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
ofile=gwes.${cycle}.prob_wave_hgt_gt_${thrs}m.${fch}.${rgn}.gif
pdscl="5;10;20;30;40;50;60;70;80;90;95"
gdplot2 << EOF2

GDFILE   = {GWES}
GDATTIM  = $fch
GLEVEL   = 0  
GVCORD   = none  
SCALE    = 2
GDPFUN   = ens_prob(gt(wvhgt,$thrs))  
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
TITLE    = 1/-3/NOAA GEFS $PDY ${cycle}CYC $fch FCST Prob 10m windspd > ${thrs}kts  VALID 20~
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

EOF2

gpend

#
echo "*******"
echo "Completed" $rgn $fh
echo "*******"
#

# cp $ofile $COMOUT/

done
done
done
#
exit

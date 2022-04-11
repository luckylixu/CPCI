#!/bin/sh
#### UNIX Script Documentation Block  ##########################################
#
# Script Name: gfs_process_all_grib2_to_grd.sh
#
# RFC Contact:
#
# Abstract:
# This script reads the GFS grib2 data files and creates the aggregated output
# file (sum or mean) and converts the output grib2 files to Gempak GRD files
# using the embedded Gempak scripts
#
# Script History Log: First Implemented November 2014
# Original Code Developer: Vadlamani Kumar
#
# Usage: gfs_process_all_grib2_to_grd.sh $PDY $cyc $COMIN $gfsdir
# Script Parameters:
# Modules and Files referenced: gempak ibmpe lsf
# scripts:
# parms:
# fix: none
# executables: <compiled code this script calls>
#
# Condition codes:
# < list any exit condition or error codes the script returns if
# any >
# If appropriate, descriptive troubleshooting instructions or
# likely causes for failures could be mentioned here with the
# appropriate error code
#
# User controllable options: <if applicable>
#
# Attributes:
# Language: RedHat Linux
# Machine: NCEP WCOSS
#################################################################################
#
#
# define the usage function
#
#
cd $DATA
rm *.grb2 *.nts
#
gfsdir=$COMIN
#********************************************************************
#
# day7 total tmax2mip
#
cat $gfsdir/gfs.t${cyc}z.master.grb2f06 \
    $gfsdir/gfs.t${cyc}z.master.grb2f12 \
    $gfsdir/gfs.t${cyc}z.master.grb2f18 \
    $gfsdir/gfs.t${cyc}z.master.grb2f24 \
    $gfsdir/gfs.t${cyc}z.master.grb2f30 \
    $gfsdir/gfs.t${cyc}z.master.grb2f36 \
    $gfsdir/gfs.t${cyc}z.master.grb2f42 \
    $gfsdir/gfs.t${cyc}z.master.grb2f48 \
    $gfsdir/gfs.t${cyc}z.master.grb2f54 \
    $gfsdir/gfs.t${cyc}z.master.grb2f60 \
    $gfsdir/gfs.t${cyc}z.master.grb2f66 \
    $gfsdir/gfs.t${cyc}z.master.grb2f72 \
    $gfsdir/gfs.t${cyc}z.master.grb2f78 \
    $gfsdir/gfs.t${cyc}z.master.grb2f84 \
    $gfsdir/gfs.t${cyc}z.master.grb2f90 \
    $gfsdir/gfs.t${cyc}z.master.grb2f96 \
    $gfsdir/gfs.t${cyc}z.master.grb2f102 \
    $gfsdir/gfs.t${cyc}z.master.grb2f108 \
    $gfsdir/gfs.t${cyc}z.master.grb2f114 \
    $gfsdir/gfs.t${cyc}z.master.grb2f120 \
    $gfsdir/gfs.t${cyc}z.master.grb2f126 \
    $gfsdir/gfs.t${cyc}z.master.grb2f132 \
    $gfsdir/gfs.t${cyc}z.master.grb2f138 \
    $gfsdir/gfs.t${cyc}z.master.grb2f144 \
    $gfsdir/gfs.t${cyc}z.master.grb2f150 \
    $gfsdir/gfs.t${cyc}z.master.grb2f156 \
    $gfsdir/gfs.t${cyc}z.master.grb2f162 \
    $gfsdir/gfs.t${cyc}z.master.grb2f168 \
  | $WGRIB2 - -match TMAX -merge_fcst 28 temp.grb2
#
$WGRIB2 temp.grb2 -match ":TMAX:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 day7_tmax2m.grb2 
#------------------------------------------------
rm temp.grb2
#
# day5 total tmax2mip
#
cat $gfsdir/gfs.t${cyc}z.master.grb2f06 \
    $gfsdir/gfs.t${cyc}z.master.grb2f12 \
    $gfsdir/gfs.t${cyc}z.master.grb2f18 \
    $gfsdir/gfs.t${cyc}z.master.grb2f24 \
    $gfsdir/gfs.t${cyc}z.master.grb2f30 \
    $gfsdir/gfs.t${cyc}z.master.grb2f36 \
    $gfsdir/gfs.t${cyc}z.master.grb2f42 \
    $gfsdir/gfs.t${cyc}z.master.grb2f48 \
    $gfsdir/gfs.t${cyc}z.master.grb2f54 \
    $gfsdir/gfs.t${cyc}z.master.grb2f60 \
    $gfsdir/gfs.t${cyc}z.master.grb2f66 \
    $gfsdir/gfs.t${cyc}z.master.grb2f72 \
    $gfsdir/gfs.t${cyc}z.master.grb2f78 \
    $gfsdir/gfs.t${cyc}z.master.grb2f84 \
    $gfsdir/gfs.t${cyc}z.master.grb2f90 \
    $gfsdir/gfs.t${cyc}z.master.grb2f96 \
    $gfsdir/gfs.t${cyc}z.master.grb2f102 \
    $gfsdir/gfs.t${cyc}z.master.grb2f108 \
    $gfsdir/gfs.t${cyc}z.master.grb2f114 \
    $gfsdir/gfs.t${cyc}z.master.grb2f120 \
  | $WGRIB2 - -match TMAX -merge_fcst 20 temp.grb2
#
$WGRIB2 temp.grb2 -match ":TMAX:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 day5_tmax2m.grb2
#------------------------------------------------
rm temp.grb2
#
# day3 total tmax2mip
#
cat $gfsdir/gfs.t${cyc}z.master.grb2f06 \
    $gfsdir/gfs.t${cyc}z.master.grb2f12 \
    $gfsdir/gfs.t${cyc}z.master.grb2f18 \
    $gfsdir/gfs.t${cyc}z.master.grb2f24 \
    $gfsdir/gfs.t${cyc}z.master.grb2f30 \
    $gfsdir/gfs.t${cyc}z.master.grb2f36 \
    $gfsdir/gfs.t${cyc}z.master.grb2f42 \
    $gfsdir/gfs.t${cyc}z.master.grb2f48 \
    $gfsdir/gfs.t${cyc}z.master.grb2f54 \
    $gfsdir/gfs.t${cyc}z.master.grb2f60 \
    $gfsdir/gfs.t${cyc}z.master.grb2f66 \
    $gfsdir/gfs.t${cyc}z.master.grb2f72 \
  | $WGRIB2 - -match TMAX -merge_fcst 12 temp.grb2
#
$WGRIB2 temp.grb2 -match ":TMAX:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 day3_tmax2m.grb2
#
#------------------------------------------------
rm temp.grb2
# 24hour total tmax2mip
#
cat $gfsdir/gfs.t${cyc}z.master.grb2f06 \
    $gfsdir/gfs.t${cyc}z.master.grb2f12 \
    $gfsdir/gfs.t${cyc}z.master.grb2f18 \
    $gfsdir/gfs.t${cyc}z.master.grb2f24 \
  | $WGRIB2 - -match TMAX -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMAX:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d1_tmax2m.grb2

cat $gfsdir/gfs.t${cyc}z.master.grb2f30 \
    $gfsdir/gfs.t${cyc}z.master.grb2f36 \
    $gfsdir/gfs.t${cyc}z.master.grb2f42 \
    $gfsdir/gfs.t${cyc}z.master.grb2f48 \
  | $WGRIB2 - -match TMAX -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMAX:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d2_tmax2m.grb2

cat $gfsdir/gfs.t${cyc}z.master.grb2f54 \
    $gfsdir/gfs.t${cyc}z.master.grb2f60 \
    $gfsdir/gfs.t${cyc}z.master.grb2f66 \
    $gfsdir/gfs.t${cyc}z.master.grb2f72 \
  | $WGRIB2 - -match TMAX -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMAX:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d3_tmax2m.grb2

cat $gfsdir/gfs.t${cyc}z.master.grb2f78 \
    $gfsdir/gfs.t${cyc}z.master.grb2f84 \
    $gfsdir/gfs.t${cyc}z.master.grb2f90 \
    $gfsdir/gfs.t${cyc}z.master.grb2f96 \
  | $WGRIB2 - -match TMAX -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMAX:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d4_tmax2m.grb2

cat $gfsdir/gfs.t${cyc}z.master.grb2f102 \
    $gfsdir/gfs.t${cyc}z.master.grb2f108 \
    $gfsdir/gfs.t${cyc}z.master.grb2f114 \
    $gfsdir/gfs.t${cyc}z.master.grb2f120 \
  | $WGRIB2 - -match TMAX -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMAX:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d5_tmax2m.grb2

cat $gfsdir/gfs.t${cyc}z.master.grb2f126 \
    $gfsdir/gfs.t${cyc}z.master.grb2f132 \
    $gfsdir/gfs.t${cyc}z.master.grb2f138 \
    $gfsdir/gfs.t${cyc}z.master.grb2f144 \
  | $WGRIB2 - -match TMAX -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMAX:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d6_tmax2m.grb2

cat $gfsdir/gfs.t${cyc}z.master.grb2f150 \
    $gfsdir/gfs.t${cyc}z.master.grb2f156 \
    $gfsdir/gfs.t${cyc}z.master.grb2f162 \
    $gfsdir/gfs.t${cyc}z.master.grb2f168 \
  | $WGRIB2 - -match TMAX -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMAX:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d7_tmax2m.grb2
#
#------------------------------------------------
#
nagrib2 << EOF2
	GBFILE   =  day7_tmax2m.grb2
	GDOUTF   =  day7_tmax2m.grd
	PROJ     =  ced/0;0;0
	GRDAREA  =  -90.;0.;90.;-0.5
	KXKY     =  720;361
	MAXGRD   =  3000
	CPYFIL   =  
	GAREA    =  grid
	OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
error=$?

if  [ $error == 0 ]; then
  ls day7_tmax2m.grd
   error=$?
fi

#
#
nagrib2 << EOF2
        GBFILE   =  day5_tmax2m.grb2
        GDOUTF   =  day5_tmax2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
error=$?

if  [ $error == 0 ]; then
  ls day5_tmax2m.grd
   error=$?
fi

#
#
nagrib2 << EOF2
        GBFILE   =  day3_tmax2m.grb2
        GDOUTF   =  day3_tmax2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
error=$?

if  [ $error == 0 ]; then
  ls day3_tmax2m.grd
   error=$?
fi

#
#
nagrib2 << EOF2
        GBFILE   =  d1_tmax2m.grb2
        GDOUTF   =  d1_tmax2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
error=$?

if  [ $error == 0 ]; then
  ls d1_tmax2m.grd
   error=$?
fi

#
#

nagrib2 << EOF2
        GBFILE   =  d2_tmax2m.grb2
        GDOUTF   =  d2_tmax2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
error=$?

if  [ $error == 0 ]; then
  ls d2_tmax2m.grd
   error=$?
fi

#
#
nagrib2 << EOF2
        GBFILE   =  d3_tmax2m.grb2
        GDOUTF   =  d3_tmax2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
error=$?

if  [ $error == 0 ]; then
  ls d3_tmax2m.grd
   error=$?
fi

#
#
nagrib2 << EOF2
        GBFILE   =  d4_tmax2m.grb2
        GDOUTF   =  d4_tmax2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
error=$?

if  [ $error == 0 ]; then
  ls d4_tmax2m.grd
   error=$?
fi

#
#

nagrib2 << EOF2
        GBFILE   =  d5_tmax2m.grb2
        GDOUTF   =  d5_tmax2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
error=$?

if  [ $error == 0 ]; then
  ls d5_tmax2m.grd
   error=$?
fi

#
#
nagrib2 << EOF2
        GBFILE   =  d6_tmax2m.grb2
        GDOUTF   =  d6_tmax2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
error=$?

if  [ $error == 0 ]; then
  ls d6_tmax2m.grd
   error=$?
fi

#
#
nagrib2 << EOF2
        GBFILE   =  d7_tmax2m.grb2
        GDOUTF   =  d7_tmax2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
error=$?

if  [ $error == 0 ]; then
  ls d7_tmax2m.grd
   error=$?
fi

#

gpend
#

rm *.grb2 *.nts
#*******************************************************************************
#
# day7 total tmin2mip
#
cat $gfsdir/gfs.t${cyc}z.master.grb2f06 \
    $gfsdir/gfs.t${cyc}z.master.grb2f12 \
    $gfsdir/gfs.t${cyc}z.master.grb2f18 \
    $gfsdir/gfs.t${cyc}z.master.grb2f24 \
    $gfsdir/gfs.t${cyc}z.master.grb2f30 \
    $gfsdir/gfs.t${cyc}z.master.grb2f36 \
    $gfsdir/gfs.t${cyc}z.master.grb2f42 \
    $gfsdir/gfs.t${cyc}z.master.grb2f48 \
    $gfsdir/gfs.t${cyc}z.master.grb2f54 \
    $gfsdir/gfs.t${cyc}z.master.grb2f60 \
    $gfsdir/gfs.t${cyc}z.master.grb2f66 \
    $gfsdir/gfs.t${cyc}z.master.grb2f72 \
    $gfsdir/gfs.t${cyc}z.master.grb2f78 \
    $gfsdir/gfs.t${cyc}z.master.grb2f84 \
    $gfsdir/gfs.t${cyc}z.master.grb2f90 \
    $gfsdir/gfs.t${cyc}z.master.grb2f96 \
    $gfsdir/gfs.t${cyc}z.master.grb2f102 \
    $gfsdir/gfs.t${cyc}z.master.grb2f108 \
    $gfsdir/gfs.t${cyc}z.master.grb2f114 \
    $gfsdir/gfs.t${cyc}z.master.grb2f120 \
    $gfsdir/gfs.t${cyc}z.master.grb2f126 \
    $gfsdir/gfs.t${cyc}z.master.grb2f132 \
    $gfsdir/gfs.t${cyc}z.master.grb2f138 \
    $gfsdir/gfs.t${cyc}z.master.grb2f144 \
    $gfsdir/gfs.t${cyc}z.master.grb2f150 \
    $gfsdir/gfs.t${cyc}z.master.grb2f156 \
    $gfsdir/gfs.t${cyc}z.master.grb2f162 \
    $gfsdir/gfs.t${cyc}z.master.grb2f168 \
  | $WGRIB2 - -match TMIN -merge_fcst 28 temp.grb2
#
$WGRIB2 temp.grb2 -match ":TMIN:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 day7_tmin2m.grb2 
#------------------------------------------------
rm temp.grb2
#
# day5 total tmin2mip
#
cat $gfsdir/gfs.t${cyc}z.master.grb2f06 \
    $gfsdir/gfs.t${cyc}z.master.grb2f12 \
    $gfsdir/gfs.t${cyc}z.master.grb2f18 \
    $gfsdir/gfs.t${cyc}z.master.grb2f24 \
    $gfsdir/gfs.t${cyc}z.master.grb2f30 \
    $gfsdir/gfs.t${cyc}z.master.grb2f36 \
    $gfsdir/gfs.t${cyc}z.master.grb2f42 \
    $gfsdir/gfs.t${cyc}z.master.grb2f48 \
    $gfsdir/gfs.t${cyc}z.master.grb2f54 \
    $gfsdir/gfs.t${cyc}z.master.grb2f60 \
    $gfsdir/gfs.t${cyc}z.master.grb2f66 \
    $gfsdir/gfs.t${cyc}z.master.grb2f72 \
    $gfsdir/gfs.t${cyc}z.master.grb2f78 \
    $gfsdir/gfs.t${cyc}z.master.grb2f84 \
    $gfsdir/gfs.t${cyc}z.master.grb2f90 \
    $gfsdir/gfs.t${cyc}z.master.grb2f96 \
    $gfsdir/gfs.t${cyc}z.master.grb2f102 \
    $gfsdir/gfs.t${cyc}z.master.grb2f108 \
    $gfsdir/gfs.t${cyc}z.master.grb2f114 \
    $gfsdir/gfs.t${cyc}z.master.grb2f120 \
  | $WGRIB2 - -match TMIN -merge_fcst 20 temp.grb2
#
$WGRIB2 temp.grb2 -match ":TMIN:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 day5_tmin2m.grb2
#------------------------------------------------
rm temp.grb2
#
# day3 total tmin2mip
#
cat $gfsdir/gfs.t${cyc}z.master.grb2f06 \
    $gfsdir/gfs.t${cyc}z.master.grb2f12 \
    $gfsdir/gfs.t${cyc}z.master.grb2f18 \
    $gfsdir/gfs.t${cyc}z.master.grb2f24 \
    $gfsdir/gfs.t${cyc}z.master.grb2f30 \
    $gfsdir/gfs.t${cyc}z.master.grb2f36 \
    $gfsdir/gfs.t${cyc}z.master.grb2f42 \
    $gfsdir/gfs.t${cyc}z.master.grb2f48 \
    $gfsdir/gfs.t${cyc}z.master.grb2f54 \
    $gfsdir/gfs.t${cyc}z.master.grb2f60 \
    $gfsdir/gfs.t${cyc}z.master.grb2f66 \
    $gfsdir/gfs.t${cyc}z.master.grb2f72 \
  | $WGRIB2 - -match TMIN -merge_fcst 12 temp.grb2
#
$WGRIB2 temp.grb2 -match ":TMIN:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 day3_tmin2m.grb2
#
#------------------------------------------------
rm temp.grb2
# 24hour total tmin2mip
#
cat $gfsdir/gfs.t${cyc}z.master.grb2f06 \
    $gfsdir/gfs.t${cyc}z.master.grb2f12 \
    $gfsdir/gfs.t${cyc}z.master.grb2f18 \
    $gfsdir/gfs.t${cyc}z.master.grb2f24 \
  | $WGRIB2 - -match TMIN -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMIN:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d1_tmin2m.grb2

cat $gfsdir/gfs.t${cyc}z.master.grb2f30 \
    $gfsdir/gfs.t${cyc}z.master.grb2f36 \
    $gfsdir/gfs.t${cyc}z.master.grb2f42 \
    $gfsdir/gfs.t${cyc}z.master.grb2f48 \
  | $WGRIB2 - -match TMIN -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMIN:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d2_tmin2m.grb2

cat $gfsdir/gfs.t${cyc}z.master.grb2f54 \
    $gfsdir/gfs.t${cyc}z.master.grb2f60 \
    $gfsdir/gfs.t${cyc}z.master.grb2f66 \
    $gfsdir/gfs.t${cyc}z.master.grb2f72 \
  | $WGRIB2 - -match TMIN -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMIN:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d3_tmin2m.grb2

cat $gfsdir/gfs.t${cyc}z.master.grb2f78 \
    $gfsdir/gfs.t${cyc}z.master.grb2f84 \
    $gfsdir/gfs.t${cyc}z.master.grb2f90 \
    $gfsdir/gfs.t${cyc}z.master.grb2f96 \
  | $WGRIB2 - -match TMIN -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMIN:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d4_tmin2m.grb2

cat $gfsdir/gfs.t${cyc}z.master.grb2f102 \
    $gfsdir/gfs.t${cyc}z.master.grb2f108 \
    $gfsdir/gfs.t${cyc}z.master.grb2f114 \
    $gfsdir/gfs.t${cyc}z.master.grb2f120 \
  | $WGRIB2 - -match TMIN -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMIN:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d5_tmin2m.grb2

cat $gfsdir/gfs.t${cyc}z.master.grb2f126 \
    $gfsdir/gfs.t${cyc}z.master.grb2f132 \
    $gfsdir/gfs.t${cyc}z.master.grb2f138 \
    $gfsdir/gfs.t${cyc}z.master.grb2f144 \
  | $WGRIB2 - -match TMIN -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMIN:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d6_tmin2m.grb2

cat $gfsdir/gfs.t${cyc}z.master.grb2f150 \
    $gfsdir/gfs.t${cyc}z.master.grb2f156 \
    $gfsdir/gfs.t${cyc}z.master.grb2f162 \
    $gfsdir/gfs.t${cyc}z.master.grb2f168 \
  | $WGRIB2 - -match TMIN -merge_fcst 4 temp.grb2
$WGRIB2 temp.grb2 -match ":TMIN:" -set_grib_type same -new_grid_winds earth -new_grid latlon 0:720:0.5  90:361:-0.5 d7_tmin2m.grb2
#
#------------------------------------------------
#
#
#
nagrib2 << EOF2
	GBFILE   =  day7_tmin2m.grb2
	GDOUTF   =  day7_tmin2m.grd
	PROJ     =  ced/0;0;0
	GRDAREA  =  -90.;0.;90.;-0.5
	KXKY     =  720;361
	MAXGRD   =  3000
	CPYFIL   =  
	GAREA    =  grid
	OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
error=$?

if  [ $error == 0 ]; then
  ls day7_tmin2m.grd
   error=$?
fi

#

nagrib2 << EOF2
        GBFILE   =  day5_tmin2m.grb2
        GDOUTF   =  day5_tmin2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
error=$?

if  [ $error == 0 ]; then
  ls day5_tmin2m.grd
   error=$?
fi

#
#
nagrib2 << EOF2
        GBFILE   =  day3_tmin2m.grb2
        GDOUTF   =  day3_tmin2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2


#
error=$?

if  [ $error == 0 ]; then
  ls day3_tmin2m.grd
   error=$?
fi

#
#
nagrib2 << EOF2
        GBFILE   =  d1_tmin2m.grb2
        GDOUTF   =  d1_tmin2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
#
error=$?

if  [ $error == 0 ]; then
  ls d1_tmin2m.grd
   error=$?
fi

#

nagrib2 << EOF2
        GBFILE   =  d2_tmin2m.grb2
        GDOUTF   =  d2_tmin2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
#
error=$?

if  [ $error == 0 ]; then
  ls d2_tmin2m.grd
   error=$?
fi

#
#
nagrib2 << EOF2
        GBFILE   =  d3_tmin2m.grb2
        GDOUTF   =  d3_tmin2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
#
error=$?

if  [ $error == 0 ]; then
  ls d3_tmin2m.grd
   error=$?
fi

#

#
nagrib2 << EOF2
        GBFILE   =  d4_tmin2m.grb2
        GDOUTF   =  d4_tmin2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
#
error=$?

if  [ $error == 0 ]; then
  ls d4_tmin2m.grd
   error=$?
fi

#

nagrib2 << EOF2
        GBFILE   =  d5_tmin2m.grb2
        GDOUTF   =  d5_tmin2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
#
error=$?

if  [ $error == 0 ]; then
  ls d5_tmin2m.grd
   error=$?
fi

#
nagrib2 << EOF2
        GBFILE   =  d6_tmin2m.grb2
        GDOUTF   =  d6_tmin2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2

#
#
error=$?

if  [ $error == 0 ]; then
  ls d6_tmin2m.grd
   error=$?
fi

#
nagrib2 << EOF2
        GBFILE   =  d7_tmin2m.grb2
        GDOUTF   =  d7_tmin2m.grd
        PROJ     =  ced/0;0;0
        GRDAREA  =  -90.;0.;90.;-0.5
        KXKY     =  720;361
        MAXGRD   =  3000
        CPYFIL   =
        GAREA    =  grid
        OUTPUT   =  t
        G2TBLS   =
        G2DIAG   =

r
exit
EOF2


gpend
#

#
error=$?

if  [ $error == 0 ]; then
  ls d7_tmin2m.grd
   error=$?
fi

rm *.grb2 *.nts

#!/bin/bash
#-- ----------------------------------------------------------------------
#--  Copyright (c) 2020, OPAS
#--   _____ _____ _____ _____
#--  |     |  _  |  _  |   __|
#--  |  |  |   __|     |__   |
#--  |_____|__|  |__|__|_____|
#--
#--  Author: Paolo Saudin.
#--  Script: get-iono-data.sh
#--  Purposes: get data from iono module
#--  Date : 2020-10-07 08:15
#-- ----------------------------------------------------------------------
# lock dir/file
BASEDIR=$(dirname $0)
SCRIPTFILE=$(basename $0)
LOCKFILE="${BASEDIR}/${SCRIPTFILE}.pid"
# script already running check
if [ -e $LOCKFILE ] && kill -0 cat $LOCKFILE
then
    echo "$SCRIPTFILE already running. Aborting."
    exit
fi
trap "rm -fv $LOCKFILE; exit" INT TERM EXIT

# ok to run
echo
echo "Running script -> $SCRIPTFILE @ $(date)"

#
# iono configuration
# iono 1wire bus -> gets ids 28-xxxxxxxxxxxx
# leave empty to skip reading
#
IONO_BUS1=
IONO_BUS2=

# path configuration
STAT_FILE="$HOME/di1.high"
DATA_FILE="$HOME/iono.csv"

# remove stat file id first run in the hour
minute="$(date +%M)"
if [[ minute -eq 0 && -e $STAT_FILE ]]
then
    rm $STAT_FILE
fi

# get values
echo "Get iono digital sensors status..."
# iono di1 -->> high | low & temp
[[ $(/usr/local/bin/iono di1) == "high" ]] && DI1=1 || DI1=0 # $(iono di1)
[[ $(/usr/local/bin/iono di2) == "high" ]] && DI2=1 || DI2=0 # $(iono di2)
[[ $(/usr/local/bin/iono di3) == "high" ]] && DI3=1 || DI3=0 # $(iono di3)
[[ $(/usr/local/bin/iono di4) == "high" ]] && DI4=1 || DI4=0 # $(iono di4)
[[ $(/usr/local/bin/iono di5) == "high" ]] && DI5=1 || DI5=0 # $(iono di5)
[[ $(/usr/local/bin/iono di6) == "high" ]] && DI6=1 || DI6=0 # $(iono di6)
# if we have a high value create tmp file
# di1 is open door
echo "Write di1 data into temp file if high"
if [[ $DI1 -eq 1 ]]
then
    touch $STAT_FILE
fi
# till stat file exists we set port open alarm
if [[ -e $STAT_FILE ]]
then
    DI1=1
fi
# print values
echo "DI1: $DI1"
echo "DI2: $DI2"
echo "DI3: $DI3"
echo "DI4: $DI4"
echo "DI5: $DI5"
echo "DI6: $DI6"

# get data
echo "Get iono 1wire sensors status..."
[[ $IONO_BUS1 == "" ]] && ONEWIRE1= || ONEWIRE1=$(/usr/local/bin/iono 1wire bus $IONO_BUS1)
[[ $IONO_BUS2 == "" ]] && ONEWIRE2= || ONEWIRE2=$(/usr/local/bin/iono 1wire bus $IONO_BUS2)
# print values
echo "ONEWIRE1: $ONEWIRE1"
echo "ONEWIRE2: $ONEWIRE2"
# replace dot with comma
ONEWIRE1=${ONEWIRE1/./,}

# create csv file
echo "Append data to pipe file..."
echo "$DI1;$DI2;$DI3;$DI4;$DI5;$DI6;$ONEWIRE1;$ONEWIRE2" > $DATA_FILE

exit 0
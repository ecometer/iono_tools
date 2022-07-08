#!/bin/bash
#-- ----------------------------------------------------------------------
#--  Copyright (c) 2022, OPAS
#--   _____ _____ _____ _____
#--  |     |  _  |  _  |   __|
#--  |  |  |   __|     |__   |
#--  |_____|__|  |__|__|_____|
#--
#--  Author: Paolo Saudin
#--  Script: get-iono-data.sh
#--  Purposes: get data from iono module (!!! file system READ ONLY !!!)
#--  Date : 2022-05-17 16:37
#-- ----------------------------------------------------------------------

# iono configuration
# iono 1wire bus -> gets ids 28-xxxxxxxxxxxx
# leave empty to skip reading
IONO_BUS1=28-012022e2ba8e

# get values
[[ $(/usr/local/bin/iono di1) == "high" ]] && DI1=1 || DI1=0 # $(iono di1)
[[ $(/usr/local/bin/iono di2) == "high" ]] && DI2=1 || DI2=0 # $(iono di2)
[[ $(/usr/local/bin/iono di3) == "high" ]] && DI3=1 || DI3=0 # $(iono di3)
[[ $(/usr/local/bin/iono di4) == "high" ]] && DI4=1 || DI4=0 # $(iono di4)
[[ $(/usr/local/bin/iono di5) == "high" ]] && DI5=1 || DI5=0 # $(iono di5)
[[ $(/usr/local/bin/iono di6) == "high" ]] && DI6=1 || DI6=0 # $(iono di6)

# get 1 wire data
# close contact
$(/usr/local/bin/iono o1 close) # o<n> close Close relay output o<n> (<n>=1..4)
sleep 1

# read the values
[[ $IONO_BUS1 == "" ]] && ONEWIRE1= || ONEWIRE1=$(/usr/local/bin/iono 1wire bus $IONO_BUS1)

# open contact
$(/usr/local/bin/iono o1 open) # o<n> open Open relay output o<n> (<n>=1..4)

# replace dot with comma
ONEWIRE1=${ONEWIRE1/./,}

# set new data
ONEW_DATA="$ONEWIRE1"

# append ';'..."
ONEW_DATA="$ONEW_DATA;"

# print data
echo "$DI1;$DI2;$DI3;$DI4;$DI5;$DI6;$ONEW_DATA"

exit 0

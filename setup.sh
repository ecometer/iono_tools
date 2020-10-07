#!/bin/bash

# run and execute
# wget -O - https://raw.githubusercontent.com/ecometer/iono_tools/main/setup.sh | bash
echo
echo
echo "*************  iono setup script *************"

# create need files
echo "creating authorized key file..."
AUTH_PATH="$HOME/.ssh"
AUTH_FILE="$HOME/.ssh/authorized_keys"
mkdir -p $AUTH_PATH
if [[ ! -f $AUTH_FILE ]]
then
    touch $AUTH_FILE
    chmod 600 $AUTH_FILE
fi

# get script
echo "getting script..."
wget -O $HOME/get-iono-data.sh https://raw.githubusercontent.com/ecometer/iono_tools/main/get-iono-data.sh
chmod +x $HOME/get-iono-data.sh

# add commands to crontab
echo "adding crontab job..."
CRONJOBS=$(cat <<-END
#
# get data from iono module every fife seconds
# to catch open door DI contact
#
* * * * * $HOME/get-iono-data.sh
* * * * * sleep  5; $HOME/get-iono-data.sh
* * * * * sleep 10; $HOME/get-iono-data.sh
* * * * * sleep 15; $HOME/get-iono-data.sh
* * * * * sleep 20; $HOME/get-iono-data.sh
* * * * * sleep 25; $HOME/get-iono-data.sh
* * * * * sleep 30; $HOME/get-iono-data.sh
* * * * * sleep 35; $HOME/get-iono-data.sh
* * * * * sleep 40; $HOME/get-iono-data.sh
* * * * * sleep 45; $HOME/get-iono-data.sh
* * * * * sleep 50; $HOME/get-iono-data.sh
* * * * * sleep 55; $HOME/get-iono-data.sh
END
)
# check if command already exists
if crontab -l | grep -q 'get-iono-data.sh'; then
    echo "cron jobs already exists"
else
    echo "adding cron jobs..."
    (crontab -u pi -l; echo "$CRONJOBS" ) | crontab -u pi -
fi

# end
echo "all done!"

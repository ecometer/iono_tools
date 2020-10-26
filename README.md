# iono_tools
Collection of script

run on rpi sferalabs
wget -O - https://raw.githubusercontent.com/ecometer/iono_tools/main/setup.sh | bash

windows
ssh-keygen
scp C:\Users\ARPAL/.ssh/id_rsa.pub pi@192.168.1.xxx:\home\pi\.ssh\authorized_keys

crontab
get iono sensors data
'* * * * * C:\OPAS-SUPPORT\Sferalabs\get_iono_data.bat

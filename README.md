# iono_tools
#### Collection of script

* run on rpi sferalabs
```bash
wget -O - https://raw.githubusercontent.com/ecometer/iono_tools/main/setup.sh | bash
```
* windows DOS
```bash
ssh-keygen
scp C:\Users\ARPAL/.ssh/id_rsa.pub pi@192.168.1.xxx:\home\pi\.ssh\authorized_keys
```
* crontab
```
# get iono sensors data
* * * * * C:\OPAS-SUPPORT\Sferalabs\get_iono_data.bat
```


# only update scripts
```bash
# Read-Write filesystem script
wget -O ~/get-iono-data.sh https://raw.githubusercontent.com/ecometer/iono_tools/main/get-iono-data.sh

# Read-Only filesystem script
wget -O ~/ro-get-iono-data.sh https://raw.githubusercontent.com/ecometer/iono_tools/main/ro-get-iono-data.sh
```

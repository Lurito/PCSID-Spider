#!/usr/bin/env bash

############################################################
# Usage:
#   chmod +x index.sh
#   ./index.sh <starting AppID> <ending AppID>
############################################################

# To get BDUSS by reading BaiduPCS-Go config file
BDUSS=`cat $HOME/.config/BaiduPCS-Go/pcs_config.json | egrep bduss | tail -c 195 | head -c 192`

for appid in $(seq $1 $2); do
    echo $appid # Can be deleted when need to run silently

    # To sent GET request to test if the AppID avaliable
    status=`curl --cookie "BDUSS=${BDUSS}" -I -o /dev/null -s -w %{http_code} http://pcs.baidu.com/rest/2.0/pcs/file?app_id=${appid}\&method=list\&path=%2F`
    if [[ $status -eq 200 ]]; then
        echo -e "\033[0;32mAppID ${appid} is avaliable!\033[0m"
        # To set BaiduPCS-Go AppID
        BaiduPCS-Go config set -appid=$appid 
        exit 0
    fi
done

# None of AppID avaliable
echo -e "\033[0;31mThere's no AppID avaliable between ${1} and ${2}!\033[0m"
exit 1

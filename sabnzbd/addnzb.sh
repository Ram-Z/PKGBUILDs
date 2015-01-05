#!/bin/sh

. /etc/conf.d/sabnzbd 

for f in $*; do
    curl -s -F apikey="$API_KEY" -F mode="addfile" -F name=@"$f" $URL/sabnzbd/api &> /dev/null
done

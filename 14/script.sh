
#!/bin/bash

# Add to crontab
# */5 * * * *     /var/data/wifi_monitoring.sh > /tmp/wifi-alive.log 2>&1

IPaddresses=(
    192.168.1.1 
    192.168.1.2
    10.1.10.101
    10.1.10.102
    10.1.10.103
    10.1.10.104
    10.1.10.105
)

ERROR=false
SENDMAIL=false

cd /tmp/
rm -f ".message"

echo "START TIME: "$(date) > ".message"
echo "" >> ".message"


for ip in "${IPaddresses[@]}"
do
    filename=.unreachable.$ip

    ping -W 2 -c 3 "${ip}" &> /dev/null && {
        if [ -f "$filename" ]; then
            echo "WiFi Spot $ip is Reachable." >> ".message"

            SENDMAIL=true
        fi

        rm -f "$filename"
    } || {
        ERROR=true

        echo "WiFi Spot $ip is unreachable."
        echo "WiFi Spot $ip is unreachable." >> ".message"

        if [ -f "$filename" ]; then

            datecreat=$(date -r "$filename" +%s)
            secinday=$((24*60*60))
            datecreat=$(($datecreat/$secinday*$secinday))
            realdate=$(date +%s)
            # at 12:00 (+2 h)
            if (( $(($realdate-$datecreat)) >= $(($secinday+10*60*60)) ));
            then
                SENDMAIL=true
                echo "" >> "$filename" # update edit time
            fi

        fi

        if [ ! -f "$filename" ]; then
            echo "$ip" > "$filename"

            SENDMAIL=true
        fi

    }
done

echo "" >> ".message"
echo "END TIME: "$(date) >> ".message"


$SENDMAIL && {
        mail -s 'WiFi Availability Problem' "admin@network.net" < ".message"
        echo "Mail sent"
}


$ERROR && exit 1 || exit 0
#!/bin/ash
#
#This script will change the transmit power and rename ssids on both 2.4 and 5ghz radios.
#It also stops opensync so the changes are not reset until the device reboots.
#


#check if opensync is running
CHECK_OPENSYNC=`ps | awk -e '{print $5}' | grep opensync | cut -c 6-13 | sed -n 1p`

if [ $CHECK_OPENSYNC -eq "opensync" 2> /dev/null ]; then
 #stop opensync
 /etc/init.d/opensync stop
else
 echo "opensync does not appear to be running"
fi

#prompt for tx power
echo "Enter a number 1-30 for transmit power"
read TXPOWER

#check valid input
if [ $TXPOWER -gt 0 -a $TXPOWER -lt 31 2> /dev/null ]; then

#set ssid name and tx power
uci set wireless.wlan0.ssid="Boingo_Test_5"
uci set wireless.wlan1.ssid="Boingo_Test_2.4"
uci set wireless.radio0.txpower="$TXPOWER"
uci set wireless.radio1.txpower="$TXPOWER"

#reload wifi and show status
/sbin/wifi reload
sleep 2
echo `wifi status | egrep 'ssid|power|channel'`

#exit script if invalid input
else
 echo "Not a valid choice, exiting"
 exit
fi
#!/bin/bash
#host=www.fhadsfads.com
echo running test
echo "17=0.5 27=0 22=0" > /dev/pi-blaster
host=www.google.com
validhost=$(ping -c 1 $host| grep -E '(from)' | wc -l)
declare -i packet_loss
declare -i success

if [ $validhost == 0 ]; then
   echo "17=0 27=0 22=1" > /dev/pi-blaster

else
   packet_loss=$(ping -c 50 -q $host | grep -oP '\d+(?=% packet loss)')
   success=$[100 - $packet_loss]
   #success=26
   if [ $success -gt 25 ]; then
   echo success $success
     if [ $success -gt 98 ]; then
        echo "17=0 27=0.25 22=0" > /dev/pi-blaster
     else
        echo "17=0 27=0.13 22=0.66" > /dev/pi-blaster
     fi
   #echo "17=0 27=0.5 22=0" > /dev/pi-blaster
   else 
      echo bad connection
      echo "17=0 27=0 22=1" > /dev/pi-blaster
   fi
   echo nope
fi

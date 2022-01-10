# This program will count SSH successful and failed login attempts from /var/log/auth.log
# and send the results to the Alpha server, realtime.

#!/bin/bash
# Check the program is running as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Initialize the variables
MACHINE_IP=`hostname -I | awk '{print $1}'`
SUCCESS=$(grep --text "sshd" /var/log/auth.log | grep --text "Accepted" | wc -l)
FAILED=$(grep --text "sshd" /var/log/auth.log | grep --text "Failed" | wc -l)
OLDTOTAL=$(($SUCCESS + $FAILED))

# Repeat the following until the user exits
while true
do
    # Wait until someone tries to login to the system
    while inotifywait -q -e modify /var/log/auth.log >/dev/null;
    do
        # Check the /var/log/auth.log to see successful and failed login attempts, save each to a variable
        SUCCESS=$(grep --text "sshd" /var/log/auth.log | grep --text "Accepted" | wc -l)
        FAILED=$(grep --text "sshd" /var/log/auth.log | grep --text "Failed" | wc -l)

        # Add SUCCESS and FAILED to variable "TOTAL"
        TOTAL=$(($SUCCESS + $FAILED))

        # If OLDTOTAL = TOTAL, then do nothing, this is to prevent the program from sending the same data to the Alpha server
        if [ $OLDTOTAL = $TOTAL ]; then
            continue
        fi

        # Send the results ("TOTAL" variable) to the specified IP address and port
        echo "There are $TOTAL successful and failed login attempts on this machine $MACHINE_IP" | nc 192.168.21.68 5000 -q 0

        # Save the current total to OLDTOTAL
        OLDTOTAL=$TOTAL
    done
done
# This program will count SSH successful and failed login attempts from /var/log/auth.log
# and send the results to the Alpha server, realtime.

#!/bin/bash
# Check the program is running as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Repeat the following until the user exits
while true
do
    # Wait until someone tries to login to the system
    while [ ! -f /var/log/auth.log ]
    do
        sleep 1
    done
    # Check the /var/log/auth.log to see successful and failed login attempts, save each to a variable
    SUCCESS=$(grep --text "sshd" /var/log/auth.log | grep --text "Accepted" | wc -l)
    FAILED=$(grep --text "sshd" /var/log/auth.log | grep --text "Failed" | wc -l)

    # Add SUCCESS and FAILED to variable "TOTAL"
    TOTAL=$(($SUCCESS + $FAILED))

    # Send the results ("TOTAL" variable) to the specified IP address and port
    echo "There are $TOTAL successful and failed login attempts on this machine $HOSTNAME" | nc 192.168.21.68 5000 -q 0

    # Close the connection to the Alpha server
    exit 0
done
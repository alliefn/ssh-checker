# This program will count SSH successful and failed login attempts from /var/log/auth.log
# and send the results to the Alpha server, realtime.

# Check the program is running as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Repeat the following until the user exits

# Check the /var/log/auth.log to see successful and failed login attempts, save each to a variable

# Send the results to the Alpha server

# Wait until /var/log/auth.log is updated, then repeat
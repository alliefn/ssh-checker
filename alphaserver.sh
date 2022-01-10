# This program will receive the results from the Alpha client.

#!/bin/bash

echo "Metrics for ssh log-in attempts"
nc -l -p 5000 -k >> /tmp/ssh_logins.txt
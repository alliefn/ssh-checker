# ssh-checker

## How to use
1. Clone the repository
2. Run `chmod +x alphaclient.sh alphaserver.sh`
3. Run `sudo ./alphaclient.sh` on the client
4. Run `sudo ./alphaserver.sh` on the server

## What is this?
This is a simple tool to see total SSH login attempts.

The idea is to deploy this to client and the client will send the data (Total SSH login attempts) to the server.

The server will save the data to a file in /tmp/ssh_logins.txt

## How to automatically deploy this?
First, you need to change 192.168.21.56 and 192.168.21.57 to the client IP address.

Second, you also need to configure the /etc/ansible/hosts to include the client.
Example:
`192.168.21.56 ansible_user=alif`
`192.168.21.57 ansible_user=alif`

Third, you also need to change 192.168.21.68 to the server IP address.

After that, you can run the following command:
1. `chmod +x deploy.sh`
2. `./deploy.sh`

PS: 
* Make sure you have the latest version of ansible installed.
* Make sure you know the password of the server and client.
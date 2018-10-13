#!/bin/sh

# Get the Linux Ubuntu 16.04 Daemon Runtime Dependencies
sudo apt-get update
sudo apt-get upgrade -y
sudo apt autoremove -y && sudo apt-get update
sudo apt-get install -y libzmq3-dev libminiupnpc-dev libssl-dev libevent-dev
sudo apt-get install -y build-essential libtool autotools-dev automake pkg-conf$
sudo apt-get install -y bsdmainutils software-properties-common
sudo apt-get install -y libboost-all-dev
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev

# Get the external IP of the current server
myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
echo "ABACUS HOST WAN/Public IP: ${myip}"

# Grab the MN Private key from keyfile (WIP)
mnprivkey=<INSERT_ABA_MN_KEY_HERE>

# Generate the unique config
mkdir -p ~/.aba
FILE="~/.aba/aba.conf"

sudo sh -c "cat > ${FILE}" <<EOT
rpcuser=abacus
rpcpassword=abagod
rpcport=33556
listen=1
server=1
daemon=1
staking=0
rpcallowip=127.0.0.1
logtimestamps=1
masternode=1
port=3355
externalip=${myip}:3355
masternodeprivkey=${mnprivkey}
addnode=108.61.85.190
addnode=167.99.182.253
addnode=45.63.89.146
addnode=67.205.132.182
EOT

# Download the Linux Daemon
wget https://github.com/AbacusCoin/Abacus/releases/download/v1.0.0.1/ABA-linux.tar.gz
tar -xvf ABA-linux.tar.gz
echo "Please update MN genkey in ~/.aba/aba.conf"
nano ~/.aba/aba.conf
./abad

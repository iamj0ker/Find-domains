#!/bin/bash
green=`tput setaf 2`
echo "${green}Make sure you have go installed"
echo "${green}Make sure you have go installed"
sleep 3
sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y jq
sudo apt-get install -y ruby-full
sudo apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
sudo apt-get install -y python-setuptools
sudo apt-get install -y libldns-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y python-pip
sudo apt-get install -y python-dnspython
sudo apt-get install -y git
sudo apt-get install -y rename
sudo apt-get install -y xargs

#create a folder called tools to insert our tools and files in ~/
mkdir ~/tools
cd ~/tools/

#installing chromium
echo "Lets install chromium"
sudo apt install chromium	
echo "Done"

echo "Installing Sublist3r"
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r*
pip install -r requirements.txt
cd ~/tools/
echo "Sublister installed"

echo "Installing Amass "
sudo apt install amass
echo "Amass installed"

echo "Cloning Seclists"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/

##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED -- nahamsec <3
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/
echo "done"

echo "Installing massdns"
cd ~/tools/
git clone https://github.com/blechschmidt/massdns.git
cd ~/tools/massdns
make
cd ~/tools/
echo "Massdns installed"

#go need to be installed for installing this
echo "Installing Aquatone"
go get github.com/michenriksen/aquatone
echo "Aquatone Installed"

echo "installing httprobe"
go get -u github.com/tomnomnom/httprobe 
echo "done"

echo "Installing subfinder by projectdiscovery"
GO111MODULE=on go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder

sudo cp ~/go/bin/aquatone /bin/
sudo cp ~/go/bin/httprobe /bin/
sudo cp ~/go/bin/subfinder /bin/
echo "${green} get me here https://twitter.com/iam_j0ker"

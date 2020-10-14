# Find-domains
Bash scripts written for finding subdomains using various available tools and screenshoting live domains
# Usage
`./recon.sh <domain>`

`./recon.sh yahoo.com`
# Features
- Create a main folder having the domain name we given
- Create a folder called subdomains and all the subdimains grabbed will be saved as one by one
- Find the live domains using httprobe 
- Take screenshots of the live domains using aquatone and saved into another folder called aqua-out

       Grabing subdomains using sublis3r, subfinder, amass, bruteforcing using massdns, certspotter and crt.sh
      
# Usage and Installation
All tools and requirement needed for running this can be installed with the help of install-tools.sh
install-tools.sh contain the script for installing all tools used here
But you need to have go installed before running install-tools.sh
- Install go
    * `sudo apt install golang-go`
- Clone the repo
    * `git clone https://github.com/iamj0ker/Find-domains.git`
- Install tools needed
    * `chmod +x install-tools.sh`
    * `chmod +x recon.sh`
    * `./install-tools.sh`
- Usage
    * `./recon.sh yahoo.com`
    
If you have problem with screenshot using aquatone
- Find the chromium path
    * `locate chromium `
- Copy the path and change it on the recon.sh line 40

Find me here : https:/twitter.com/iam_j0ker

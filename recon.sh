#!/bin/bash
echo "By https://twitter.com/iam_j0ker"
green=`tput setaf 2`
yellow=`tput setaf 3`
red=`tput setaf 1`
mkdir $1
mkdir $1/subdomains
cd $1/subdomains/
echo "${yellow}======> Started recon on $1"
python3 ~/tools/Sublist3r/sublist3r.py -d $1 -t 10 -v -o sublister.txt
echo "${green}======> sublister.txt saved"
curl -s https://certspotter.com/api/v0/certs\?domain\=$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1 > certspotter.txt
echo "${green}======> certspotter.txt saved"
curl -s https://crt.sh/?Identity=%.$1 | grep ">*.$1" | sed 's/<[/]*[TB][DR]>/\n/g' | grep -vE "<|^[\*]*[\.]* $1" | sort -u | awk 'NF' > crtsh.txt
echo "${green}======> crtsh.txt saved"
subfinder -d $1 -o subfinder.txt
echo "${green}======> subfinder.txt saved"
~/tools/massdns/scripts/ct.py $1 2>/dev/null > massdns.txt
echo "${green}======> massdns.txt saved"
sleep 2
echo "${yellow}======> Starting Amass enum ...."
amass enum -d $1 -o amass-enum.txt
echo "${green}======> Amass-enum.txt saved"
sleep 2
echo "${yellow}======> Starting subbrute ...."
#python3 ~/tools/massdns/scripts/subbrute.py ~/tools/SecLists/Discovery/DNS/clean-jhaddix-dns.txt $1 | ~/tools/massdns/bin/massdns -r ~/tools/massdns/lists/resolvers.txt -t A -q -o S | grep -v 142.54.173.92 > mass.txt
echo "${green}======> subbrute finished and saved as mass.txt"
cat mass.txt | cut -d " " -f 1 > temp.txt
sed s/.$// temp.txt > subbrute-domains.txt
rm temp.txt
echo "${yellow}======> Starting Amass enum "
amass enum --passive -d $1 -o amass.txt
echo "${green}======> Subdomains found using amass saved to amass.txt"
cat sublister.txt certspotter.txt  crtsh.txt subfinder.txt massdns.txt subbrute-domains.txt amass.txt amass-enum.txt | sort -u > all-domains.txt
echo "${yellow}======> All domains have been saved to all-domains.txt"
sleep 2
echo "${yellow}======> Starting to find live domains using httprobe "
cat all-domains.txt | httprobe -prefer-https >> live-domains.txt
echo "${yellow}======> Running aquatone for screenshoting "
cat live-domains.txt | aquatone -chrome-path /bin/chromium -out ../aqua-out-$1
echo "${yellow}======> Screenshots are saved to aqua-out/"
echo "${yellow}======> Total domains found " && cat all-domains.txt | wc -l
sleep 2
echo "${yellow}======> Total live domains found " && cat live-domains.txt | wc -l
sleep 2
echo "Happy hacking by ${yellow}https://twitter.com/iam_j0ker"
echo "${red}======> Recon finished and you can see the file names below${green}"
sleep 1
ls
echo "${yellow}======> Opening screenshots saved... "
sleep 3
firefox ../aqua-out-$1/aquatone_report.html

#! /usr/bin/bash

# Logger Script // System Health Monitor

color=32 # COLOR formatting <- Green/32*Default, Red/31, Blue/34, Yellow/33, Magenta/35, Cyan/36, White/37


#Header --------------------------------------------------------------------------------HED
echo
echo -e "\e[${color}m================================\e[0m" 
echo
echo -e "\e[${color}mSystem Health Snapshot Report\e[0m"
echo "host: " $(hostname) " / " $(date +"%m-%d-%Y %H:%M")
echo
echo -e "\e[${color}m================================\e[0m" 
echo -e "\e[${color}m________________________________\e[0m"


#CPU logic -----------------------------------------------------------------------------CPU
idle=$(top -bn1 | grep "Cpu(s)"| awk '{print $8}' | tr -d ',')
usage=$(echo "100 - $idle" | bc -l)

echo 
echo "CPU: $usage%"
#prints full CPU report for records

cpuThreshold=90.0 # Configure CPU % usage here be sure to include decimal to the nearest 10th (ex 10.0)

if (( $(echo "$usage > $cpuThreshold" | bc -l) )); then 
#(()) ^^^ arithmetic evaluation needed to run bc to allow floats for the comparison // echo used to send to dc to accomodate float values
echo -e "\e[31mCPU usage high!\e[0m"
echo $idle
fi


#Memory logic --------------------------------------------------------------------------MEM
echo
echo "Memory: $(free -h | awk '/Mem:/{print $4 "/" $2 " free"}')"

available=$(free -m | awk 'NR==2{print $7}')
memThreshold=1000 # Configure Memory Thresehold here in MB

if [ $available -lt $memThreshold ]; then
echo -e "\e[31mMemory usage high!\e[0m"
echo $available
fi

#Disk logic ----------------------------------------------------------------------------DSK
echo
root=$(df --output=avail -BG / | tail -1 | sed 's/G//')
echo
echo "Disk: $root GB free"

diskThreshold=5 # Configure Drive space here in GB

if [ $root -lt $diskThreshold ]; then
echo -e "\e[31mDisk usage high!\e[0m"
echo $root
fi


#Uptime logic --------------------------------------------------------------------------UPT
echo
echo "Uptime: $(uptime -p | sed 's/up / /;')"


#Service logic -------------------------------------------------------------------------SER
echo
if systemctl is-active --quiet docker; then
echo "Docker: running"
docker --version
else
echo -e "\e[31mDocker is not running!\e[0m"
fi

echo -e "\e[${color}m________________________________\e[0m"



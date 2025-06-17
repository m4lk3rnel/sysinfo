#!/bin/bash

RED='\033[1;31m'
BLUE='\033[1;34m'
NC='\033[0m'

#Kernel
echo -e "${RED}Kernel${NC}"
uname -sr
echo ""

#CPU Arch
echo -e "${RED}Arch${NC}"
uname -m
echo ""

#Hostname
echo -e "${RED}Hostname${NC}"
hostname
echo ""

#OS
echo -e "${RED}OS${NC}"
grep "PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"'
echo ""

#SHELL
echo -e "${RED}Shell${NC}"
$(echo $SHELL) --version
echo ""

#Uptime
echo -e "${RED}Uptime${NC}"
uptime -p | sed 's/up //'
echo ""

#CPU
grep -m 1 "model name" /proc/cpuinfo | awk -F ": " -v RED="$RED" -v NC="$NC" 'BEGIN {printf "%sCPU%s\n", RED, NC} {print $2}'  
echo ""

#Memory
echo -e "${RED}Memory${NC}"
awk '/Active:/ {GiB=$2/(1024*1024); printf "Used:\t%.2f GiB\n", GiB} /MemTotal:/ {GiB=$2/(1024*1024); printf "Total:\t%.2f GiB\n", GiB}' /proc/meminfo
echo ""

#Disk
echo -e "${RED}Disk${NC}"
df -h --output=source,size,used,avail,pcent,target | grep -vE '^tmpfs|^udev'
echo ""

#GPU
echo -e "${RED}GPU${NC}"
lspci | grep -i --color=never "vga\|3d\|2d"
echo ""

#Network
echo -e "${RED}Network${NC}"
ip -br addr | awk -F" " -v BLUE="$BLUE" -v NC="$NC" 'BEGIN {printf "%sInterface\tinet4\tinet6%s\n", BLUE, NC}{print $1,$3,$4}' | column -t


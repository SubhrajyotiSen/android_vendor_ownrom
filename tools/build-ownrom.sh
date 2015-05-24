#!/bin/bash
#OwnROM compilation script
echo -e '\0033\0143'
res1=$(date +%s.%N)
# Specify colors for shell
red='tput setaf 1'              # red
green='tput setaf 2'            # green
yellow='tput setaf 3'           # yellow
blue='tput setaf 4'             # blue
violet='tput setaf 5'           # violet
cyan='tput setaf 6'             # cyan
white='tput setaf 7'            # white
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) # Bold red
bldgrn=${txtbld}$(tput setaf 2) # Bold green
bldblu=${txtbld}$(tput setaf 4) # Bold blue
bldcya=${txtbld}$(tput setaf 6) # Bold cyan
normal='tput sgr0'
tput bold
tput setaf 2
clear
echo -e ""
echo -e "██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗ "
echo -e "██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝ "
echo -e "██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗   "
echo -e "██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝   "
echo -e "╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗ "
echo -e " ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝ "
echo -e "                                                               "
echo -e "                    ████████╗ ██████╗                          "
echo -e "                    ╚══██╔══╝██╔═══██╗                         "
echo -e "                       ██║   ██║   ██║                         "
echo -e "                       ██║   ██║   ██║                         "
echo -e "                       ██║   ╚██████╔╝                         "
echo -e "                       ╚═╝    ╚═════╝                          "
echo -e "                                                               "
echo -e "     ██████╗ ██╗    ██╗███╗   ██╗██████╗  ██████╗ ███╗   ███╗  "
echo -e "    ██╔═══██╗██║    ██║████╗  ██║██╔══██╗██╔═══██╗████╗ ████║  "
echo -e "    ██║   ██║██║ █╗ ██║██╔██╗ ██║██████╔╝██║   ██║██╔████╔██║  "
echo -e "    ██║   ██║██║███╗██║██║╚██╗██║██╔██═╝ ██║   ██║██║╚██╔╝██║  "
echo -e "    ╚██████╔╝╚███╔███╔╝██║ ╚████║██║ ██═╗╚██████╔╝██║ ╚═╝ ██║  "
echo -e "     ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝  "
echo -e ""
echo -e ""
sleep 3s
# Clear terminal
clear
#Setup environment now
echo -e "Setting up environment"
$normal
. build/envsetup.sh
echo -e "Environment set up"
# Confirm 'make clean'
echo -e "\n\n${bldgrn}  Do you want to make clean?\n"
echo ""
echo -e "${bldblu}  1. Yes"
echo -e "${bldblu}  2. No"
echo ""
echo ""
$normal
read askClean

echo ""
echo ""
if [ "$askClean" == "1" ]
then
    echo -e "${bldred}  Compilation will continue after cleaning previous build files... "
    $normal
    make clobber
    echo -e "Previous build files removed"
else
    echo -e "${bldred}  ROM will be compiled without cleaning previous build files... "
fi
echo ""
echo ""


# Confirm fetching prebuilts
echo -e "\n\n${bldgrn}  Do you want to fetch prebuilts?\n  (You don't need to fetch them frequently)"
echo ""
echo -e "${bldblu}  1. Yes"
echo -e "${bldblu}  2. No"
echo ""
echo ""
$normal
read askPrebuilts

echo ""
echo ""
if [ "$askPrebuilts" == "1" ]
then
    echo -e "${bldred}  Prebuilts will be fetched... "
    $normal
    cd vendor/ownrom/tools
    ./get-prebuilts
    croot
else
    echo -e "${bldred}  Prebuilts won't be fetched... "
fi
echo ""
echo ""

sleep 2s
#Clear terminal
clear
echo -e ""
echo -e ""
echo -e "Choose your device from the lunch menu being displayed. Enter the number of your device"
echo -e ""
echo -e ""
$normal
$green
lunch
# Clear terminal
clear
# Start compilation
echo -e ""
echo -e ""
echo -e "${bldcya}  Starting compilation of OwnRom..."
echo -e ""
echo -e ""
$normal
time mka ownrom
#Better to use mka instead of make-j <number of threads> as most processors won't support 16 threads,mka automatically uses the maximum available
echo -e ""
# Get elapsed time
$blue
res2=$(date +%s.%N)
echo -e ""
echo -e ""
echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
echo -e ""
echo -e ""
# Compilation complete
tput bold
tput setaf 1
clear
echo -e ""
echo -e ""
echo -e " ██████╗ ██████╗ ███╗   ███╗██████╗ ██╗██╗      █████╗ ████████╗██╗ ██████╗ ███╗   ██╗ "
echo -e "██╔════╝██╔═══██╗████╗ ████║██╔══██╗██║██║     ██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║ "
echo -e "██║     ██║   ██║██╔████╔██║██████╔╝██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║ "
echo -e "██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║ "
echo -e "╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ██║███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║ "
echo -e ""
echo -e "                                                                                       "
echo -e "         ██████╗ ██████╗ ███╗   ███╗██████╗ ██╗     ███████╗████████╗███████╗          "
echo -e "        ██╔════╝██╔═══██╗████╗ ████║██╔══██╗██║     ██╔════╝╚══██╔══╝██╔════╝          "
echo -e "        ██║     ██║   ██║██╔████╔██║██████╔╝██║     █████╗     ██║   █████╗            "
echo -e "        ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══╝     ██║   ██╔══╝            "
echo -e "        ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ███████╗███████╗   ██║   ███████╗          "
echo -e "         ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚══════╝╚══════╝   ╚═╝   ╚══════╝          "
echo -e ""
echo -e ""


# Switch terminal back to normal
$normal


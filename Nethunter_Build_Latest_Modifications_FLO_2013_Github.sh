#!/bin/bash
# This script will automate the install and configuration of Kali Linux on the Nexus 7 (Wi-Fi 2013 Edition)

# *** Perform a factory reset and erase of the current OS before you continue ***

echo "Creating Nethunter_Build directory in your current user directory ~/"
mkdir ~/Nethunter_Build
cd ~/Nethunter_Build/

echo "Installing Android Tools ADB"
sudo apt-get install android-tools-adb android-tools-fastboot

echo "Running git clone of nethunter"
git clone https://github.com/offensive-security/kali-nethunter

echo "Change into the downloaded directory"
cd ~/Nethunter_Build/kali-nethunter/nethunter-installer

echo "Building your Kali Nethunter Marshmallow image"

python build.py -d flo --marshmallow --rootfs full --release Kali_Keith_Edition_v1.9
sleep 7
echo "Changing the name of the created Nethunter image file"
$(mv *.zip kaliNethunter.zip)

echo "Cloning nethunter-LRT tools"
cd ~/Nethunter_Build/
git clone https://github.com/offensive-security/nethunter-LRT.git
sleep 3

cd ~/Nethunter_Build/nethunter-LRT/stockImage/
echo "Pulling down last image for (flo)-(LMY48G) for Nexus 7 2013 (Wi-Fi)"
cd ~/Nethunter_Build/nethunter-LRT/stockImage/

echo "Checking if a directory already exists with the Nexus 7 stock ROM in it and downloading and creating if it isn't there already"
FILE="update-nethunter-flo-marshmallow"

if [ -d "$FILE" ];
then
   echo "File $FILE exists, skipping download."
else
   mkdir update-nethunter-flo-marshmallow && cd update-nethunter-flo-marshmallow/ && download=$(wget https://dl.google.com/dl/android/aosp/razor-lmy48g-factory-9f37ae5f.tgz)
fi

echo "Downloading TWRP Image"
cd ~/Nethunter_Build/nethunter-LRT/twrpImage
wget "https://dl.twrp.me/flo/twrp-3.0.2-0-flo.img" --referer="https://dl.twrp.me/flo/twrp-3.0.2-0-flo.img.html" --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0"

echo "Downloading SuperSu"
cd ~/Nethunter_Build/nethunter-LRT/superSu
wget "https://download.chainfire.eu/897/SuperSU/BETA-SuperSU-v2.67-20160121175247.zip?retrieve_file=1" --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0" -O SuperSU-v2.67.zip

echo "Moving the Kali Image to the nethunter-LRT/kaliNethunter directory as it's now needed"
cd ~/Nethunter_Build/nethunter-LRT/kaliNethunter
cp  ~/Nethunter_Build/kali-nethunter/nethunter-installer/kaliNethunter.zip .

echo "Starting the unlock procedure | You may be prompted to authorise your computer on the tablet so select yes and remember"
cd ~/Nethunter_Build/nethunter-LRT
/bin/bash ./oemUnlock.sh && sleep 1m

echo "The stock ROM needs to be in a direcotry on it's own so the script doesn't break"
cd ~/Nethunter_Build/nethunter-LRT/stockImage/update-nethunter-flo-marshmallow
$(mv razor-lmy48g-factory-9f37ae5f.tgz ~/Nethunter_Build/nethunter-LRT/stockImage)
sleep 10
$(rm -r ~/Nethunter_Build/nethunter-LRT/stockImage/update-nethunter-flo-marshmallow)
sleep 10

echo "Moving back into the correct directory"
cd ~/Nethunter_Build/nethunter-LRT/

echo "Flashing to stock ROM before proceeding further | enable developer options again"
echo "During this period update to Marshmallow on the tablet and install any updates available"
echo "Factory reset of the tablet with the Nexus 7 stock ROM will now take place"
/bin/bash ./stockNexusFlash.sh 32gb

echo "+-+-+ +-+-+-+-+-+-+-+ +-+-+-+ +-+-+-+-+ +-+-+-+-+ +-+-+-+ +-+-+-+-+
|B|e| |p|a|t|i|e|n|t| |a|n|d| |m|a|k|e| |s|u|r|e| |y|o|u| |h|a|v|e|
+-+-+ +-+-+-+-+-+-+-+ +-+-+-+ +-+-+-+-+ +-+-+-+-+ +-+-+-+ +-+-+-+-+
+-+-+-+-+-+-+-+-+-+-+ +-+-+-+ +-+-+-+-+-+ +-+-+-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+
|c|o|n|f|i|g|u|r|e|d| |t|h|e| |s|t|o|c|k| |i|m|a|g|e| |a|n|d| |e|n|a|b|l|e|d|
+-+-+-+-+-+-+-+-+-+-+ +-+-+-+ +-+-+-+-+-+ +-+-+-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+
+-+-+-+-+-+-+-+-+-+ +-+-+-+-+ +-+-+-+-+ +-+-+-+-+-+ +-+-+-+-+-+-+ +-+-+-+
|d|e|v|e|l|o|p|e|r| |m|o|d|e| |w|i|t|h| |d|e|b|u|g| |b|e|f|o|r|e| |y|o|u|
+-+-+-+-+-+-+-+-+-+ +-+-+-+-+ +-+-+-+-+ +-+-+-+-+-+ +-+-+-+-+-+-+ +-+-+-+
+-+-+-+-+-+ +-+-+-+-+-+
|p|r|e|s|s| |E|N|T|E|R|
+-+-+-+-+-+ +-+-+-+-+-+"

read -p ""

echo "
+-+-+-+-+-+-+ +-+-+-+-+-+-+
|N|e|a|r|l|y| |T|h|e|r|e|!|
+-+-+-+-+-+-+ +-+-+-+-+-+-+
"

echo "Moving the Nexus stock ROM as it may be needed again"
cd ~/Nethunter_Build/nethunter-LRT/stockImage/ && mkdir update-nethunter-flo-marshmallow
$(mv razor-lmy48g-factory-9f37ae5f.tgz ~/Nethunter_Build/nethunter-LRT/stockImage/update-nethunter-flo-marshmallow)
sleep 10

echo "Flashing with TWRP, superSU && Kali Nethunter"
echo "TWRP recovery should boot on the tablet in a moment when it reboots"
cd ~/Nethunter_Build/nethunter-LRT
/bin/bash ./twrpFlash.sh

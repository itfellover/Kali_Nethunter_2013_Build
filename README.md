# Kali_Nethunter_2013_Build
https://itfellover.com/kali-nethunter-custom-build-nexus-7-2013/

This script allows you to easily deploy Kali Linux Nethunter to the 2013 Nexus 7 (LMY48G) with ease. It can be modified for other devices too.

This script uses the Offensive Security scripts and automates the process:

https://github.com/offensive-security/nethunter-LRT.git
https://github.com/offensive-security/kali-nethunter

This builds a marshmallow image with a full chroot (Change flo to a different version if required):

python build.py -d flo --marshmallow --rootfs full --release Kali_Keith_Edition_v1.9

Android stock image is pulled down from Google:

https://dl.google.com/dl/android/aosp/razor-lmy48g-factory-9f37ae5f.tgz

TWRP is downloaded:

https://dl.twrp.me/flo/twrp-3.0.2-0-flo.img

SuperSU is then downloaded:

https://download.chainfire.eu/897/SuperSU/BETA-SuperSU-v2.67-20160121175247.zip?retrieve_file=1

The unlock script is then ran against the device and it sleeps for a minute as you may need to touch the screen to confirm this if not already unlocked.

/bin/bash ./oemUnlock.sh && sleep 1m

Stock image is flashed (Change 32gb to the required version):

/bin/bash ./stockNexusFlash.sh 32gb

Stock flashing can take some time to complete, once it's finished, update any additional updates that may need to be installed and configure developer options with USB debugging enabled to continue to the next step. Once done click enter.

Flash with your custom Kali NetHunter image, install TWRP and SuperSU:

/bin/bash ./twrpFlash.sh

Done

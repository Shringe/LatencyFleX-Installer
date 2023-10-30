# LatencyFleX-Installer
Installer for LatencyFlex, https://github.com/ishitatsuyuki/LatencyFleX

DISCLAIMER: I am not associated with LatencyFlex in any way.

Note: LatencyFlex must be installed on your system first; this installer only installs LatencyFlex on your Proton installations, and games for you.

Note: Tested on Arch Linux with manual LatencyFlex install on system, should work if installed through LatencyFlex AUR package. Not tested on other distributions, but also should work.
## Installation
```git clone https://github.com/Shringe/LatencyFleX-Installer.git```

## Usage
Example: for installing to Apex Legends and Proton experimental, the usage would be:
```
./install.sh --proton "/home/<user>/.local/share/Steam/steamapps/common/Proton - Experimental/"
./install.sh --game "Apex Legends" 1172470 # "Apex Legends" being the game directory name, and 1172470 being the game ID, you can find the game ID by looking at the store page.
```
Once you install LatencyFlex to a Proton installation, all games with LatencyFlex installed using that version of Proton should now work.
Don't forget to add the necessary launch options, or configure the dxvk.conf beforehand.

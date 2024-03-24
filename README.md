# LatencyFleX-Installer
Installer for [LatencyFleX](https://github.com/ishitatsuyuki/LatencyFleX)

DISCLAIMER: I am not associated with LatencyFleX in any way.

## Compatibility and Prerequisites
LatencyFleX must be installed on the system, game, and version of proton you are using. This installer can install LatencyFleX to your games and proton versions for you, but you must first have [LatencyFleX installed](https://github.com/ishitatsuyuki/LatencyFleX?tab=readme-ov-file#installation) on the system.

This has been so far tested with:
 - Arch Linux (AUR Install)
 - Arch Linux (Manual Install)

This should work with any distribution that keeps the system LatencyFleX DLLs/SOs in the same place.
Feel free to create an issue or PR if your distro is not working with this script, or if it is working but not listed.


## Installation
```
git clone https://github.com/Shringe/LatencyFleX-Installer.git
```

## Usage
Example: for installing to Apex Legends and Proton experimental, the usage would be:
```
./install.sh --proton "/home/<user>/.local/share/Steam/steamapps/common/Proton - Experimental/"
./install.sh --game "Apex Legends" 1172470 # "Apex Legends" being the game directory name, and 1172470 being the game ID, you can find the game ID by looking at the store page.
```
Once you install LatencyFleX to a Proton installation, all games with LatencyFleX installed using that version of Proton should now work.
Don't forget to add the necessary launch options, or configure the dxvk.conf beforehand.

Custom proton versions may also be found under ```/home/<user>/.local/share/Steam/compatibilitytools.d/```

## Configuration
The dxvk.conf file is already configured for nvidia GPUs, if you do not have an nvidia GPU, uncomment the second line.

## Launch options
Nvidia GPUs:
```PROTON_NVAPI=1 LFX=1 %COMMAND%```

Non-Nvidia GPUs:
```PROTON_ENABLE_NVAPI=1 DXVK_NVAPI_DRIVER_VERSION=49729 DXVK_NVAPI_ALLOW_OTHER_DRIVERS=1 LFX=1 %COMMAND%```

#!/bin/bash


# LatencyFlex libraries
latencyflex_wine_dll="/usr/lib/wine/x86_64-windows/latencyflex_wine.dll"
latencyflex_layer_dll="/usr/lib/wine/x86_64-windows/latencyflex_layer.dll"
latencyflex_layer_so="/usr/lib/wine/x86_64-unix/latencyflex_layer.so"

# This will be prompted for at runtime
DEFAULT_STEAM_DIRECTORY="$HOME/.local/share/Steam"
promptSteamDir=true


# Prompts [y/N] countinue prompt
function promptCountinue {
    read -p "$1[y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "Installing..."
    else
        echo "Aborted by user."
        exit
    fi
}

# Returns $1 if $2 is empty
function defaultTo {
    if [ -n "$2" ]; then
        echo $2 
    else
        echo $1
    fi
}


# Symlinks DLLs to specified location
function linkDLLs {
    # For unknown reason the symlinks here are broken, seen in issue https://github.com/ishitatsuyuki/LatencyFleX/issues/5
    # ln -s "$latencyflex_wine_dll" "$1"
    # ln -s "$latencyflex_layer_dll" "$1"

    cp "$latencyflex_wine_dll" "$1"
    cp "$latencyflex_layer_dll" "$1"
}

# copies dxvk.conf to specified location
function copyDXVKConf {
    cp "dxvk.conf" "$1"
}


# Installs to game with game directory name(not full path), and game ID
function installToGame {
    # Getting steam directory
    if [ "$promptSteamDir" = true ]; then
        echo "Enter Steam directory, leave blank for \"$DEFAULT_STEAM_DIRECTORY\":"
        read steamDir
    else
        steamDir=""
    fi

    local steamDir=$(defaultTo $DEFAULT_STEAM_DIRECTORY $steamDir)
    echo $steamDir

    # Installing
    promptCountinue "Install dxvk.conf into \"$1\", and libraries into \"$2\"?"

    linkDLLs "$steamDir/steamapps/compatdata/$2/pfx/drive_c/windows/system32"
    copyDXVKConf "$steamDir/steamapps/common/$1"

    echo "Installation finished, remember to have LatencyFlex installed on the system/proton, aswell as the proper launch options for LatencyFlex to work ingame."
}

# Installs to proton version with full path
function installToProton {
    promptCountinue "Install libraries into \"$1\"?"

    linkDLLs "$1/files/lib64/wine/x86_64-windows"
    
    # see function linkDLLs for change
    # ln -s "$latencyflex_layer_so" "$1/files/lib64/wine/x86_64-unix"
    cp "$latencyflex_layer_so" "$1/files/lib64/wine/x86_64-unix"

    echo "Installation finished, remember to install LatencyFlex for the individual games you plan to use LatencyFlex with."
}


# Handling parameters
echo -e "Make sure you have LatencyFlex installed on the system before using, as this installer copies files from the system install.\n"
if [[ "$1" == "--game" ]]; then 
    installToGame "$2" "$3"
elif [[ "$1" == "--proton" ]]; then
    installToProton "$2"
else
    echo "Install script to install LatencyFlex to games and proton versions easily.
  --game    Installs LatencyFlex to a specified game directory name + game ID, e.x. './install.sh \"Apex Legends\" 1172470'
  --proton  Installs LatencyFlex to a specified proton full path, e.x. './install.sh \"$DEFAULT_STEAM_DIRECTORY/compatibilitytools.d/GE-Proton8-21/\"'"
fi


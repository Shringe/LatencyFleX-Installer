#!/bin/bash


# LatencyFlex libraries
latencyflex_wine_dll="/usr/lib/wine/x86_64-windows/latencyflex_wine.dll"
latencyflex_layer_dll="/usr/lib/wine/x86_64-windows/latencyflex_layer.dll"
latencyflex_layer_so="/usr/lib/wine/x86_64-unix/latencyflex_layer.so"

steamDirectory="$HOME/.local/share/Steam"


# Prompts [y/N] countinue prompt
function promptCountinue {
    read -p "$1[y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "Installing..."
    else
        exit
    fi
}

# symlinks dlls to specified location
function linkDLLs {
    # For unknown reason these smylinks here is broken, seen in issue https://github.com/ishitatsuyuki/LatencyFleX/issues/5
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
    promptCountinue "Install dxvk.conf into '$1', and libraries into '$2'?"

    linkDLLs "$steamDirectory/steamapps/compatdata/$2/pfx/drive_c/windows/system32"
    copyDXVKConf "$steamDirectory/steamapps/common/$1"

    echo "Installation finished, remember to have LatencyFlex installed on the system/proton, aswell as the proper launch options for LatencyFlex to work ingame."
}

# Installs to proton version with full path
function installToProton {
    promptCountinue "Install libraries into '$1'?"

    linkDLLs "$1/files/lib64/wine/x86_64-windows"
    
    # see function linkDLLs for change
    # ln -s "$latencyflex_layer_so" "$1/files/lib64/wine/x86_64-unix"
    cp "$latencyflex_layer_so" "$1/files/lib64/wine/x86_64-unix"

    echo "Installation finished, remember to install LatencyFlex for the individual games you plan to use LatencyFlex with."
}


# handling parameters
if [[ "$1" == "--game" ]]; then
    echo "Make sure you have LatencyFlex installed on the system before installing to games, as this installer copies files from the system install."
    installToGame "$2" "$3"
elif [[ "$1" == "--proton" ]]; then
    installToProton "$2"
else
    echo "Install script to install LatencyFlex to games and proton versions easily.
  --game    Installs LatencyFlex to a specified game directory name + game ID, e.x. './install.sh \"Apex Legends\" 1172470'
  --proton  Installs LatencyFlex to a specified proton full path, e.x. './install.sh \"$steamDirectory/compatibilitytools.d/GE-Proton8-21/\"'"
fi

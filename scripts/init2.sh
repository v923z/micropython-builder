#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022 Zoltán Vörös


# set-up and housekeeping utilities

# get the number of processors, so that this might be passed to make
if which nproc > /dev/null; then
    MAKEOPTS="-j$(nproc)"
else
    MAKEOPTS="-j$(sysctl -n hw.ncpu)"
fi


function clone_ulab() {
    # only check out ulab, if is not availble locally, otherwise, pull
    git clone https://github.com/v923z/micropython-ulab ulab || git -C ulab pull
}

function clone_micropython() {
    # only check out micropython, if it is not available locally, otherwise, pull
    git clone https://github.com/micropython/micropython micropython || git -C micropython pull
    cd micropython
    git submodule update --init
    cd ..
    
    # only check out micropython-lib, if it is not available locally, otherwise, pull
    git clone https://github.com/micropython/micropython-lib || git -C micropython-lib pull
}


# create hashes, which will be appended to the output file names
ulab_hash=`cd ulab; git describe --abbrev=8 --always; cd ..`
upython_hash=`cd micropython; git describe --abbrev=8 --always; cd ..`

function make_mpy_cross() {
    # the cross-compiler is required for each build, so we might as well get it over with
    make ${MAKEOPTS} -C micropython/mpy-cross
}

function write_platforms_list() {
    # choose a delimiter that is not probable to turn up in the description of the file
    if [ -f "platforms.md" ]; then
        echo $1"| "$1-$upython_hash-$ulab_hash$ext"| " $2 >> ./platforms.list
    echo
    fi
}

function copy_files() {
    # helper function to move the binary file from the build directory a temporary folder (./artifacts)
    if [ -d "./artifacts" ]; then
        echo "copying firmware"
        stem=`basename $1`
        ext=$([[ "$stem" = *.* ]] && echo ".${stem##*.}" || echo '')
        mv micropython/ports/$1 ./artifacts/$2$ext
    fi
}

# clean up the build directory, in case another piece of firmware is produced for the same port
# note that the clean-up routine is run only, if the ./artifacts directory exists
function clean_up() {
    # only remove the artifacts, if they can be saved in the ./artifacts folder
    if [ -d "./artifacts" ]; then
        echo "removing compilation folder"
        rm ./micropython/ports/$1/$2 -rf
    fi
}

function install_arm() {
    sudo apt-get install gcc-arm-none-eabi libnewlib-arm-none-eabi
}

function install_epsidf() {
    # Instructions from: https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/linux-macos-setup.html
    sudo apt-get install git wget flex bison gperf python3 python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0

    pip3 install pyelftools
    git clone https://github.com/espressif/esp-idf.git
    git -C esp-idf checkout v5.0.2
    ./esp-idf/install.sh

    cd esp-idf
    ./install.sh all
}

function build_stm32() {
    clone_ulab
    clone_micropython
    install_arm
    make_mpy_cross

    make ${MAKEOPTS} -C micropython/ports/stm32 BOARD=$1 USER_C_MODULES=../../../ulab all CFLAGS_EXTRA=-DULAB_HASH_STRING=$ulab_hash
    copy_files stm32/build-$1/firmware.dfu $1
    clean_up stm32 build-$1
}
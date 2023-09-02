#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022-2023 Zoltán Vörös

source ./scripts/init.sh

build_rp2() {
    make ${MAKEOPTS} -C ports/rp2 submodules
    make ${MAKEOPTS} -C ports/rp2
    make ${MAKEOPTS} -C ports/rp2 BOARD=$1 submodules
    make ${MAKEOPTS} -C micropython/ports/rp2 BOARD=$1 USER_C_MODULES=../../../ulab/code/micropython.cmake CFLAGS_EXTRA=-DULAB_HASH=$ulab_hash
    copy_files rp2/build-$1/firmware.uf2 $1
    clean_up rp2 build-$1
}

build_rp2_uart_vfat() {
    # hot-patch the config file here
    cp ./scripts/rp2/mpconfigport.h.patch.uart_vfat ./micropython/ports/rp2/boards/RPI_PICO/mpconfigport.h
    make ${MAKEOPTS} -C micropython/ports/rp2 BOARD=$1 USER_C_MODULES=../../../ulab/code/micropython.cmake CFLAGS_EXTRA=-DULAB_HASH=$ulab_hash 
    copy_files rp2/build-$1/firmware.uf2 "$1"-UART-VFAT
    clean_up rp2 build-$1
}

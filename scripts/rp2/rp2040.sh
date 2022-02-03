#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022 Zoltán Vörös


boards=("ARDUINO_NANO_RP2040_CONNECT" "PICO")

source ./scripts/init.sh

for board in ${boards[*]}; do
    make ${MAKEOPTS} -C micropython/ports/rp2 BOARD=$board USER_C_MODULES=../../../ulab/code/micropython.cmake
    copy_files rp2/build-$board/firmware.uf2 $board
    clean_up rp2 build-$board
done

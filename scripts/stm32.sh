#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022 Zoltán Vörös


# check out the repositories, build cross-compiler
./scripts/init.sh

cd micropython

make ${MAKEOPTS} -C ports/stm32 submodules
git submodule update --init lib/btstack
git submodule update --init lib/mynewt-nimble

cd ..


for board in ${boards[*]}; do
    make ${MAKEOPTS} -C micropython/ports/stm32 BOARD=$board MICROPY_PY_WIZNET5K=5200 MICROPY_PY_CC3K=1 USER_C_MODULES=../../../ulab all
    copy_files stm32/build-$board/firmware.uf2 $board
    clean_up stm32 build-$board
done
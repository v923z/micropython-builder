#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022 Zoltán Vörös

source ./scripts/init.sh

build_stm32() {
    make ${MAKEOPTS} -C micropython/ports/stm32 BOARD=$1 USER_C_MODULES=../../../ulab all
    copy_files stm32/build-$1/firmware.dfu $1
    clean_up stm32 build-$1
}
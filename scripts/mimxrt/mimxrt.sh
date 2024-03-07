#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2024 Zoltán Vörös

source ./scripts/init.sh

build_mimxrt() {
    make ${MAKEOPTS} -C micropython/ports/mimxrt BOARD=$1 USER_C_MODULES=../../../ulab all CFLAGS_EXTRA=-DULAB_HASH_STRING=$ulab_hash
    copy_files mimxrt/build-$1/firmware.hex $1
    clean_up mimxrt build-$1
}
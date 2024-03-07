#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2024 Zoltán Vörös

source ./scripts/init.sh

build_samd() {
    make ${MAKEOPTS} -C micropython/ports/samd BOARD=$1 USER_C_MODULES=../../../ulab all CFLAGS_EXTRA="-DULAB_HASH_STRING=$ulab_hash -DULAB_SUPPORTS_COMPLEX=0"
    copy_files samd/build-$1/firmware.dfu $1
    clean_up samd build-$1
}
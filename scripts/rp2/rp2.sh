#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022 Zoltán Vörös

source ./scripts/init.sh

build_rp2() {
    make ${MAKEOPTS} -C micropython/ports/rp2 BOARD=$1 USER_C_MODULES=../../../ulab/code/micropython.cmake CFLAGS_EXTRA=-DULAB_HASH=$ulab_hash
    copy_files rp2/build-$1/firmware.uf2 $1
    clean_up rp2 build-$1
}

#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022 Zoltán Vörös
#                2023 Zach Moshe

source ./scripts/init.sh

build_esp32() {
    source esp-idf/export.sh
    make ${MAKEOPTS} -C micropython/ports/esp32 BOARD=$1 USER_C_MODULES=../../../../ulab/code/micropython.cmake CFLAGS_EXTRA=-DULAB_HASH=$ulab_hash
    copy_files esp32/build-$1/firmware.bin $1
    clean_up esp32 build-$1
}

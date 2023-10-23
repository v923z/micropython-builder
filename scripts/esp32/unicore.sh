#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022 Zoltán Vörös
#                2023 Zach Moshe
#                2023 Ganer

source ./scripts/esp32/esp32.sh
source esp-idf/export.sh

make ${MAKEOPTS} -C micropython/ports/esp32 BOARD=ESP32_GENERIC BOARD_VARIANT=UNICORE USER_C_MODULES=../../../../ulab/code/micropython.cmake CFLAGS_EXTRA=-DULAB_HASH=$ulab_hash
mv micropython/ports/esp32/build-generic/firmware.bin ./artifacts/ESP32_UNICORE.bin
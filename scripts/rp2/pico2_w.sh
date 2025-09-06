#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022 Zoltán Vörös
#  File Author: Jayanth Damodaran    Last Modified: Sept. 6, 2025

source ./scripts/rp2_init.sh

cd micropython/ports/rp2
make BOARD=RPI_PICO2_W submodules
make BOARD=RPI_PICO2_W clean
make BOARD=RPI_PICO2_W USER_C_MODULES=../../../ulab/code/micropython.cmake
cd ../../..

copy_files rp2/build-RPI_PICO2_W/firmware.uf2 RPI_PICO2_W
clean_up rp2 build-RPI_PICO2_W

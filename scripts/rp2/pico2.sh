#!/bin/bash

source ./scripts/rp2_init.sh

cd micropython/ports/rp2
make BOARD=RPI_PICO2 submodules
make BOARD=RPI_PICO2 clean
make BOARD=RPI_PICO2 USER_C_MODULES=../../../ulab/code/micropython.cmake
cd ../../..

copy_files rp2/build-RPI_PICO2/firmware.uf2 RPI_PICO2
clean_up rp2 build-RPI_PICO2

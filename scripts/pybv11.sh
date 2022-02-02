#!/bin/bash

source ./scripts/init.sh

make ${MAKEOPTS} -C micropython/ports/stm32 BOARD=PYBV11 USER_C_MODULES=../../../ulab all
copy_files stm32/build-PYBV11/firmware.dfu pybv11
clean_up stm32 build-PYBV11
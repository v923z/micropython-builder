#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022 Zoltán Vörös

source ./scripts/init.sh

make ${MAKEOPTS} -C micropython/ports/stm32 BOARD=PYBV11 USER_C_MODULES=../../../ulab all
copy_files stm32/build-PYBV11/firmware.dfu pybv11
clean_up stm32 build-PYBV11
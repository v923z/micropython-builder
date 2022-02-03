#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022 Zoltán Vörös

source ./scripts/init.sh

make ${MAKEOPTS} -C micropython/ports/stm32 BOARD=PYBD_SF6 USER_C_MODULES=../../../ulab all
copy_files stm32/build-PYBD_SF6/firmware.dfu pybd_sf6
clean_up stm32 build-PYBD_SF6
#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022 Zoltán Vörös

source ./scripts/init.sh

make ${MAKEOPTS} -C micropython/ports/unix axtls
make ${MAKEOPTS} -C micropython/ports/unix USER_C_MODULES=../../../ulab DEBUG=1 STRIP=: MICROPY_PY_FFI=0 MICROPY_PY_BTREE=0

copy_files unix/micropython unix
clean_up unix build-standard
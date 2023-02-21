#!/bin/bash

#  This file is part of the micropython-builder project,
#  https://github.com/v923z/micropython-builder
#  The MIT License (MIT)
#  Copyright (c) 2022 Zoltán Vörös
#  20.2.2023, sakluk: Added new port for Pico W

source ./scripts/rp2/rp2.sh

build_rp2 "PICO_W"

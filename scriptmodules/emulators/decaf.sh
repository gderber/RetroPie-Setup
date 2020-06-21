#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="decaf"
rp_module_desc="Wii-U Emulator"
rp_module_help="ROM Extensions: .iso .wuz\n\nCopy your Wii-U roms to $romdir/wiiu"
rp_module_licence="GPL2 https://raw.githubusercontent.com/decaf-emu/decaf/master/license.txt"
rp_module_section="exp"
rp_module_flags="!all 64bit"

function depends_decaf() {
    local depends=(cmake libcurl4-openssl-dev libsdl2-dev libssl-dev zlib1g-dev)

    # Not listed officially; but build fails without these libraries installed
    depends+=(libuv1-dev libc-ares2 libc-ares-dev glslang-dev glslang-tools)
    # Optional dependencies
    depends+=(libavcodec-dev libavfilter-dev libavutil-dev libswscale-dev qtbase5-dev qtbase5-private-dev libqt5svg5-dev g++-8)
    getDepends "${depends[@]}"
}

function sources_decaf() {
    gitPullOrClone "$md_build" https://github.com/decaf-emu/decaf-emu
}

function build_decaf() {
    mkdir build
    cd build
    export CC=/usr/bin/gcc-8
    export CXX=/usr/bin/g++-8

    if ! isPlatform "rpi"; then
        cmake -DCMAKE_BUILD_TYPE=Release -DDECAF_BUILD_TOOLS=ON -DDECAF_FFMPEG=ON -DDECAF_VULKAN=ON -DDECAF_SDL=ON -DDECAF_QT=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$md_inst" ../
    else
        cmake -DCMAKE_BUILD_TYPE=Release -DDECAF_BUILD_TOOLS=ON -DDECAF_FFMPEG=ON -DDECAF_VULKAN=OFF -DDECAF_SDL=ON -DDECAF_QT=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$md_inst" ../
    fi

    make clean
    make
    md_ret_require="$md_build/build/obj/decaf-cli"
    # decaf-sdl
}

function install_decaf() {
    cd build
    make install
}

function configure_decaf() {
    mkRomDir "wiiu"

    addEmulator 0 "$md_id-cli" "wiiu" "$md_inst/bin/decaf-cli %ROM%"
    addEmulator 1 "$md_id-sdl" "wiiu" "$md_inst/bin/decaf-sdl %ROM%"

    addSystem "wiiu"
}

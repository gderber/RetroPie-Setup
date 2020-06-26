#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="dhewm3"
rp_module_desc="dhewm3 - Doom 3"
rp_module_licence="GPL3 https://raw.githubusercontent.com/dhewm/dhewm3/master/COPYING.txt"
rp_module_help="Please copy
base/pak000.pk4
base/pak001.pk4
base/pak002.pk4
base/pak003.pk4
base/pak004.pk4
base/pak005.pk4
base/pak006.pk4
base/pak007.pk4
base/pak008.pk4

and if you have the expansion:
d3xp/pak000.pk4
d3xp/pak001.pk4
Into the $romdir/doom3/base and $romdir/doom3/d3xp directories"
rp_module_section="exp"
rp_module_flags=""

function depends_dhewm3() {
    getDepends cmake libsdl2-dev libopenal-dev libogg-dev libvorbis-dev zlib1g-dev libcurl4-openssl-dev xorg
}

function sources_dhewm3() {
    gitPullOrClone "$md_build" https://github.com/dhewm/dhewm3.git
}

function build_dhewm3() {
    mkdir $md_build/build

    cd "$md_build/build"

    cmake "../neo"
    make clean
    make
    md_ret_require="$md_build/build"
}

function install_dhewm3() {
    md_ret_files=(
        "build/dhewm3"
        "build/d3xp.so"
        "build/base.so"
    )
}

function configure_dhewm3() {
    if isPlatform "rpi"; then
        addPort "$md_id" "doom3" "Doom 3" "XINIT:$md_inst/dhewm3"
    else
        addPort "$md_id" "doom3" "Doom 3" "$md_inst/dhewm3"
    fi

    mkRomDir "ports/doom3/base"
    mkRomDir "ports/doom3/d3xp"

    moveConfigDir "$md_inst/base" "$romdir/ports/doom3/base"
    moveConfigDir "$md_inst/d3xp" "$romdir/ports/doom3/d3xp"
}

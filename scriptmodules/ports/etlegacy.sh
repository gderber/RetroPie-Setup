#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="etlegacy"
rp_module_desc="etlegacy - ET: Legacy - A Fully compatable Wolfenstein: Enemy Territory 2.60b Client and Server"
rp_module_licence="https://raw.githubusercontent.com/etlegacy/etlegacy/master/COPYING.txt"
rp_module_help=""
rp_module_section="exp"
rp_module_flags=""


function _arch_etlegacy() {
    # exact parsing from Makefile
    echo "$(uname -m | sed -e 's/i.86/x86/' | sed -e 's/^arm.*/arm/')"
}

function depends_etlegacy() {
    getDepends cmake libsdl2-dev libopenal-dev libc6-dev-i386 libx11-dev:i386 libgl1-mesa-dev:i386
}

function sources_etlegacy() {
    gitPullOrClone "$md_build" https://github.com/etlegacy/etlegacy.git
}

function build_etlegacy() {
    local params=(-DCMAKE_BUILD_TYPE=Release -DINSTALL_DEFAULT_BINDIR="$md_inst/" -DINSTALL_DEFAULT_BASEDIR="$romdir/ports/etlegacy")

    if [[ "${md_id}" == "etlegacy_64"]]; then
        params+=(-DCROSS_COMPILE32=0)
    else
        params+=(-DCROSS_COMPILE32=1)
    fi

    if isPlatform "rpi"; then
        params+=(-DARM=1)
    fi

    mkdir "$md_build/build"
    cd "$md_build/build"

    echo "${params[@]}"

    cmake "${params[@]}" ..
    make clean
    make

    md_ret_require="$md_build/build/etl"
}

function install_etlegacy() {
    md_ret_files=(
        "build/etl"
        "build/etlded"
        "build/librenderer_opengl1_$(_arch_etlegacy)"
    )
}

function game_data_etlegacy() {
    downloadAndExtract "https://cdn.splashdamage.com/downloads/games/wet/et260b.x86_full.zip" "$romdi/ports/etlegacy"
}

function configure_etlegacy() {
    addPort "$md_id" "etlegacy" "Wolfenstein - Enemy Territory" "$md_inst/"

    mkRomDir "ports/etlegacy"

    [[ "$md_mode" == "install" ]] && game_data_etlegacy
}

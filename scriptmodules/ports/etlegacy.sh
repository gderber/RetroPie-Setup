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
rp_module_flags="!all x86"


function depends_etlegacy() {
    getDepends cmake libsdl2-dev libopenal-dev #libc6-dev-i386 libx11-dev:i386 libgl1-mesa-dev:i386
}

function sources_etlegacy() {
    gitPullOrClone "$md_build" https://github.com/etlegacy/etlegacy.git
}

function build_etlegacy() {
    mkdir "$md_build/build"
    cd "$md_build/build"
    cmake -D INSTALL_DEFAULT_BINDIR="/opt/retropie/ports/etlegacy/bin/" -D INSTALL_DEFAULT_MODDIR="/opt/retropie/ports/etlegacy/lib/" ..
    cd "$md_build"
    make
    md_ret_require="$md_build/build"
}

function install_etlegacy() {
    md_ret_files=(
        "build/RBDoom3BFG"
        "base/default.cfg"
        "base/extract_resources.cfg"
        "base/renderprogs"
    )
}

function game_data_etlegacy() {
	  mkdir /opt/retropie/ports/etlegacy/base/

    # https://cdn.splashdamage.com/downloads/games/wet/et260b.x86_full.zip

}

function configure_etlegacy() {
    addPort "doom_3_bfg" "doom_3_bfg" "Doom 3 - BFG" "$md_inst/"

    mkRomDir "ports/etlegacy"

    [[ "$md_mode" == "install" ]] && game_data_etlegacy
}

#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="doom3"
rp_module_desc="Doom 3"
rp_module_licence="https://raw.githubusercontent.com/dhewm/dhewm3/master/COPYING.txt"
rp_module_help=""
rp_module_section="exp"
rp_module_flags=""


function depends_doom3() {
    getDepends cmake libsdl2-dev libopenal-dev
}

function sources_doom3() {
    gitPullOrClone "$md_build" https://github.com/dhewm/dhewm3.git
}

function build_doom3() {
    mkdir $md_build/build

    cd "$md_build/build"

    cmake "../neo"
    make
    md_ret_require="$md_build/build"
}

function install_doom3() {
    md_ret_files=(
        "build/dhewm3"
        "build/d3xp.so"
        "build/base.so"
    )
}

function game_data_doom3() {
	  mkdir /opt/retropie/ports/doom3/base/
    mkdir "$home/.doom3/base"
}

function configure_doom3() {
    addPort "doom3" "doom3" "Doom 3" "$md_inst/"

    mkRomDir "ports/doom3"

    moveConfigDir "$home/.doom_3" "$md_conf_root/doom3"
    moveConfigDir "$md_inst/base" "$romdir/ports/doom3"

    [[ "$md_mode" == "install" ]] && game_data_doom3
}

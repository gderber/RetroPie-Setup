#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="doom3_bfg"
rp_module_desc="Doom 3: BFG Edition"
rp_module_licence="https://raw.githubusercontent.com/RobertBeckebans/RBDOOM-3-BFG/master/LICENSE.md"
rp_module_help=""
rp_module_section="exp"
rp_module_flags="!all x86"


function depends_doom3_bfg() {
    getDepends cmake libsdl2-dev libopenal-dev
}

function sources_doom3_bfg() {
    gitPullOrClone "$md_build" https://github.com/RobertBeckebans/RBDOOM-3-BFG.git
}

function build_doom3_bfg() {
    cd "$md_build/neo"
    ./cmake-eclipse-linux-profile.sh

    cd "$md_build/build"
    make
    md_ret_require="$md_build/build"
}

function install_doom3_bfg() {
    md_ret_files=(
        "build/RBDoom3BFG"
        "base/default.cfg"
        "base/extract_resources.cfg"
        "base/renderprogs"
    )
}

function game_data_doom3_bfg() {
	  mkdir /opt/retropie/ports/doom3_bfg/base/
    mkdir "$home/.doom3/base"
}

function configure_doom3_bfg() {
    addPort "doom3_bfg" "doom3_bfg" "Doom 3 - BFG" "$md_inst/"

    mkRomDir "ports/doom3_bfg"

    moveConfigDir "$home/.doom_3" "$md_conf_root/doom3_bfg"
    moveConfigDir "$md_inst/base" "$romdir/ports/doom3_bfg"

    [[ "$md_mode" == "install" ]] && game_data_doom3_bfg
}

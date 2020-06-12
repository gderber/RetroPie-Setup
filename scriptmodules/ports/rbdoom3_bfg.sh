#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="rbdoom3_bfg"
rp_module_desc="rbdoom3_bfg - Doom 3: BFG Edition"
rp_module_licence="GPL3 https://raw.githubusercontent.com/RobertBeckebans/RBDOOM-3-BFG/master/LICENSE.md"
rp_module_help="For the game data, from your windows install (Gog or Steam) locate the 'base' directory.  Copy ALL contents to $romdir/ports/doom3_bfg"
rp_module_section="exp"
rp_module_flags=""

function depends_rbdoom3_bfg() {
    getDepends cmake libsdl2-dev libopenal-dev
}

function sources_rbdoom3_bfg() {
    gitPullOrClone "$md_build" https://github.com/RobertBeckebans/RBDOOM-3-BFG.git
}

function build_rbdoom3_bfg() {
    cd "$md_build/neo"
    ./cmake-eclipse-linux-profile.sh

    cd "$md_build/build"
    make clean
    make
    md_ret_require="$md_build/build/RBDoom3BFG"
}

function install_rbdoom3_bfg() {
    md_ret_files=(
        "build/RBDoom3BFG"
        "base/default.cfg"
        "base/extract_resources.cfg"
        "base/renderprogs"
    )
}

function configure_rbdoom3_bfg() {
    addPort "rbdoom3_bfg" "rbdoom3_bfg" "Doom 3 - BFG" "$md_inst/RBDoom3BFG"

    mkRomDir "ports/rbdoom3_bfg"

    moveConfigDir "$home/.doom_3" "$md_conf_root/rbdoom3_bfg"
    moveConfigDir "$md_inst/base" "$romdir/ports/doom3_bfg"

    if [[ "$md_mode" == "install" ]]; then
        mkdir /opt/retropie/ports/rbdoom3_bfg/base/
        mkdir "$home/.doom3/base"
    fi
}

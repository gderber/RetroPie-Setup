#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="gzdoom"
rp_module_desc="gzdoom - DOOM source port"
rp_module_licence="GPL3 https://github.com/drfrag666/gzdoom/blob/g3.3mgw/docs/licenses/README.TXT"
rp_module_section="exp"
rp_module_flags=""

function depends_gzdoom() {
    depends_lzdoom
}

function sources_gzdoom() {
    gitPullOrClone "$md_build" https://github.com/drfrag666/gzdoom "g4.3.3"
}

function build_gzdoom() {
    build_lzdoom
}

function install_gzdoom() {
    md_ret_files=(
        'release/brightmaps.pk3'
        'release/gzdoom'
        'release/gzdoom.pk3'
        'release/lights.pk3'
        'release/game_support.pk3'
        'release/soundfonts'
        'README.md'
    )
}

function add_games_gzdoom() {
    add_games_lzdoom
}

function configure_gzdoom() {
    configure_lzdoom
}

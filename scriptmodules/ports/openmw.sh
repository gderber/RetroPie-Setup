#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="openmw"
rp_module_desc="openmw - Morrowind source port"
rp_module_licence="GPL3 https://gitlab.com/OpenMW/openmw/-/raw/master/LICENSE"
rp_module_section="exp"
rp_module_flags=""

function depends_openmw() {
    getDepends libsdl2-dev libgl1-mesa-dev
}

function sources_openmw() {
    gitPullOrClone "$md_build" https://gitlab.com/OpenMW/openmw.git
}

function build_openmw() {
    mkdir $md_build/build
    cd $md_build/build
    cmake ..

    make clean
    make
}

function _arch_openmw() {
    # exact parsing from Makefile
    echo "$(uname -m | sed -e 's/i.86/x86/' | sed -e 's/^arm.*/arm/')"
}

function install_openmw() {
    md_ret_files=(
        "build/release-linux-$(_arch_openmw)/openmw.$(_arch_openmw)"
    )
}

function configure_openmw() {
    local launcher=("$md_inst/openmw.$(_arch_openmw)")

    addPort "$md_id" "morrowind" "The Elder Scrolls III - Morrowind" "${launcher[*]}"

    mkRomDir "ports/morrowind"
}

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
MD5 (base/pak000.pk4) = 71b8d37b2444d3d86a3661783844fe
MD5 (base/pak001.pk4) = 4bc4f3ba04ec2b4f4837be40e840a3c1
MD5 (base/pak002.pk4) = fa84069e9642ad9aa4b49624150cc345
MD5 (base/pak003.pk4) = f22d8464997924e4913e467e7d62d5fe
MD5 (base/pak004.pk4) = 38561a3c73f93f2e631abf1d4e9102
MD5 (base/pak005.pk4) = 2a4ece27d36393b7538d55a345b90d
MD5 (base/pak006.pk4) = a6e7003fa9dcc75073dc02b56399b370
MD5 (base/pak007.pk4) = 6319f086f930ec1618ab09b4c20c268c
MD5 (base/pak008.pk4) = 28750b7841de9453eb335bad6841a2a5

and
MD5 (d3xp/pak000.pk4) = a883fef010aadeb73d34c462ff865d
MD5 (d3xp/pak001.pk4) = 06fc9be965e345587064056bf22236d2
Into the $romdir/doom3/base and $romdir/doom3/d3xp directories"
rp_module_section="exp"
rp_module_flags=""

function depends_dhewm3() {
    getDepends cmake libsdl2-dev libopenal-dev
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
    addPort "$md_id" "doom3" "Doom 3" "$md_inst/dhewm3"

    mkRomDir "ports/doom3/base"
    mkRomDir "ports/doom3/d3xp"

    moveConfigDir "$md_inst/base" "$romdir/ports/doom3/base"
    moveConfigDir "$md_inst/d3xp" "$romdir/ports/doom3/d3xp"

    # Forgot why I added this
    #if [[ "$md_mode" == "install" ]]; then
    #    mkdir /opt/retropie/ports/doom3/base/
    #    mkUserDir "$md_conf_root/doom3"
    #fi
}

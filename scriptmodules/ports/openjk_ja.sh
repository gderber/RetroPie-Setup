
#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="openjk_ja"
rp_module_desc="openjk_ja - OpenJK (JediAcademy)"
rp_module_licence="https://raw.githubusercontent.com/JACoders/OpenJK/master/LICENSE.txt"
rp_module_help="Installs OpenJK built for JediAcademy (SP + MP)"
rp_module_section="exp"
rp_module_flags=""

function _arch_openjk_ja() {
    # exact parsing from Makefile
    echo "$(uname -m | sed -e 's/i.86/x86/' | sed -e 's/^arm.*/arm/')"
}


function depends_openjk_ja() {
    getDepends build-essential cmake libjpeg-dev libpng-dev zlib1g-dev libsdl2-dev

}

function sources_openjk_ja() {
    gitPullOrClone "$md_build" https://github.com/JACoders/OpenJK.git
}

function build_openjk_ja() {
    mkdir "$md_build/build"
    cd "$md_build/build"
    cmake -DCMAKE_INSTALL_PREFIX="$romdir/ports/jediacademy" ..
    make clean
    make

    md_ret_require="$md_build/build"
}

function install_openjk_ja() {
    md_ret_files=(
        "build/openjkded.$(_arch_openjk_ja)"
        "build/openjk_sp.$(_arch_openjk_ja)"
        "build/openjk.$(_arch_openjk_ja)"
    )
}

function game_data_openjk_ja() {
	  mkdir /opt/retropie/ports/openjk_ja/
}

function configure_openjk_ja() {
    addPort "openjk_ja" "openjk_sp.$(_arch_openjk_ja)" "Jedi Academy (SP)" "$md_inst/"
    addPort "openjk_ja" "openjk.$(_arch_openjk_ja)" "Jedi Academy (MP)" "$md_inst/"

    mkRomDir "ports/jediacademy"

    moveConfigDir "$md_inst/base" "$romdir/ports/jediacademy"
    #moveConfigDir "$home/.q3a" "$md_conf_root/ioquake3"

    [[ "$md_mode" == "install" ]] && game_data_openjk_ja
}

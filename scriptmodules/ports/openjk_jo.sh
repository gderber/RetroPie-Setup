
#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="openjk_jo"
rp_module_desc="openjk_jo - OpenJK: Jedi Outcast (SP)"
rp_module_licence="GPL2 https://raw.githubusercontent.com/JACoders/OpenJK/master/LICENSE.txt"
rp_module_help="Copy assets0.pk3  assets1.pk3  assets2.pk3  assets5.pk3 into $romdir/jedioutcast/"
rp_module_section="exp"
rp_module_flags=""

function _arch_openjk_jo() {
    # exact parsing from Makefile
    echo "$(uname -m | sed -e 's/i.86/x86/' | sed -e 's/^arm.*/arm/')"
}

function depends_openjk_jo() {
    getDepends build-essential cmake libjpeg-dev libpng-dev zlib1g-dev libsdl2-dev

}

function sources_openjk_jo() {
    gitPullOrClone "$md_build" https://github.com/JACoders/OpenJK.git
}

function build_openjk_jo() {
    mkdir "$md_build/build"
    cd "$md_build/build"
    cmake -DBuildJK2SPEngine=ON -DBuildJK2SPGame=ON -DBuildJK2SPRdVanilla=ON -DCMAKE_INSTALL_PREFIX="$md_inst" ..
    make clean
    make

    md_ret_require="$md_build/build/openjk_sp.$(_arch_openjk_jo)"
}

function install_openjk_jo() {
    md_ret_files=(
        "build/code/game/jagame$(_arch_openjk_jo).so"
        "build/code/rd-vanilla/rdjosp-vanilla_$(_arch_openjk_jo).so"
        "build/code/rd-vanilla/rdsp-vanilla_$(_arch_openjk_jo).so"
        "build/codeJK2/game/jospgame$(_arch_openjk_jo).so"
        "build/codemp/cgame/cgame$(_arch_openjk_jo).so"
        "build/codemp/game/jampgame$(_arch_openjk_jo).so"
        "build/codemp/rd-vanilla/rd-vanilla_$(_arch_openjk_jo).so"
        "build/codemp/ui/ui$(_arch_openjk_jo).so"
        "build/openjo_sp.$(_arch_openjk_jo)"
    )
}

function configure_openjk_jo() {
    local launcher_jo_sp=("$md_inst/openjo_sp.$(_arch_openjk_jo) +set com_jk2 1")
    isPlatform "mesa" && launcher_jo_sp+=("+set cl_renderer opengl1")
    isPlatform "kms" && launcher_jo_sp+=("+set r_mode -1" "+set r_customwidth %XRES%" "+set r_customheight %YRES%" "+set r_swapInterval 1")

    addPort "$md_id" "jedioutcast_sp" "Star Wars - Jedi Knight - Jedi Outcast (SP)" "${launcher_jo_sp[*]}"

    mkRomDir "ports/jedioutcast"

    moveConfigDir "$md_inst/base" "$romdir/ports/jedioutcast"
}

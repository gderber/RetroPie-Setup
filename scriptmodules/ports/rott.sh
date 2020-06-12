#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="rott"
rp_module_desc="rott - Rise of the Triad - Dark Wark"
rp_module_licence="GPL2 http://svn.icculus.org/*checkout*/rott/trunk/COPYING?revision=234"
rp_module_help="For the full version, you must add/replace the following files:
darkwar.rtc
darkwar.rtl
darkwar.wad
extreme.rtl # Maybe
huntbgin.rtc
huntbgin.rtl
remote1.rts
rottcd.rtc
rottsite.rtc
"
rp_module_section="exp"
rp_module_flags="!mali"

function depends_rott() {
    getDepends libsdl1.2-dev libsdl-mixer1.2-dev automake autoconf subversion unzip
}

function sources_rott() {
    svn checkout svn://svn.icculus.org/rott/trunk/
}

function build_rott() {
    local opts

    cd $md_build/trunk
    if [[ ! -f $romdir/darkwar.rtc ]]; then
        opts="--enable-shareware"
    fi

    autoreconf -fiv
    ./configure --prefix="$md_inst" --enable-datadir="$romdir/ports/$md_id/" $opts
    make
    md_ret_require=(
        "$md_build/trunk/rott/rott"
    )
}

function install_rott() {
    md_ret_files=("trunk/rott/rott")
}

function game_data_rotto() {
    pushd "$romdir/ports/$md_id"
    rename 'y/A-Z/a-z/' *
    popd

    if [[ ! -f $romdir/ports darkwar.rtc && ! -f $romdir/ports/huntbgin.rtc ]]; then
        wget "http://icculus.org/rott/share/1rott13.zip" -O $md_build/1rott13.zip
        downloadAndExtract $md_build/1rott13.zip $md_build/rottsw13.shr
        unzip -L -o rottsw13.shr -d "$md_inst" huntbgin.wad huntbgin.rtc huntbgin.rtl remote1.rts
    fi
}
function configure_rott() {
    mkRomDir "ports/$md_id"

    if [[ "$md_mode" == "install" ]]; then
        game_data_rott
    fi

    moveConfigDir "$home/.rott" "$md_conf_root/rott"

    if [[ ! -f $romdir/darkwar.rtc ]]; then
        addPort "$md_id" "rott" "Rise of the Triad - The Hunt Begins" "$md_inst/bin/rott"
    else
        addPort "$md_id" "rott" "Rise of the Triad - Dark War" "$md_inst/bin/rott"
    fi
}

#!/bin/bash
set -e

code_root=$1
clean_repo=$2
start_rk_build=$3
echo 'begin OH code sync'

cd $code_root
if [ "$clean_repo" == true ]; then
    echo 'clean repo'
    repo forall -j4 -c 'git reset HEAD --hard; git clean -dfx'
    rm -rf out
fi
repo sync -c -j4 --force-sync 
repo forall -j4 -c 'git lfs pull'
./build/prebuilts_download.sh
if [ "$start_rk_build" == true ]; then
    echo 'start rk build'
    ./build.sh --product-name rk3568
fi

echo 'OH code sync success'

#!/bin/bash
# set -e

echo 'Add ts repo begin'
code_root=$1
cd $code_root
repo forall -j4 -c 'git config --local user.email tianshi.liu@huawei.com'
git config --local user.name 'Tianshi Liu' 
pushd base/user_iam/face_auth > /dev/null
    git remote remove tianshi
    git remote add tianshi git@gitee.com:tianshi_liu/useriam_faceauth
    git fetch origin --unshallow
pushd > /dev/null
pushd base/user_iam/pin_auth > /dev/null
    git remote remove tianshi
    git remote add tianshi git@gitee.com:tianshi_liu/useriam_pin_auth
    git fetch origin --unshallow
pushd > /dev/null
pushd base/user_iam/user_auth > /dev/null
    git remote remove tianshi
    git remote add tianshi git@gitee.com:tianshi_liu/useriam_user_auth
    git fetch origin --unshallow
pushd > /dev/null
pushd drivers/interface > /dev/null
    git remote remove tianshi
    git remote add tianshi git@gitee.com:tianshi_liu/drivers_interface
    git fetch origin --unshallow
pushd > /dev/null
pushd drivers/peripheral > /dev/null
    git remote remove tianshi
    git remote add tianshi git@gitee.com:tianshi_liu/drivers_peripheral
    git fetch origin --unshallow
pushd > /dev/null

echo 'Add ts repo success'

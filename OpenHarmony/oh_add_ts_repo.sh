#!/bin/bash
# set -e

echo 'Add ts repo begin'
code_root=$1
cd $code_root
pushd base/user_iam/face_auth > /dev/null
    git remote remove tianshi
    git remote add tianshi git@gitee.com:openharmony/useriam_faceauth
pushd > /dev/null
pushd base/user_iam/pin_auth > /dev/null
    git remote remove tianshi
    git remote add tianshi git@gitee.com:openharmony/useriam_pin_auth
pushd > /dev/null
pushd base/user_iam/user_auth > /dev/null
    git remote remove tianshi
    git remote add tianshi git@gitee.com:openharmony/useriam_user_auth
pushd > /dev/null
pushd drivers/interface > /dev/null
    git remote remove tianshi
    git remote add tianshi git@gitee.com:openharmony/drivers_interface
pushd > /dev/null
pushd drivers/peripheral > /dev/null
    git remote remove tianshi
    git remote add tianshi git@gitee.com:openharmony/drivers_peripheral
pushd > /dev/null

echo 'Add ts repo success'

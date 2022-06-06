#! /bin/bash
set -e
set -x
cd /root/oh_hap_to_build
# find . -type f | grep -E '\.hap' | xargs rm
npm install
npm run buildOhosHaps
find . -type f | grep -E '\.hap' | xargs realpath
/root/tools/sign_tool/sign_hap.sh /root/oh_hap_to_build/entry/build/default/outputs/default/entry-default-unsigned.hap /root/oh_hap_to_build/Settings_FaceAuth.hap 'com.ohos.settings.faceauth'
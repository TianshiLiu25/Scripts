#!/bin/bash
set -e
set -x

cd /home/tianshi/code/OpenHarmony_L2/code/
ninja -C out/rk3568 faceauthservice
ninja -C out/rk3568 userauth_executors
ninja -C out/rk3568 FaceAuthServiceUnitTest 

hdc list targets
hdc shell mount -o rw,remount /vendor
hdc shell mount -o rw,remount /
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/lib.unstripped/useriam/face_auth/libfaceauthservice.z.so /system/lib/libfaceauthservice.z.so
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/lib.unstripped/useriam/user_auth/libuserauth_executors.z.so /system/lib/libuserauth_executors.z.so
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/tests/unittest/user_iam/face_auth/FaceAuthServiceUnitTest /data/FaceAuthServiceUnitTest
hdc shell chmod +x /data/FaceAuthServiceUnitTest
hdc shell /data/FaceAuthServiceUnitTest

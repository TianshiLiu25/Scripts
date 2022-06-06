#!/bin/bash
set -e
set -x

cd /home/tianshi/code/OpenHarmony_L2/code/
ninja -C out/rk3568 userauth_executors faceauth faceauth_framework UserAuthExecutorsFuzzTest user_auth_executors_test

hdc list targets
hdc shell mount -o rw,remount /vendor
hdc shell mount -o rw,remount /
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/lib.unstripped/useriam/user_auth/libuserauth_executors.z.so /system/lib64/libuserauth_executors.z.so
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/exe.unstripped/tests/fuzztest/user_iam/user_auth/user_auth/UserAuthExecutorsFuzzTest /data/UserAuthExecutorsFuzzTest
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/exe.unstripped/tests/unittest/user_auth/user_auth_executors_test/user_auth_executors_test /data/user_auth_executors_test
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/lib.unstripped/useriam/face_auth/libfaceauth.z.so /system//lib64/module/libfaceauth.z.so
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/lib.unstripped/useriam/face_auth/libfaceauth_framework.z.so /system/lib64/libfaceauth_framework.z.so
hdc shell chmod +x /data/UserAuthExecutorsFuzzTest
hdc shell chmod +x /data/user_auth_executors_test

echo '/data/UserAuthExecutorsFuzzTest'
echo '/data/user_auth_executors_test'

echo "success"
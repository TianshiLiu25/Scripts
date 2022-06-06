#!/bin/bash
set -e
set -x

cd /home/tianshi/code/OpenHarmony_L2/code/
ninja -C out/rk3568 hdf_faceauth_service
ninja -C out/rk3568 FaceAuthHdiFuzzTest

hdc list targets
hdc shell mount -o rw,remount /vendor
hdc shell mount -o rw,remount /
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/lib.unstripped/hdf/faceauth_device_driver/libface_auth_interface_service_1.0.z.so  /vendor/lib/libface_auth_interface_service_1.0.z.so
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/exe.unstripped/tests/fuzztest/face_auth/face_auth/FaceAuthHdiFuzzTest /data/FaceAuthHdiFuzzTest
hdc shell chmod +x /data/FaceAuthHdiFuzzTest
hdc shell /data/FaceAuthHdiFuzzTest -max_len=1000 -max_total_time=300 -rss_limit_mb=4096

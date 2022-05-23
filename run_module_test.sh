#!/bin/bash
set -e
set -x

hdc list targets
hdc shell mount -o rw,remount /vendor
hdc shell mount -o rw,remount /
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/lib.unstripped/hdf/faceauth_device_driver/libface_auth_interface_service_1.0.z.so /vendor/lib/libface_auth_interface_service_1.0.z.so
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/tests/moduletest/driver/peripheral/face_auth/FaceAuthHdiModuleTest /data/FaceAuthHdiModuleTest
hdc shell chmod +x /data/FaceAuthHdiModuleTest
hdc shell /data/FaceAuthHdiModuleTest

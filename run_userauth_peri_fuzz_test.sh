#!/bin/bash
set -e
set -x

cd /home/tianshi/code/OpenHarmony_L2/code/
ninja -C out/rk3568 libuser_auth_interface_service_1.0
ninja -C out/rk3568 UserAuthHdiFuzzTest

hdc list targets
hdc shell mount -o rw,remount /vendor
hdc shell mount -o rw,remount /
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/lib.unstripped/hdf/user_auth_device_driver/libuser_auth_interface_service_1.0.z.so /vendor/lib/libuser_auth_interface_service_1.0.z.so
hdc file send /home/tianshi/code/OpenHarmony_L2/code/out/rk3568/exe.unstripped/tests/fuzztest/hdf/user_auth/UserAuthHdiFuzzTest /data/UserAuthHdiFuzzTest
hdc shell chmod +x /data/UserAuthHdiFuzzTest
hdc shell /data/UserAuthHdiFuzzTest -max_len=2000 -max_total_time=300 -rss_limit_mb=4096

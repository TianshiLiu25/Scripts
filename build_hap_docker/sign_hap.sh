#!/bin/bash
set -e

# input files:
# UnsgnedReleasedProfileTemplate.json
# OpenHarmony.p12
# OpenHarmonyApplication.pem
# OpenHarmonyProfileRelease.pem

# out file:
# myApplication_ohos_Provision.p7b

CURR_DIR=$(dirname $(realpath $0))
WK_DIR=$CURR_DIR/log/"$(date +"%y%m%d_%H%M%S")"

SIGN_TOOL_DIR=$CURR_DIR/signcenter_tool
IN_APK=$(realpath $1)
OUT_APK=$(realpath $2)
HAP_BUNDLE_NAME=$3
HAP_NAME=`echo ${HAP_BUNDLE_NAME##*.}`
echo $HAP_BUNDLE_NAME $HAP_NAME

cd $CURR_DIR

if [[ ! -d $SIGN_TOOL_DIR ]]; then
    git clone https://gitee.com/openharmony/signcenter_tool --depth=1 $SIGN_TOOL_DIR
fi

mkdir -p $WK_DIR

if test -f "$IN_APK";
then
    echo "input hap exist"
else
    echo "input apk $IN_APK not exist"
    exit 1
fi

sed "s/replace_target/$HAP_BUNDLE_NAME/g" UnsignedReleasedProfileTemplate.json > $WK_DIR/UnsignedReleasedProfile.json

java -jar hap-sign-tool.jar sign-profile -mode "localSign" -keyAlias "OpenHarmony Application Profile Release" -keyPwd "123456" -inFile "$WK_DIR/UnsignedReleasedProfile.json" -outFile $WK_DIR/"$HAP_NAME"_ohos_Provision.p7b -keystoreFile "$SIGN_TOOL_DIR/key/OpenHarmony.p12" -keystorePwd "123456"  -signAlg "SHA256withECDSA" -profileCertFile "$SIGN_TOOL_DIR/certificates/OpenHarmonyProfileRelease.pem" -validity "365" -developer-id "ohosdeveloper"
java -jar $SIGN_TOOL_DIR/hapsigntool/hapsigntoolv2.jar sign -mode localjks -privatekey "OpenHarmony Application Release" -inputFile $IN_APK -outputFile $OUT_APK -keystore "$SIGN_TOOL_DIR/key/OpenHarmony.p12" -keystorepasswd 123456 -keyaliaspasswd 123456 -signAlg SHA256withECDSA -profile $WK_DIR/"$HAP_NAME"_ohos_Provision.p7b -certpath "$SIGN_TOOL_DIR/certificates/OpenHarmonyApplication.pem"

echo
echo
echo "================================="
echo "HAP_BUNDLE_NAME: $HAP_BUNDLE_NAME"
echo "HAP_NAME:        $HAP_NAME"
echo "IN_APK:          $IN_APK"
echo "OUT_APK:         $OUT_APK"
echo "================================="
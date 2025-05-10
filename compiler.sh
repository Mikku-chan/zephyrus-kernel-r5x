#!/bin/bash
# copy right by zetaxbyte
# you can rich me on telegram t.me/@zetaxbyte

DATE=$(date '+%y%m%d')
cyan="\033[96m"
green="\033[92m"
red="\033[91m"
blue="\033[94m"
yellow="\033[93m"
normal="\033[0m"

if ! [ -d $(pwd)/../clang-r530567 ] ; then
echo -e "\n $red clang-r530567 dir not found!!! $normal \n"
sleep 1
echo -e "$yellow wait.. Dwonloading clang-r530567... $normal \n"
sleep 1
mkdir -p $(pwd)/../clang-r530567 ; wget -P $(pwd)/../clang-r530567/ https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/main/clang-r530567.tar.gz ; sleep 2 ; tar -xf $(pwd)/../clang-r530567/clang-r530567.tar.gz -C $(pwd)/../clang-r530567/ && rm -rf $(pwd)/../clang-r530567.tar.gz && ls $(pwd)/../clang-r530567
sleep 1
echo
echo -e "\n $green okay Downloading done... $normal \n"
sleep 1
fi

echo -e "$cyan=========================== $normal"
echo -e "$cyan= START COMPILING KERNEL  = $normal"
echo -e "$cyan=========================== $normal"

echo -e "$blue...LOADING... $normal"

echo -e -ne "$green## (10%\r"
sleep 0.7
echo -e -ne "$green#####                     (33%)\r"
sleep 0.7
echo -e -ne "$green#############             (66%)\r"
sleep 0.7
echo -e -ne "$green#######################   (100%)\r"
echo -ne "\n"

echo -e -n "$yellow\033[104m RUNNING... BUILD \033[0m"
echo

# change DEFCONFIG to you are defconfig name or device codename

DEFCONFIG="vendor/RMX1911_defconfig"

# you can set you name or host name(optional)

export KBUILD_BUILD_USER=t.me@mikkuchan
export KBUILD_BUILD_HOST=MikuChan

# change TC_DIR(directory) on where you clone proton-clang toolchain

TC_DIR=$(pwd)/../clang-r530567

# do not modify export PATCH it's been including with TC_DIR

export PATH="$TC_DIR/bin:$PATH"

COMPILE_START=$(date +"%s")

mkdir -p out
make O=out ARCH=arm64 $DEFCONFIG

KCFLAGS="-O3" make -j$(nproc --all) O=out ARCH=arm64 CC=clang LD=ld.lld AR=llvm-ar AS=llvm-as NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- 2>&1 | tee log.txt

if [[ -f out/arch/arm64/boot/Image.gz ]] ; then
COMPILE_END=$(date +"%s")
COMPILE_TIME=$((COMPILE_END - COMPILE_START))
echo -e "\n $yellow BUILD COMPLITE  $((COMPILE_TIME / 60)) minute(s) and $((COMPILE_TIME % 60)) second(s) \n"
    echo -e "$cyan===========================\033[0m"
    echo -e "$cyan=  SUCCESS COMPILE KERNEL =\033[0m"
    echo -e "$cyan===========================\033[0m"
sleep 0.5
else
COMPILE_END=$(date +"%s")
COMPILE_TIME=$((COMPILE_END - COMPILE_START))
echo -e "\n $red BUILD FAILED  $((COMPILE_TIME / 60)) minute(s) and $((COMPILE_TIME % 60)) second(s) \n"
echo -e "$red!ups...something wrong!?\033[0m"
fi

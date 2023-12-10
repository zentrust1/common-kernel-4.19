#!/bin/bash
# Copyright cc 2022 anothermi

# Variabel konfigurasi
KERNEL_CONFIG="stock_defconfig"
CROSS_COMPILE_PREFIX="arm-linux-gnueabi-"

# Pesan output yang jelas
function init() {
    echo "==========================="
    echo "= START COMPILING KERNEL  ="
    echo "==========================="
}

# Konfigurasi dan kompilasi kernel
function compile() {
    echo "Configuring kernel..."
    make -j$(nproc --all) O=out ARCH=arm $KERNEL_CONFIG || { echo "Failed to configure kernel"; exit 1; }

    echo "Compiling kernel..."
    make -j$(nproc --all) ARCH=arm O=out CROSS_COMPILE=$CROSS_COMPILE_PREFIX || { echo "Kernel compilation failed"; exit 1; }
}

# Pesan output setelah selesai
function end() {
    echo "==========================="
    echo "   KERNEL COMPILATION COMPLETE  "
    echo "==========================="
}

# Eksekusi
init
compile
end

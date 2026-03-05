#!/bin/bash
set -e
TOOLCHAIN=./toolchains/rpi-zero2w.cmake
BUILD_DIR=build
TARGET_USER=root
TARGET_RPI=RspiZ.local
TARGET_PATH_APP=/root
TARGET_PATH_LIB=/lib

cmake -B $BUILD_DIR -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN
cmake --build $BUILD_DIR

echo "Deploying to $TARGET_RPI..."
scp "$BUILD_DIR/rpiapp" "$TARGET_USER@$TARGET_RPI:$TARGET_PATH_APP/"
scp "$BUILD_DIR/libbar-build/libbar.so" "$TARGET_USER@$TARGET_RPI:$TARGET_PATH_LIB/"

echo "Deployment finished"
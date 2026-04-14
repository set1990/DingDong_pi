#!/bin/bash
set -e
TOOLCHAIN=./toolchains/rpi-zero2w.cmake
BUILD_DIR=build
TARGET_USER=root
TARGET_RPI=RspiZ.local
TARGET_PATH_APP=/root
TARGET_PATH_LIB=/lib
DEBUG=Release
CLEAN=0
TARGET=0
ONLY=0

function usage() {
   echo "Options:"
   echo " -d|--debug : build with symbols"
   echo " -c|--clean : clean build result"
   echo " -t|--target : deploy on target"
   echo " -o|--only : without build"
   echo " -h|--help : displays this message"
   echo ""
}

while [[ $# -gt 0 ]]; do
   key="$1"

   case $key in
      -h|--help)
         usage
         exit 0
         ;;
      -d|--debug)
         DEBUG=Debug
         shift
         ;;
      -c|--clean)
         CLEAN=1
         shift
         ;;
      -t|--target)
         TARGET=1
         shift
         ;;
      -o|--only)
         ONLY=1
         shift
         ;;
      *)    # unknown option
         echo "Unkown option: $key"
         usage
         exit 1
         ;;
   esac
done

if [[ $CLEAN -eq 1 ]]; then
   echo "Cleaning result" 
   rm -rf build
   echo "Clean finished"
fi

if [[ $ONLY -eq 0 ]]; then
   echo "Building type $DEBUG..."
   cmake -B $BUILD_DIR -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN -DCMAKE_BUILD_TYPE=$DEBUG -DCMAKE_CXX_FLAGS="-O0" 
   cmake --build $BUILD_DIR
   echo "Build finished"
fi

if [[ $TARGET -eq 1 ]]; then
   echo "Deploying to $TARGET_RPI..."
   scp "$BUILD_DIR/rpiapp" "$TARGET_USER@$TARGET_RPI:$TARGET_PATH_APP/"
   scp "$BUILD_DIR/libbar-build/libbar.so" "$TARGET_USER@$TARGET_RPI:$TARGET_PATH_APP/"
   echo "Deployment finished"
   #export LD_LIBRARY_PATH=/root
fi

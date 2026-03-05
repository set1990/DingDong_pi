# RPi Cross Compile Template (Static + Shared + Auto Deploy)
## 0. Tworzenie obrazu
sudo ./build_image.sh \
--ssid "STOR_PIKK2" \
--psk "Kutarate3000" \
--hostname RspiZ \
--sshkey ~/.ssh/id_ed25519.pub \
--img-size 5120
sudo dd if=arch-rspiz.img of=/dev/sdX bs=4M status=progress
ssh -i ~/.ssh/id_ed25519 root@RspiZ.local
## 1. Instalacja toolchain 
sudo apt update
sudo apt install \
build-essential \
cmake \
make \
gcc-arm-linux-gnueabihf \
g++-arm-linux-gnueabihf \
binutils-arm-linux-gnueabihf \
gdb-multiarch \
rsync \
pkg-config \
ccache
## 2. Skopiuj sysroot z Raspberry
mkdir -p ./sysroot
rsync -avz --delete root@RspiZ.local:/lib :/usr ./sysroot/
## 3. Build i deploy
./build.sh
## 4. Uruchomienie
ssh alarm@RspiZ.local
export LD_LIBRARY_PATH=/home/alarm
./rpiapp
## 5. Debug
# Na Raspberry
gdbserver :1234 ./rpiapp
# Na Ubuntu
gdb-multiarch build/rpiapp
(gdb) set sysroot ~/rpi-toolchain/sysroot
(gdb) target remote RspiZ.local:1234

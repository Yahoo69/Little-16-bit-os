clear
cd "YOUR REPOZITORY LOCATION"
nasm boot/bootloader.asm -f bin -o bootloader.bin
xxd bootloader.bin
ls
qemu-system-i386 -hda ./bootloader.bin


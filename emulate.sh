clear
cd "/home/yahoo/Desktop/asembley-nauka/asembler/14 system"
nasm boot/bootloader.asm -f bin -o bootloader.bin
xxd bootloader.bin
ls
qemu-system-i386 -hda ./bootloader.bin


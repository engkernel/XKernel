all:
	# Build Bootloader
	as -o build/boot/boot.o boot/boot.s
	ld -o ./bin/boot.bin --oformat binary -e start -Ttext 0x7c00 \
		-o ./bin/boot.bin build/boot/boot.o 

#ld -o ./bin/boot.bin --oformat binary -e start -Ttext 0x7c00 \
		-o ./bin/boot.bin build/boot/boot.o

clean:
	rm build/boot/boot.o
	rm bin/boot.bin

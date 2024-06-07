.code16
.global start

.equ CODE_SEG, gdt_code - gdt_start
.equ DATA_SEG, gdt_data - gdt_start


start:
	cli	# clear interrupts
	movw $0x00, %ax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %ss
	movw $0x7c00, %sp
	sti	# enable interrupts
.load_protected:
	cli 
	lgdt gdt_descriptor
	movl %cr0, %eax
	orl $0x1, %eax
	movl %eax, %cr0
	jmp $CODE_SEG, $load32

# Define GDT descriptor
gdt_start:
gdt_null:
	.word 0x0 # Null descriptor
	.word 0x0 # Null descriptor

# offest 0x8
gdt_code:
	.word 0xffff	# segment length
	.word 0x0	# base address (bits 0-15)
	.byte 0		# base address (bits 16-23)
	.byte 0x9a	# access byte (data segment)
	.byte 0xcf 	# high 4 bit flags and the 4 low bit flags
	.byte 0		# base 24-31

# offset 0x10
gdt_data:
	.word 0xffff    # segment length
        .word 0x0       # base address (bits 0-15)
        .byte 0         # base address (bits 16-23)
        .byte 0x92      # access byte (data segment)
	.byte 0xcf	# high 4 bit flags and the 4 low bit flags
        .byte 0         # base 24-31
gdt_end:
gdt_descriptor:
	.word gdt_end - gdt_start - 1
	.long gdt_start


.code32
load32:
	mov $1, %eax
	mov $100, %ecx
	mov 0x0100000, %edi
	# now I need a kernel that to be read from hard 
	# but for now I just jmp to test the code
	jmp .
	
.fill 510-(.-start), 1, 0 # add zero to fill 510 byte
.word 0xaa55

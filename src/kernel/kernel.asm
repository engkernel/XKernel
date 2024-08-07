[BITS 32]

extern kernel_start

DATA_SEG equ 0x8
CODE_SEG equ 0x10

; load32
load32:
        mov ax, DATA_SEG
        mov ds, ax
	mov es, ax
        mov fs, ax
        mov gs, ax
        mov ss, ax
        mov ebp, 0x00200000
        mov esp, ebp

	; Enable A20 line
	in al, 0x92
	or al, 2
	out 0x92, al

	call kernel_start

        jmp $

times 512-($-$$) db 0

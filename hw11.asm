	;;Compile with: nasm -f elf hw11.asm
	;; ld -m elf_i386 hw11.o -o hw11
	;;Run with: ./hw11
	;;Tyler Vierbuchens code
	
	SECTION .data
	inputbuf db  0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A

	SECTION .bss
	outputbuf resb 80

	SECTION .text
	global  _start

_start:

;;clears all registers
xor ESI,ESI ;zero out ESI
xor EDI,EDI ;zero out EDI
xor AL,AL
xor AH,AH
xor AX,AX

;;the loop to translate values to ASCII values
loop:

;;moves values from inputbuf to 8 bit registers, one to store the upper and lower half of the hex number
mov AL,[inputbuf + ESI]
mov AH,[inputbuf + ESI]

;;masking to isolate each hex value and shift the contents of AH to the right
and AL,0x0F
and AH,0xF0
shr AH,4

;;compares the value of AL to A, jumps to different code based on if it is lower or greater than or equal to A
cmp AL,0x0A
jl AL_less_than_A
jge AL_equal_or_greater_A

;;adds 30 to AL to get the ASCII value of integers, jumps to AL_done to not go through AL_equal_or_greater_A
AL_less_than_A:
	add AL,0x30
	jmp AL_done

;;adds 32 to AL to get the ASCII value of A - F
AL_equal_or_greater_A:
	add AL,0x37

AL_done:

;;compares the value of AH to A, jumps to different code based on if it is lower or greater than or equal to A
cmp AH,0x0A
jl AH_less_than_A
jge AH_equal_or_greater_A

;;adds 30 to AH to get the ASCII value of integers, jumps to AH_done to not go through AH_equal_or_greater_A
AH_less_than_A:
	add AH,0x30
	jmp AH_done

;;adds 32 to AL to get the ASCII value of A - F
AH_equal_or_greater_A:
	add AH,0x37

AH_done:

;;moves AL and AH into correct place in outputbuf
mov [outputbuf + EDI],AH
inc EDI
mov [outputbuf + EDI],AL

;;increments and clears registers to be used for next inputbuf value
inc ESI
inc EDI
xor AL,AL
xor AH,AH
xor AX,AX

;;puts a space between each value
mov byte [outputbuf + EDI],0x20
inc EDI

;;makes sure all 8 values will be translated
cmp ESI,0x08
jl loop

;;makes sure outputbuf prints on its own line
mov byte [outputbuf + EDI],0x0A
inc EDI

;;used to print outputbuf
mov     edx, EDI
mov     ecx, outputbuf
mov     ebx, 1
mov     eax, 4
int     80h

mov     ebx, 0
mov     eax, 1
int     80h
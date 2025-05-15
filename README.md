Author: Tyler Vierbuchen, UMBC, CMSC 313 Mon-Wed 10am

Purpose: This contains the NASM assembly code to translate a lsit of 8 hex numbers to their ASCII characters and print them.

Files: hw11.asm is the only file and contains the assembly code for the program.

This assignment was programmed in the UMBC gl and I would reccomend running it on the gl, or somthing similar. 
Compile the program with: 
nasm -f elf hw11.asm
ld -m elf_i386 hw11.o -o hw11

To run the program, type: ./hw11

When run, it should output: 83 6A 88 DE 9A C3 54 9A

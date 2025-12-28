section .bss
	input_buf resb 64

section .data
	new_line db 0xA

section .text
	global _start

_start:

	mov rax, 0				; Syscall number for stdin
	mov rdi, 0				; File descriptor 0
	lea rsi, [rel input_buf]		; Load Effective Address of input_buf relative to RIP
	mov rdx, 64				; Maximum number of bytes
	syscall

	mov r8, rax
	mov rcx, 0
	mov r9, 0
	mov rsi, rsp
	mov rdi, rsp

.process_loop:

	movzx rbx, byte [input_buf + rcx]	; Move one byte from input_buf into RBX
	cmp rbx, 0x0A
	je .print_loop

	inc rdi
	mov [rdi], rbx

	inc rcx
	cmp rcx, r8
	jne .process_loop

.print_loop:

	mov rax, 1
	mov rdi, 1
	mov rdx, 1
	syscall

	inc rsi					; Iterate over the stack
	inc r9
	cmp r9, r8				; Check whether R9 is lesser than R8
	jne .print_loop


	mov rax, 1
	mov rdi, 1
	mov rsi, new_line
	mov rdx, 1
	syscall

	mov rax, 60
	mov rdi, 0
	syscall


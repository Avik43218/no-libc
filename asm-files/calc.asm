section .data
	new_line db 0xA

section .text
	global _start

_start:
	mov ax, 5
	add ax, 3
	add ax, '0'	; Add ASCII Value 48 (for 0) to (5 + 6 = 8)

	push rax	; Push rax to the stack
	mov rsi, rsp

	mov rax, 1	; Linux system call number for sys_write
	mov rdi, 1	; file descriptor 1 (stdout)
	mov rdx, 1	; Number of bytes to print
	syscall

	mov rax, 1
	mov rdi, 1
	mov rsi, new_line
	mov rdx, 1
	syscall

	mov rax, 60	; Linux system call number for exit
	mov rdi, 0	; file descriptor 0 (stdin)
	syscall


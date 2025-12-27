section .data
	new_line db 0xA

section .text
	global _start

_start:
	mov rax, 542
	add rax, 127

	mov rdi, rsp		; Point rdi to the last of the stack
	mov rcx, 0		; Digit counter
	mov rbx, 10		; Divisor

.convert_loop:

	xor rdx, rdx
	div rbx			; Quotient in rax, Remainder in rdx
	add dl, '0'

	dec rdi			; Decrease rdi by 1 to leave space in stack

	mov [rdi], dl		; Move the byte in dl to rdi
	inc rcx			; rcx = rcx + 1

	test rax, rax		; Check whether rax is 0 or not
	jnz .convert_loop	; Extract next digit if rax != 0

	; Print the result

	mov rsi, rdi
	mov rdx, rcx

	mov rax, 1
	mov rdi, 1
	syscall

	; Print new_line

	mov rax, 1
	mov rdi, 1
	mov rsi, new_line
	mov rdx, 1
	syscall

	; Exit

	mov rax, 60
	mov rdi, 0
	syscall


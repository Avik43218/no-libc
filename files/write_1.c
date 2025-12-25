const char msg[] = "Avik Roy Choudhury\n";
const int len = sizeof(msg) - 1;

void _start(void) {

	__asm__ __volatile__(
		"syscall\n\t"
		:
		: "a"(1), "D"(1), "S"(msg), "d"(len)
		: "rcx", "r11", "memory"
	);

	__asm__ __volatile__(
		"mov $60, %%rax\n\t"
		"mov $0, %%rdi\n\t"
		"syscall\n\t"
		:
		:
		: "%rax", "%rdi"
	);
}


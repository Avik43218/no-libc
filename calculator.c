// print to stdout

static inline void write(const char* buf, unsigned long len) {

	__asm__ __volatile__(
		"syscall\n\t"
		:
		: "a"(1), "D"(1), "S"(buf), "d"(len)
		: "rcx", "r11", "memory"
	);

}

// convert int to ASCII for stdout

static inline unsigned long itoc(long x, char* buf) {

	char tmp[32];
	unsigned long i = 0, j = 0;

	if (x == 0) {
		buf[0] = '0';
		return 1;
	}

	if (x < 0) {
		buf[0] = '-';
		x = -x;
	}

	while (x > 0) {
		tmp[i++] = '0' + (x % 10);
		x /= 10;
	}

	while (i > 0) {
		buf[j++] = tmp[--i];
	}

	return j;
}

static inline void print_int(long x) {

	char buf[32];
	unsigned long len = itoc(x, buf);
	write(buf, len);
}

// arithmetic operations

static inline long add(long x, long y) {

	while (y != 0) {

		long carry = x & y;

		x = x ^ y;

		y = carry << 1;
	}
	return x;
}

// entry point

void _start(void) {

	long a = 5, b = 10;
	long result;

	result = add(a, b);

	print_int(result);
	write("\n", 1);

	__asm__ __volatile__(
		"syscall\n\t"
		:
		: "a"(60), "D"(0)
		: "rcx", "r11"
	);
}

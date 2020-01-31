/**
 * gcc zero.c -o zero && ./zero $input
 *
 * This approach uses a simple finite state machine to walk the integer in
 * memory seeking the most-significant-bit. Once found it will accumulate the
 * maximum count of consecutive zeros.
 */
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
	if (argc != 2) {
		printf("%s [int]\n", argv[0]);
		return -1;
	}

	int input = atoi(argv[1]);
	if (input <= 0) {
		printf("Invalid input.\n");
		return -2;
	}

	int accum_max = 0;
	int current = 0;

	int seeking_bit_value = 0;
	int input_bit_value = 0;

	int msb_found = 0;

	for (int i = 31; i>0; i--) {
		seeking_bit_value = 1 << i;
		input_bit_value = (input & seeking_bit_value) == seeking_bit_value;
		// wait til we he have the MSB
		if (msb_found == 0) {
			// found the most signficant bit
			if (input_bit_value == 1) {
				msb_found = 1;
			}
			continue;
		}

		// found a bit == 1
		if (input_bit_value == 1) {
			if (current > accum_max) {
				accum_max = current;
			}
			current = 0;
		} else {
			current ++;
		}
	}

	if (current > accum_max) {
		accum_max = current;
	}

	printf("Input: %d\nMax consecutive zeros: %d\n", input, accum_max);
}

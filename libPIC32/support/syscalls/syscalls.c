#include <stdint.h>

// Minimal implementation, so there are no warnings during compile/linking time

int close(){
	return -1;
}

int fstat(){
	return 0;
}

int getpid(){
	return 1;
}

int isatty(){
	return 1;
}

int kill(){
	return -1;
}

int lseek(){
	return 0;
}

int read(){
	return 0;
}

int write(){
	return 0;
}

#include <xc.h>

//const uint32_t __attribute__((section(".SECTION_DEVCFG3"))) __DEVCFG3 = 0xffffffff;
//const uint32_t __attribute__((section(".SECTION_DEVCFG2"))) __DEVCFG2 = 0xffffffff;
//const uint32_t __attribute__((section(".SECTION_DEVCFG1"))) __DEVCFG1 = 0xfff4ffff;
//const uint32_t __attribute__((section(".SECTION_DEVCFG0"))) __DEVCFG0 = 0x7fffffff;

const uint32_t __attribute__((section(".SECTION_DEVCFG3"))) __DEVCFG3 = 0xf8ffffff;
const uint32_t __attribute__((section(".SECTION_DEVCFG2"))) __DEVCFG2 = 0xfff879d9;
const uint32_t __attribute__((section(".SECTION_DEVCFG1"))) __DEVCFG1 = 0xff74cddb;
const uint32_t __attribute__((section(".SECTION_DEVCFG0"))) __DEVCFG0 = 0x7fffffff;

uint32_t data = 0;

void wait_pll() {
	while(!OSCCONbits.SLOCK);
}

void enable_cache() {
	asm volatile(
	"di	$t0;"
	"ehb;"
	"mfc0	$t0,$16;"
	"ori	$t0,$t0,0x3;"
	"mtc0	$t0,$16;"
	"ehb;"
	);

	CHECONbits.PFMWS = 2;
	CHECONbits.PREFEN = 3;

	BMXCONbits.BMXWSDRM = 0;
}



uint32_t data0 = 0xefefefef;

void DataLedTask_1() {
	static uint32_t osc_count = 0;

	const uint32_t osc1 = 254;
	const uint32_t osc2 = 255;

	osc_count += 1;

	if (osc_count > (osc1 * osc2 * 2 - 1)) {
		osc_count = 0;
	}

	uint8_t osc1_on = (osc_count / osc1) % 2;
	uint8_t osc2_on = (osc_count / osc2) % 2;

	LATBbits.LATB8 = (osc1_on ^ osc2_on);
}

void DataLedTask_2() {
	static uint32_t osc_count = 0;

	const uint32_t osc1 = 255;
	const uint32_t osc2 = 256;

	osc_count += 1;

	if (osc_count > (osc1 * osc2 * 2 - 1)) {
		osc_count = 0;
	}

	uint8_t osc1_on = (osc_count / osc1) % 2;
	uint8_t osc2_on = (osc_count / osc2) % 2;

	LATFbits.LATF1 = (osc1_on ^ osc2_on);
}
void DataLedTask_3() {
	static uint32_t osc_count = 0;

	const uint32_t osc1 = 256;
	const uint32_t osc2 = 257;

	osc_count += 1;

	if (osc_count > (osc1 * osc2 * 2 - 1)) {
		osc_count = 0;
	}

	uint8_t osc1_on = (osc_count / osc1) % 2;
	uint8_t osc2_on = (osc_count / osc2) % 2;

	LATFbits.LATF0 = (osc1_on ^ osc2_on);
}

int main() {
	wait_pll();
	enable_cache();

	LATFbits.LATF0 = 0;
	LATFbits.LATF1 = 1;

	TRISFbits.TRISF0 = 0;
	TRISFbits.TRISF1 = 0;

	LATBbits.LATB8 = 0;

	TRISBbits.TRISB8 = 0;

	while (1) {

		DataLedTask_1();
		DataLedTask_2();
		DataLedTask_3();

	}

	return 0;
}

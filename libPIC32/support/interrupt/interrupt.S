/* ISRwrapper.inc - PIC32MX ISR wrapper code - macro ISR_wrapper
**
** Define ISR wrapper and vector branch code to support "C" ISR.
** For a given vector_XX, create wrapper code to direct vector
** XX to the named C-language ISR.
**
** To use with any Microchip headers (not recommended),
** compile with "-fdollars-in-identifiers" option.
**
** History:
**   20090505 DRNadler: Original coding
**   20200125 Neofoxx:
**		Added wrappers in a generic way for all PIC32MX&MM targets
**		Removed manual register saving. Let the compiler handle it.
**		Now properly emits weak attributes.
**   20201115 Neofoxx:
**		Added support for PIC32MZ targets.
**
** Copyright (c) 2009 Dave Nadler
** Copyright (c) 2020 Primož "Neofoxx" Kranjec
**
** The authors hereby grant permission to use, copy, modify, distribute,
** and license this software and its documentation for any purpose, provided
** that existing copyright notices are retained in all copies and that this
** notice is included verbatim in any distributions.  No written agreement,
** license, or royalty fee is required for any of the authorized uses.
** Modifications to this software may be copyrighted by their authors
** and need not follow the licensing terms described here, provided that
** the new terms are clearly indicated on the first page of each file where
** they apply.
*/

#include "../../xc.h"

/*
** Add wrappers, depending if they are defined for the target or not.
** This allows reuse of file easily between families
*/
  
	.macro	ISR_wrapper _XX,name
		.section .vector_\_XX,"ax",%progbits
		.weak	\name
		/* For PIC32MX and MM, there is a fixed vector table,
		 * and jumps to functions must be placed there
		 */
		#ifndef __PIC32MZ
vector_\_XX:	/* Place label, so disassembly properly shows micromips code */
			j	\name
			nop

		/* For PIC32MZ, vectors can be relocated on the fly,
		 * as long as they are in the first 240-ish kB of space.
		 * Combined with voff.S, this does everything dynamically
		 */
		#else /* __PIC32MZ */
			/* Ugly hack, but it works. Mark which interrupts are present
			 * This file goes though ALL the present interrupts, and marks them down.
			 * Since the numbers correspond to OFF\XX, we can use as offsets (hence the * 4)
			 */
			.section .voff.pic32_voff_present_interrupts
			.word (\_XX * 4)
		#endif
	.endm
	
		
	
	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _CORE_TIMER_VECTOR
		ISR_wrapper _CORE_TIMER_VECTOR, CoreTimerInterrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _CORE_SOFTWARE_0_VECTOR
		ISR_wrapper _CORE_SOFTWARE_0_VECTOR, CoreSoftware0Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _CORE_SOFTWARE_1_VECTOR
		ISR_wrapper _CORE_SOFTWARE_1_VECTOR, CoreSoftware1Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _EXTERNAL_0_VECTOR
		ISR_wrapper _EXTERNAL_0_VECTOR, External0Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _EXTERNAL_1_VECTOR
		ISR_wrapper _EXTERNAL_1_VECTOR, External1Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _EXTERNAL_2_VECTOR
		ISR_wrapper _EXTERNAL_2_VECTOR, External2Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _EXTERNAL_3_VECTOR
		ISR_wrapper _EXTERNAL_3_VECTOR, External3Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _EXTERNAL_4_VECTOR
		ISR_wrapper _EXTERNAL_4_VECTOR, External4Interrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _CHANGE_NOTICE_A_VECTOR
		ISR_wrapper _CHANGE_NOTICE_A_VECTOR, ChangeNoticeAInterrupt
	#endif

	/* PIC32MM, PIC32MZ  */
	#if defined _CHANGE_NOTICE_B_VECTOR
		ISR_wrapper _CHANGE_NOTICE_B_VECTOR, ChangeNoticeBInterrupt
	#endif

	/* PIC32MM, PIC32MZ  */
	#if defined _CHANGE_NOTICE_C_VECTOR
		ISR_wrapper _CHANGE_NOTICE_C_VECTOR, ChangeNoticeCInterrupt
	#endif

	/* PIC32MM, PIC32MZ  */
	#if defined _CHANGE_NOTICE_D_VECTOR
		ISR_wrapper _CHANGE_NOTICE_D_VECTOR, ChangeNoticeDInterrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _TIMER_1_VECTOR
		ISR_wrapper _TIMER_1_VECTOR, Timer1Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _COMPARATOR_1_VECTOR
		ISR_wrapper _COMPARATOR_1_VECTOR, Comparator1Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _COMPARATOR_2_VECTOR
		ISR_wrapper _COMPARATOR_2_VECTOR, Comparator2Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _RTCC_VECTOR
		ISR_wrapper _RTCC_VECTOR, RTCCInterrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _ADC_VECTOR
		ISR_wrapper _ADC_VECTOR, ADCInterrupt
	#endif

	/* PIC32MM */
	#if defined _CRC_VECTOR
		ISR_wrapper _CRC_VECTOR, CRCInterrupt
	#endif

	/* PIC32MM */
	#if defined _HLVD_VECTOR
		ISR_wrapper _HLVD_VECTOR, HLVDInterrupt
	#endif

	/* PIC32MM */
	#if defined _CLC1_VECTOR
		ISR_wrapper _CLC1_VECTOR, CLC1Interrupt
	#endif

	/* PIC32MM */
	#if defined _CLC2_VECTOR
		ISR_wrapper _CLC2_VECTOR, CLC2Interrupt
	#endif

	/* PIC32MM */
	#if defined _CLC3_VECTOR
		ISR_wrapper _CLC3_VECTOR, CLC3Interrupt
	#endif

	/* PIC32MM */
	#if defined _CLC4_VECTOR
		ISR_wrapper _CLC4_VECTOR, CLC4Interrupt
	#endif

	/* PIC32MM */
	#if defined _SPI1_ERR_VECTOR
		ISR_wrapper _SPI1_ERR_VECTOR, SPI1ErrorInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _SPI1_TX_VECTOR
		ISR_wrapper _SPI1_TX_VECTOR, SPI1TxInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _SPI1_RX_VECTOR
		ISR_wrapper _SPI1_RX_VECTOR, SPI1RxInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _UART1_RX_VECTOR
		ISR_wrapper _UART1_RX_VECTOR, UART1RxInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _UART1_TX_VECTOR
		ISR_wrapper _UART1_TX_VECTOR, UART1TxInterrupt
	#endif

	/* PIC32MM */
	#if defined _UART1_ERR_VECTOR
		ISR_wrapper _UART1_ERR_VECTOR, UART1ErrorInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _I2C1_SLAVE_VECTOR
		ISR_wrapper _I2C1_SLAVE_VECTOR, I2C1SlaveInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _I2C1_MASTER_VECTOR
		ISR_wrapper _I2C1_MASTER_VECTOR, I2C1MasterInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _I2C1_BUS_VECTOR
		ISR_wrapper _I2C1_BUS_VECTOR, I2C1BusInterrupt
	#endif

	/* PIC32MM */
	#if defined _CCP1_VECTOR
		ISR_wrapper _CCP1_VECTOR, CCP1Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCT1_VECTOR
		ISR_wrapper _CCT1_VECTOR, CCT1Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCP2_VECTOR
		ISR_wrapper _CCP2_VECTOR, CCP2Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCT2_VECTOR
		ISR_wrapper _CCT2_VECTOR, CCT2Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCP3_VECTOR
		ISR_wrapper _CCP3_VECTOR, CCP3Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCT3_VECTOR
		ISR_wrapper _CCT3_VECTOR, CCT3Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCP4_VECTOR
		ISR_wrapper _CCP4_VECTOR, CCP4Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCT4_VECTOR
		ISR_wrapper _CCT4_VECTOR, CCT4Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCP5_VECTOR
		ISR_wrapper _CCP5_VECTOR, CCP5Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCT5_VECTOR
		ISR_wrapper _CCT5_VECTOR, CCT5Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCP6_VECTOR
		ISR_wrapper _CCP6_VECTOR, CCP6Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCT6_VECTOR
		ISR_wrapper _CCT6_VECTOR, CCT6Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCP7_VECTOR
		ISR_wrapper _CCP7_VECTOR, CCP7Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCT7_VECTOR
		ISR_wrapper _CCT7_VECTOR, CCT7Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCP8_VECTOR
		ISR_wrapper _CCP8_VECTOR, CCP8Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCT8_VECTOR
		ISR_wrapper _CCT8_VECTOR, CCT8Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCP9_VECTOR
		ISR_wrapper _CCP9_VECTOR, CCP9Interrupt
	#endif

	/* PIC32MM */
	#if defined _CCT9_VECTOR
		ISR_wrapper _CCT9_VECTOR, CCT9Interrupt
	#endif

	/* PIC32MM */
	#if defined _SPI2_ERR_VECTOR
		ISR_wrapper _SPI2_ERR_VECTOR, SPI2ErrorInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _SPI2_TX_VECTOR
		ISR_wrapper _SPI2_TX_VECTOR, SPI2TxInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _SPI2_RX_VECTOR
		ISR_wrapper _SPI2_RX_VECTOR, SPI2RxInterrupt
	#endif

	/* PIC32MM */
	#if defined _SPI3_ERR_VECTOR
		ISR_wrapper _SPI3_ERR_VECTOR, SPI3ErrorInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _SPI3_TX_VECTOR
		ISR_wrapper _SPI3_TX_VECTOR, SPI3TxInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _SPI3_RX_VECTOR
		ISR_wrapper _SPI3_RX_VECTOR, SPI3RxInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _UART2_RX_VECTOR	
		ISR_wrapper _UART2_RX_VECTOR, UART2RxInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _UART2_TX_VECTOR
		ISR_wrapper _UART2_TX_VECTOR, UART2TxInterrupt
	#endif

	/* PIC32MM */
	#if defined _UART2_ERR_VECTOR
		ISR_wrapper _UART2_ERR_VECTOR, UART2ErrorInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _UART3_RX_VECTOR	
		ISR_wrapper _UART3_RX_VECTOR, UART3RxInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _UART3_TX_VECTOR
		ISR_wrapper _UART3_TX_VECTOR, UART3TxInterrupt
	#endif

	/* PIC32MM */
	#if defined _UART3_ERR_VECTOR
		ISR_wrapper _UART3_ERR_VECTOR, UART3ErrorInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _I2C2_SLAVE_VECTOR
		ISR_wrapper _I2C2_SLAVE_VECTOR, I2C2SlaveInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _I2C2_MASTER_VECTOR
		ISR_wrapper _I2C2_MASTER_VECTOR, I2C2MasterInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _I2C2_BUS_VECTOR
		ISR_wrapper _I2C2_BUS_VECTOR, I2C2BusInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _I2C3_SLAVE_VECTOR
		ISR_wrapper _I2C3_SLAVE_VECTOR, I2C3SlaveInterrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _I2C3_MASTER_VECTOR
		ISR_wrapper _I2C3_MASTER_VECTOR, I2C3MasterInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _I2C3_BUS_VECTOR
		ISR_wrapper _I2C3_BUS_VECTOR, I2C3BusInterrupt
	#endif

	/* PIC32MM */
	#if defined _FRC_TUNE_VECTOR
		ISR_wrapper _FRC_TUNE_VECTOR, FRCTuneInterrupt
	#endif

	/* PIC32MM */
	#if defined _DCO_TUNE_VECTOR
		ISR_wrapper _DCO_TUNE_VECTOR, DCOTuneInterrupt
	#endif

	/* PIC32MM */
	#if defined _NVM_VECTOR
		ISR_wrapper _NVM_VECTOR, NVMInterrupt
	#endif

	/* PIC32MM */
	#if defined _PERFORMANCE_COUNTER_VECTOR
		ISR_wrapper _PERFORMANCE_COUNTER_VECTOR, PerformanceCounterInterrupt
	/* PIC32MZ */
	#elif defined _CORE_PERF_COUNT_VECTOR
		ISR_wrapper _CORE_PERF_COUNT_VECTOR, PerformanceCounterInterrupt
	#endif

	/* PIC32MM */
	#if defined _ECCSB_ERR_VECTOR
		ISR_wrapper _ECCSB_ERR_VECTOR, ECCSingleBitErrorInterrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _INPUT_CAPTURE_1_VECTOR
		ISR_wrapper _INPUT_CAPTURE_1_VECTOR, InputCapture1Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _OUTPUT_COMPARE_1_VECTOR
		ISR_wrapper _OUTPUT_COMPARE_1_VECTOR, OutputCompare1Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _TIMER_2_VECTOR
		ISR_wrapper _TIMER_2_VECTOR, Timer2Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _INPUT_CAPTURE_2_VECTOR
		ISR_wrapper _INPUT_CAPTURE_2_VECTOR, InputCapture2Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _OUTPUT_COMPARE_2_VECTOR
		ISR_wrapper _OUTPUT_COMPARE_2_VECTOR, OutputCompare2Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ */
	#if defined _TIMER_3_VECTOR
		ISR_wrapper _TIMER_3_VECTOR, Timer3Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _INPUT_CAPTURE_3_VECTOR
		ISR_wrapper _INPUT_CAPTURE_3_VECTOR, InputCapture3Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _OUTPUT_COMPARE_3_VECTOR
		ISR_wrapper _OUTPUT_COMPARE_3_VECTOR, OutputCompare3Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _TIMER_4_VECTOR
		ISR_wrapper _TIMER_4_VECTOR, Timer4Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _INPUT_CAPTURE_4_VECTOR
		ISR_wrapper _INPUT_CAPTURE_4_VECTOR, InputCapture4Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _OUTPUT_COMPARE_4_VECTOR
		ISR_wrapper _OUTPUT_COMPARE_4_VECTOR, OutputCompare4Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _TIMER_5_VECTOR
		ISR_wrapper _TIMER_5_VECTOR, Timer5Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _INPUT_CAPTURE_5_VECTOR
		ISR_wrapper _INPUT_CAPTURE_5_VECTOR, InputCapture5Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _OUTPUT_COMPARE_5_VECTOR
		ISR_wrapper _OUTPUT_COMPARE_5_VECTOR, OutputCompare5Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx */
	#if defined _FAIL_SAFE_MONITOR_VECTOR
		ISR_wrapper _FAIL_SAFE_MONITOR_VECTOR, FailSafeMonitorInterrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx */
	#if defined _FCE_VECTOR
		ISR_wrapper _FCE_VECTOR, FCEInterrupt
	#endif

	/* PIC32MX1/2xx, PIC32MM */
	#if defined _COMPARATOR_3_VECTOR
		ISR_wrapper _COMPARATOR_3_VECTOR, Comparator3Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx */
	#if defined _USB_1_VECTOR
		ISR_wrapper _USB_1_VECTOR, USB1Interrupt
	#endif

	/* PIC32MM, PIC32MZ */
	#if defined _USB_VECTOR
		ISR_wrapper _USB_VECTOR, USBInterrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx */
	#if defined _SPI_1_VECTOR
		ISR_wrapper _SPI_1_VECTOR, SPI1Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx */
	#if defined _I2C_1_VECTOR
		ISR_wrapper _I2C_1_VECTOR, I2C1Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx */
	#if defined _CHANGE_NOTICE_VECTOR
		ISR_wrapper _CHANGE_NOTICE_VECTOR, ChangeNoticeInterrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ */
	#if defined _PMP_VECTOR
		ISR_wrapper _PMP_VECTOR, PMPInterrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx */
	#if defined _I2C_2_VECTOR
		ISR_wrapper _I2C_2_VECTOR, I2C2Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx */
	#if defined _CTMU_VECTOR
		ISR_wrapper _CTMU_VECTOR, CTMUInterrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx*/
	#if defined _DMA_0_VECTOR
		ISR_wrapper _DMA_0_VECTOR, DMA0Interrupt
	/* PIC32MM, PIC32MZ */
	#elif defined _DMA0_VECTOR
		ISR_wrapper _DMA0_VECTOR, DMA0Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx */
	#if defined _DMA_1_VECTOR
		ISR_wrapper _DMA_1_VECTOR, DMA1Interrupt
	/* PIC32MM, PIC32MZ */
	#elif defined _DMA1_VECTOR
		ISR_wrapper _DMA1_VECTOR, DMA1Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx */
	#if defined _DMA_2_VECTOR
		ISR_wrapper _DMA_2_VECTOR, DMA2Interrupt
	/* PIC32MM, PIC32MZ */
	#elif defined _DMA2_VECTOR
		ISR_wrapper _DMA2_VECTOR, DMA2Interrupt
	#endif

	/* PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx */
	#if defined _DMA_3_VECTOR
		ISR_wrapper _DMA_3_VECTOR, DMA3Interrupt
	/* PIC32MM, PIC32MZ */
	#elif defined _DMA3_VECTOR
		ISR_wrapper _DMA3_VECTOR, DMA3Interrupt
	#endif


	/* Ok, so MX5/6/7 is a bit special...
	** Vectors 24, 31 and 32 can be shared amongst peripherals.
	** Datasheet defines three groups of three combinations,
	** but .h files specify just 6 definitions per shared vector.
	** Currently unknown, why it's always three peripherals
	** (say I2C3, SPI3 and UART1), but added vectors are 
	** I2C_1A, SPI1A, UART_1A.
	** TBD some other time. Anyway.
	**
	** How these cases are handled:
	** - The 6 vectors are always defined in MX5/6/7.
	** -  Since some vector names are shared with MX1/2/3/4,
	** -> we #ifdef the 6 vectors (or a unique one), and if not defined,
	** -> define as normal for MX1/2/3/4
	** 24 shares 1 definition, 31 2, and 32 1.
	**
	** Addendum, vectors 49, 50, and 51 are also shared a bit
	** -> All UART vectors, but one for Error, one for RX and one for TX.
	** Vectors 49, 50, 51.
	*/

	/* Vector 24,
	** _I2C_3_VECTOR, _I2C_1A_VECTOR, _SPI_3_VECTOR
	** _SPI_1A_VECTOR, _UART_1_VECTOR, _UART_1A_VECTOR
	*/

	/* PIC32MX5/6/7xx */
	#if defined _I2C_3_VECTOR
		ISR_wrapper _I2C_3_VECTOR, I2C3_SPI3_UART1_SharedInterrupt

	/* PIC32MX1/2xx, PIC32MX3/4xx */
	#else
		#if defined _UART_1_VECTOR
			ISR_wrapper _UART_1_VECTOR, UART1Interrupt
		#endif

		#if defined _SPI_3_VECTOR
			ISR_wrapper _SPI_3_VECTOR, SPI3Interrupt
		#endif		
	#endif


	/* Vector 31,
	** _I2C_4_VECTOR, _I2C_2A_VECTOR, _SPI_2_VECTOR
	** _SPI_2A_VECTOR, _UART_3_VECTOR, _UART_2A_VECTOR
	*/

	/* PIC32MX5/6/7xx */
	#if defined _I2C_4_VECTOR
		ISR_wrapper _I2C_4_VECTOR, I2C4_SPI2_UART3_SharedInterrupt
	
	#else
		/* PIC32MX1/2xx, PIC32MX3/4xx */
		#if defined _SPI_2_VECTOR
			ISR_wrapper _SPI_2_VECTOR, SPI2Interrupt
		#endif

		/* PIC32MX3/4xx */
		#if defined _UART_3_VECTOR
			ISR_wrapper _UART_3_VECTOR, UART3Interrupt
		#endif

	#endif


	/* Vector 32,
	** _I2C_5_VECTOR, _I2C_3A_VECTOR, _SPI_4_VECTOR
	** _SPI_3A_VECTOR, _UART_2_VECTOR, _UART_3A_VECTOR
	*/

	/* PIC32MX5/6/7xx */
	#if defined _I2C_5_VECTOR
		ISR_wrapper _I2C_5_VECTOR, I2C5_SPI4_UART2_SharedInterrupt
	#else
		/* PIC32MX1/2xx, PIC32MX3/4xx */
		#if defined _UART_2_VECTOR
			ISR_wrapper _UART_2_VECTOR, UART2Interrupt
		#endif
		#if defined _SPI_4_VECTOR
			ISR_wrapper _SPI_4_VECTOR, SPI4Interrupt
		#endif
	#endif

	/* PIC32MX5/6/7xx */
	#if defined _DMA_4_VECTOR
		ISR_wrapper _DMA_4_VECTOR, DMA4Interrupt
	/* PIC32MZ */
	#elif defined _DMA4_VECTOR
		ISR_wrapper _DMA4_VECTOR, DMA4Interrupt
	#endif

	/* PIC32MX5/6/7xx */
	#if defined _DMA_5_VECTOR
		ISR_wrapper _DMA_5_VECTOR, DMA5Interrupt
	/* PIC32MZ */
	#elif defined _DMA5_VECTOR
		ISR_wrapper _DMA5_VECTOR, DMA5Interrupt
	#endif

	/* PIC32MX5/6/7xx */
	#if defined _DMA_6_VECTOR
		ISR_wrapper _DMA_6_VECTOR, DMA6Interrupt
	/* PIC32MZ */
	#elif defined _DMA6_VECTOR
		ISR_wrapper _DMA6_VECTOR, DMA6Interrupt
	#endif

	/* PIC32MX5/6/7xx */
	#if defined _DMA_7_VECTOR
		ISR_wrapper _DMA_7_VECTOR, DMA7Interrupt
	/* PIC32MZ */
	#elif defined _DMA7_VECTOR
		ISR_wrapper _DMA7_VECTOR, DMA7Interrupt
	#endif
	

	/* PIC32MX1/2xx, PIC32MX5/6/7xx */
	#if defined _CAN_1_VECTOR
		ISR_wrapper _CAN_1_VECTOR, CAN1Interrupt
	/* PIC32MZ */
	#elif defined _CAN1_VECTOR
		ISR_wrapper _CAN1_VECTOR, CAN1Interrupt
	#endif

	/* PIC32MX5/6/7xx */
	#if defined _CAN_2_VECTOR
		ISR_wrapper _CAN_2_VECTOR, CAN2Interrupt
	/* PIC32MZ */
	#elif defined _CAN2_VECTOR
		ISR_wrapper _CAN2_VECTOR, CAN2Interrupt
	#endif

	/* PIC32MX5/6/7xx */
	#if defined _ETH_VECTOR
		ISR_wrapper _ETH_VECTOR, ETHInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ETHERNET_VECTOR
		ISR_wrapper _ETHERNET_VECTOR, ETHERNETInterrupt
	#endif


	/* Vector 49,
	** _UART_4_VECTOR, _UART_1B_VECTOR
	*/

	/* PIC32MX5/6/7xx */
	#if defined _UART_1B_VECTOR
		ISR_wrapper _UART_1B_VECTOR, UART4_UART1B_SharedInterrupt
	
	/* PIC32MX3/4xx */
	#elif defined _UART_4_VECTOR
		ISR_wrapper _UART_4_VECTOR, UART4Interrupt
	#endif


	/* Vector 50,
	** _UART_6_VECTOR, _UART_2B_VECTOR
	*/

	/* PIC32MX5/6/7xx */
	#if defined _UART_2B_VECTOR
		ISR_wrapper _UART_2B_VECTOR, UART6_UART2B_SharedInterrupt
	#endif
	
	/* Vector 51,
	** _UART_5_VECTOR, _UART_3B_VECTOR
	*/
	#if defined _UART_3B_VECTOR
		ISR_wrapper _UART_3B_VECTOR, UART5_UART3B_SharedInterrupt
	#else
		/* PIC32MX1/2xx, PIC32MX3/4xx */
		#if defined _UART_5_VECTOR
			ISR_wrapper _UART_5_VECTOR, UART5Interrupt
		#endif
	#endif
	
	
	
	/* PIC32MZ specific vectors */
	
	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_1_ERROR_VECTOR
		ISR_wrapper _INPUT_CAPTURE_1_ERROR_VECTOR, InputCapture1ErrorInterrupt
	#endif

	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_2_ERROR_VECTOR
		ISR_wrapper _INPUT_CAPTURE_2_ERROR_VECTOR, InputCapture2ErrorInterrupt
	#endif

	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_3_ERROR_VECTOR
		ISR_wrapper _INPUT_CAPTURE_3_ERROR_VECTOR, InputCapture3ErrorInterrupt
	#endif

	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_4_ERROR_VECTOR
		ISR_wrapper _INPUT_CAPTURE_4_ERROR_VECTOR, InputCapture4ErrorInterrupt
	#endif

	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_5_ERROR_VECTOR
		ISR_wrapper _INPUT_CAPTURE_5_ERROR_VECTOR, InputCapture5ErrorInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_6_ERROR_VECTOR
		ISR_wrapper _INPUT_CAPTURE_6_ERROR_VECTOR, InputCapture6ErrorInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_7_ERROR_VECTOR
		ISR_wrapper _INPUT_CAPTURE_7_ERROR_VECTOR, InputCapture7ErrorInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_8_ERROR_VECTOR
		ISR_wrapper _INPUT_CAPTURE_8_ERROR_VECTOR, InputCapture8ErrorInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_9_ERROR_VECTOR
		ISR_wrapper _INPUT_CAPTURE_9_ERROR_VECTOR, InputCapture9ErrorInterrupt
	#endif

	/* PIC32MZ */
	#if defined _TIMER_6_VECTOR
		ISR_wrapper _TIMER_6_VECTOR, Timer6Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _TIMER_7_VECTOR
		ISR_wrapper _TIMER_7_VECTOR, Timer7Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _TIMER_8_VECTOR
		ISR_wrapper _TIMER_8_VECTOR, Timer8Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _TIMER_9_VECTOR
		ISR_wrapper _TIMER_9_VECTOR, Timer9Interrupt
	#endif

	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_6_VECTOR
		ISR_wrapper _INPUT_CAPTURE_6_VECTOR, InputCapture6Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_7_VECTOR
		ISR_wrapper _INPUT_CAPTURE_7_VECTOR, InputCapture7Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_8_VECTOR
		ISR_wrapper _INPUT_CAPTURE_8_VECTOR, InputCapture8Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _INPUT_CAPTURE_9_VECTOR
		ISR_wrapper _INPUT_CAPTURE_9_VECTOR, InputCapture9Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _OUTPUT_COMPARE_6_VECTOR
		ISR_wrapper _OUTPUT_COMPARE_6_VECTOR, OutputCompare6Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _OUTPUT_COMPARE_7_VECTOR
		ISR_wrapper _OUTPUT_COMPARE_7_VECTOR, OutputCompare7Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _OUTPUT_COMPARE_8_VECTOR
		ISR_wrapper _OUTPUT_COMPARE_8_VECTOR, OutputCompare8Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _OUTPUT_COMPARE_9_VECTOR
		ISR_wrapper _OUTPUT_COMPARE_9_VECTOR, OutputCompare9Interrupt
	#endif

	/* PIC32MZ */
	#if defined _ADC_FIFO_VECTOR
		ISR_wrapper _ADC_FIFO_VECTOR, ADCFIFOInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DC1_VECTOR
		ISR_wrapper _ADC_DC1_VECTOR, ADCDC1Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DC2_VECTOR
		ISR_wrapper _ADC_DC2_VECTOR, ADCDC2Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DC3_VECTOR
		ISR_wrapper _ADC_DC3_VECTOR, ADCDC3Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DC4_VECTOR
		ISR_wrapper _ADC_DC4_VECTOR, ADCDC4Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DC5_VECTOR
		ISR_wrapper _ADC_DC5_VECTOR, ADCDC5Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DC6_VECTOR
		ISR_wrapper _ADC_DC6_VECTOR, ADCDC6Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DF1_VECTOR
		ISR_wrapper _ADC_DF1_VECTOR, ADCDF1Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DF2_VECTOR
		ISR_wrapper _ADC_DF2_VECTOR, ADCDF2Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DF3_VECTOR
		ISR_wrapper _ADC_DF3_VECTOR, ADCDF3Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DF4_VECTOR
		ISR_wrapper _ADC_DF4_VECTOR, ADCDF4Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DF5_VECTOR
		ISR_wrapper _ADC_DF5_VECTOR, ADCDF5Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DF6_VECTOR
		ISR_wrapper _ADC_DF6_VECTOR, ADCDF6Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_FAULT_VECTOR
		ISR_wrapper _ADC_FAULT_VECTOR, ADCFaultInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA0_VECTOR
		ISR_wrapper _ADC_DATA0_VECTOR, ADCData0Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA1_VECTOR
		ISR_wrapper _ADC_DATA1_VECTOR, ADCData1Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA2_VECTOR
		ISR_wrapper _ADC_DATA2_VECTOR, ADCData2Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA3_VECTOR
		ISR_wrapper _ADC_DATA3_VECTOR, ADCData3Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA4_VECTOR
		ISR_wrapper _ADC_DATA4_VECTOR, ADCData4Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA5_VECTOR
		ISR_wrapper _ADC_DATA5_VECTOR, ADCData5Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA6_VECTOR
		ISR_wrapper _ADC_DATA6_VECTOR, ADCData6Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA7_VECTOR
		ISR_wrapper _ADC_DATA7_VECTOR, ADCData7Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA8_VECTOR
		ISR_wrapper _ADC_DATA8_VECTOR, ADCData8Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA9_VECTOR
		ISR_wrapper _ADC_DATA9_VECTOR, ADCData9Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA10_VECTOR
		ISR_wrapper _ADC_DATA10_VECTOR, ADCData10Interrupt
	#endif
	
	
	/* PIC32MZ */
	#if defined _ADC_DATA11_VECTOR
		ISR_wrapper _ADC_DATA11_VECTOR, ADCData11Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA12_VECTOR
		ISR_wrapper _ADC_DATA12_VECTOR, ADCData12Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA13_VECTOR
		ISR_wrapper _ADC_DATA13_VECTOR, ADCData13Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA14_VECTOR
		ISR_wrapper _ADC_DATA14_VECTOR, ADCData14Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA15_VECTOR
		ISR_wrapper _ADC_DATA15_VECTOR, ADCData15Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA16_VECTOR
		ISR_wrapper _ADC_DATA16_VECTOR, ADCData16Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA17_VECTOR
		ISR_wrapper _ADC_DATA17_VECTOR, ADCData17Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA18_VECTOR
		ISR_wrapper _ADC_DATA18_VECTOR, ADCData18Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA19_VECTOR
		ISR_wrapper _ADC_DATA19_VECTOR, ADCData19Interrupt
	#endif

	/* PIC32MZ */
	#if defined _ADC_DATA20_VECTOR
		ISR_wrapper _ADC_DATA20_VECTOR, ADCData20Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA21_VECTOR
		ISR_wrapper _ADC_DATA21_VECTOR, ADCData21Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA22_VECTOR
		ISR_wrapper _ADC_DATA22_VECTOR, ADCData22Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA23_VECTOR
		ISR_wrapper _ADC_DATA23_VECTOR, ADCData23Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA24_VECTOR
		ISR_wrapper _ADC_DATA24_VECTOR, ADCData24Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA25_VECTOR
		ISR_wrapper _ADC_DATA25_VECTOR, ADCData25Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA26_VECTOR
		ISR_wrapper _ADC_DATA26_VECTOR, ADCData26Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA27_VECTOR
		ISR_wrapper _ADC_DATA27_VECTOR, ADCData27Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA28_VECTOR
		ISR_wrapper _ADC_DATA28_VECTOR, ADCData28Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA29_VECTOR
		ISR_wrapper _ADC_DATA29_VECTOR, ADCData29Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA30_VECTOR
		ISR_wrapper _ADC_DATA30_VECTOR, ADCData30Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA31_VECTOR
		ISR_wrapper _ADC_DATA31_VECTOR, ADCData31Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA32_VECTOR
		ISR_wrapper _ADC_DATA32_VECTOR, ADCData32Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA33_VECTOR
		ISR_wrapper _ADC_DATA33_VECTOR, ADCData33Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA34_VECTOR
		ISR_wrapper _ADC_DATA34_VECTOR, ADCData34Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA35_VECTOR
		ISR_wrapper _ADC_DATA35_VECTOR, ADCData35Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA36_VECTOR
		ISR_wrapper _ADC_DATA36_VECTOR, ADCData36Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA37_VECTOR
		ISR_wrapper _ADC_DATA37_VECTOR, ADCData37Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA38_VECTOR
		ISR_wrapper _ADC_DATA38_VECTOR, ADCData38Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA39_VECTOR
		ISR_wrapper _ADC_DATA39_VECTOR, ADCData39Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA40_VECTOR
		ISR_wrapper _ADC_DATA40_VECTOR, ADCData40Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA41_VECTOR
		ISR_wrapper _ADC_DATA41_VECTOR, ADCData41Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA42_VECTOR
		ISR_wrapper _ADC_DATA42_VECTOR, ADCData42Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA43_VECTOR
		ISR_wrapper _ADC_DATA43_VECTOR, ADCData43Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_DATA44_VECTOR
		ISR_wrapper _ADC_DATA44_VECTOR, ADCData44Interrupt
	#endif
	
	/* PIC32MZ */
	#if defined _CORE_FAST_DEBUG_CHAN_VECTOR
		ISR_wrapper _CORE_FAST_DEBUG_CHAN_VECTOR, FastDebugChannelInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _SYSTEM_BUS_PROTECTION_VECTOR
		ISR_wrapper _SYSTEM_BUS_PROTECTION_VECTOR, SystemBusProtectionInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _CRYPTO_VECTOR
		ISR_wrapper _CRYPTO_VECTOR, CryptoInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _SPI1_FAULT_VECTOR
		ISR_wrapper _SPI1_FAULT_VECTOR, SPI1FaultInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _UART1_FAULT_VECTOR
		ISR_wrapper _UART1_FAULT_VECTOR, UART1FaultInterrupt
	#endif
	
	/* PIC32MZ  */
	#if defined _CHANGE_NOTICE_E_VECTOR
		ISR_wrapper _CHANGE_NOTICE_E_VECTOR, ChangeNoticeEInterrupt
	#endif
	
	/* PIC32MZ  */
	#if defined _CHANGE_NOTICE_F_VECTOR
		ISR_wrapper _CHANGE_NOTICE_F_VECTOR, ChangeNoticeFInterrupt
	#endif
	
	/* PIC32MZ  */
	#if defined _CHANGE_NOTICE_G_VECTOR
		ISR_wrapper _CHANGE_NOTICE_G_VECTOR, ChangeNoticeGInterrupt
	#endif
	
	/* PIC32MZ  */
	#if defined _CHANGE_NOTICE_H_VECTOR
		ISR_wrapper _CHANGE_NOTICE_H_VECTOR, ChangeNoticeHInterrupt
	#endif
	
	/* PIC32MZ  */
	#if defined _CHANGE_NOTICE_J_VECTOR
		ISR_wrapper _CHANGE_NOTICE_J_VECTOR, ChangeNoticeJInterrupt
	#endif
	
	/* PIC32MZ  */
	#if defined _CHANGE_NOTICE_K_VECTOR
		ISR_wrapper _CHANGE_NOTICE_K_VECTOR, ChangeNoticeKInterrupt
	#endif

	/* PIC32MZ */
	#if defined _PMP_ERROR_VECTOR
		ISR_wrapper _PMP_ERROR_VECTOR, PMPErrorInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _USB_DMA_VECTOR
		ISR_wrapper _USB_DMA_VECTOR, USBDMAInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _SPI2_FAULT_VECTOR
		ISR_wrapper _SPI2_FAULT_VECTOR, SPI2FaultInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _UART2_FAULT_VECTOR
		ISR_wrapper _UART2_FAULT_VECTOR, UART2FaultInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _SPI3_FAULT_VECTOR
		ISR_wrapper _SPI3_FAULT_VECTOR, SPI3FaultInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _UART3_FAULT_VECTOR
		ISR_wrapper _UART3_FAULT_VECTOR, UART3FaultInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _SPI4_FAULT_VECTOR
		ISR_wrapper _SPI4_FAULT_VECTOR, SPI4FaultInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _SPI4_RX_VECTOR
		ISR_wrapper _SPI4_RX_VECTOR, SPI4RxInterrupt
	#endif

	/* PIC32MZ */
	#if defined _SPI4_TX_VECTOR
		ISR_wrapper _SPI4_TX_VECTOR, SPI4TxInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _FLASH_CONTROL_VECTOR
		ISR_wrapper _FLASH_CONTROL_VECTOR, FlashControlInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _PREFETCH_VECTOR
		ISR_wrapper _PREFETCH_VECTOR, PrefetchInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _SQI1_VECTOR
		ISR_wrapper _SQI1_VECTOR, SQI1Interrupt
	#endif
	
	/* PIC32MM */
	#if defined _UART4_FAULT_VECTOR
		ISR_wrapper _UART4_FAULT_VECTOR, UART4FaultInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _UART4_RX_VECTOR	
		ISR_wrapper _UART4_RX_VECTOR, UART4RxInterrupt
	#endif

	/* PIC32MZ */
	#if defined _UART4_TX_VECTOR
		ISR_wrapper _UART4_TX_VECTOR, UART4TxInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _I2C4_BUS_VECTOR
		ISR_wrapper _I2C4_BUS_VECTOR, I2C4BusInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _I2C4_SLAVE_VECTOR
		ISR_wrapper _I2C4_SLAVE_VECTOR, I2C4SlaveInterrupt
	#endif

	/* PIC32MZ */
	#if defined _I2C4_MASTER_VECTOR
		ISR_wrapper _I2C4_MASTER_VECTOR, I2C4MasterInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _SPI5_FAULT_VECTOR
		ISR_wrapper _SPI5_FAULT_VECTOR, SPI5FaultInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _SPI5_RX_VECTOR
		ISR_wrapper _SPI5_RX_VECTOR, SPI5RxInterrupt
	#endif

	/* PIC32MZ */
	#if defined _SPI5_TX_VECTOR
		ISR_wrapper _SPI5_TX_VECTOR, SPI5TxInterrupt
	#endif

	/* PIC32MM */
	#if defined _UART5_FAULT_VECTOR
		ISR_wrapper _UART5_FAULT_VECTOR, UART5FaultInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _UART5_RX_VECTOR	
		ISR_wrapper _UART5_RX_VECTOR, UART5RxInterrupt
	#endif

	/* PIC32MZ */
	#if defined _UART5_TX_VECTOR
		ISR_wrapper _UART5_TX_VECTOR, UART5TxInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _I2C5_BUS_VECTOR
		ISR_wrapper _I2C5_BUS_VECTOR, I2C5BusInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _I2C5_SLAVE_VECTOR
		ISR_wrapper _I2C5_SLAVE_VECTOR, I2C5SlaveInterrupt
	#endif

	/* PIC32MZ */
	#if defined _I2C5_MASTER_VECTOR
		ISR_wrapper _I2C5_MASTER_VECTOR, I2C5MasterInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _SPI6_FAULT_VECTOR
		ISR_wrapper _SPI6_FAULT_VECTOR, SPI6FaultInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _SPI6_RX_VECTOR
		ISR_wrapper _SPI6_RX_VECTOR, SPI6RxInterrupt
	#endif

	/* PIC32MZ */
	#if defined _SPI6_TX_VECTOR
		ISR_wrapper _SPI6_TX_VECTOR, SPI6TxInterrupt
	#endif
	
	/* PIC32MM */
	#if defined _UART6_FAULT_VECTOR
		ISR_wrapper _UART6_FAULT_VECTOR, UART6FaultInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _UART6_RX_VECTOR	
		ISR_wrapper _UART6_RX_VECTOR, UART6RxInterrupt
	#endif

	/* PIC32MZ */
	#if defined _UART6_TX_VECTOR
		ISR_wrapper _UART6_TX_VECTOR, UART6TxInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_EOS_VECTOR
		ISR_wrapper _ADC_EOS_VECTOR, ADCEOSInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_ARDY_VECTOR
		ISR_wrapper _ADC_ARDY_VECTOR, ADCARDYInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_URDY_VECTOR
		ISR_wrapper _ADC_URDY_VECTOR, ADCURDYInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC_EARLY_VECTOR
		ISR_wrapper _ADC_EARLY_VECTOR, ADCEARLYInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC0_EARLY_VECTOR
		ISR_wrapper _ADC0_EARLY_VECTOR, ADC0EARLYInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC1_EARLY_VECTOR
		ISR_wrapper _ADC1_EARLY_VECTOR, ADC1EARLYInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC2_EARLY_VECTOR
		ISR_wrapper _ADC2_EARLY_VECTOR, ADC2EARLYInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC3_EARLY_VECTOR
		ISR_wrapper _ADC3_EARLY_VECTOR, ADC3EARLYInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC4_EARLY_VECTOR
		ISR_wrapper _ADC4_EARLY_VECTOR, ADC4EARLYInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC7_EARLY_VECTOR
		ISR_wrapper _ADC7_EARLY_VECTOR, ADC7EARLYInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC0_WARM_VECTOR
		ISR_wrapper _ADC0_WARM_VECTOR, ADC0WARMInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC1_WARM_VECTOR
		ISR_wrapper _ADC1_WARM_VECTOR, ADC1WARMInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC2_WARM_VECTOR
		ISR_wrapper _ADC2_WARM_VECTOR, ADC2WARMInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC3_WARM_VECTOR
		ISR_wrapper _ADC3_WARM_VECTOR, ADC3WARMInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC4_WARM_VECTOR
		ISR_wrapper _ADC4_WARM_VECTOR, ADC4WARMInterrupt
	#endif
	
	/* PIC32MZ */
	#if defined _ADC7_WARM_VECTOR
		ISR_wrapper _ADC7_WARM_VECTOR, ADC7WARMInterrupt
	#endif

	
	
	


/* End of wrappers */

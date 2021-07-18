#ifndef INTERRUPT_H_c0d1278cf1e449b79fb3300a1fe12f51
#define INTERRUPT_H_c0d1278cf1e449b79fb3300a1fe12f51

/* Modeled after avr-libc
** Use as INTERRUPT(vectorFunctionName, optionalArguments){code;}
** For arguments, see gcc mips attributes 
** -> https://gcc.gnu.org/onlinedocs/gcc/MIPS-Function-Attributes.html
*/


// Non PIC32MZ targets (MX, MM)
#if !defined (__PIC32MZ)

#define INTERRUPT(vector, ...)            \
	void vector (void) __attribute__ ((interrupt, __VA_ARGS__)); \
	void vector (void)


// Else we have a PIC32MZ target
#else

// Stringerizer function, and expanded INTERRUPT define
// -> We want to automatically insert the proper .section, because
// -> PIC32MZ can reallocate these sections on the fly.
// -> Aka. there is no need for an intermediary step, with extra jumps.
// Note, this proper .section stuff is necesarry, so we can automate this.
#define STRINGERIZE2(s) #s
#define STRINGERIZE(s) STRINGERIZE2(s)

// CONCATENATE function, to dynamically construct a variable name
// This is necessary, to make a symbol, used by the linker
// when calculating vector_offset_xyz.
// Variable gets discarded as it isn't used, but symbol remains
#define CAT2(x, y) x ## y
#define CAT(x, y) CAT2(x, y)

#define INTERRUPT(vector, ...)            \
	const int CAT(__vector_dispatch_, vector##_NUMBER)  = 42;	\
	void vector (void) __attribute__ ((interrupt, __section__(".vector_" STRINGERIZE(vector##_NUMBER)), __VA_ARGS__)); \
	void vector (void)


// Reverse lookup table, for PIC32MZ devices
// So from function name, we lookup the number of the vector

#define CoreTimerInterrupt_NUMBER			_CORE_TIMER_VECTOR
#define CoreSoftware0Interrupt_NUMBER		_CORE_SOFTWARE_0_VECTOR
#define CoreSoftware1Interrupt_NUMBER		_CORE_SOFTWARE_1_VECTOR
#define External0Interrupt_NUMBER			_EXTERNAL_0_VECTOR
#define Timer1Interrupt_NUMBER				_TIMER_1_VECTOR
#define InputCapture1ErrorInterrupt			_INPUT_CAPTURE_1_ERROR_VECTOR
#define InputCapture1Interrupt_NUMBER		_INPUT_CAPTURE_1_VECTOR
#define OutputCompare1Interrupt_NUMBER		_OUTPUT_COMPARE_1_VECTOR
#define External1Interrupt_NUMBER			_EXTERNAL_1_VECTOR
#define Timer2Interrupt_NUMBER				_TIMER_2_VECTOR
#define InputCapture2ErrorInterrupt			_INPUT_CAPTURE_2_ERROR_VECTOR
#define InputCapture2Interrupt_NUMBER		_INPUT_CAPTURE_2_VECTOR
#define OutputCompare2Interrupt_NUMBER		_OUTPUT_COMPARE_2_VECTOR
#define External2Interrupt_NUMBER			_EXTERNAL_2_VECTOR
#define Timer3Interrupt_NUMBER				_TIMER_3_VECTOR
#define InputCapture3ErrorInterrupt			_INPUT_CAPTURE_3_ERROR_VECTOR
#define InputCapture3Interrupt_NUMBER		_INPUT_CAPTURE_3_VECTOR
#define OutputCompare3Interrupt_NUMBER		_OUTPUT_COMPARE_3_VECTOR
#define External3Interrupt_NUMBER			_EXTERNAL_3_VECTOR
#define Timer4Interrupt_NUMBER				_TIMER_4_VECTOR
#define InputCapture4ErrorInterrupt			_INPUT_CAPTURE_4_ERROR_VECTOR
#define InputCapture4Interrupt_NUMBER		_INPUT_CAPTURE_4_VECTOR
#define OutputCompare4Interrupt_NUMBER		_OUTPUT_COMPARE_4_VECTORy
#define External4Interrupt_NUMBER			_EXTERNAL_4_VECTOR
#define Timer5Interrupt_NUMBER				_TIMER_5_VECTOR
#define InputCapture5ErrorInterrupt			_INPUT_CAPTURE_5_ERROR_VECTOR
#define InputCapture5Interrupt_NUMBER		_INPUT_CAPTURE_5_VECTOR
#define OutputCompare5Interrupt_NUMBER		_OUTPUT_COMPARE_5_VECTOR
#define Timer6Interrupt_NUMBER				_TIMER_6_VECTOR
#define InputCapture6ErrorInterrupt			_INPUT_CAPTURE_6_ERROR_VECTOR
#define InputCapture6Interrupt_NUMBER		_INPUT_CAPTURE_6_VECTOR
#define OutputCompare6Interrupt_NUMBER		_OUTPUT_COMPARE_6_VECTOR
#define Timer7Interrupt_NUMBER				_TIMER_7_VECTOR
#define InputCapture7ErrorInterrupt			_INPUT_CAPTURE_7_ERROR_VECTOR
#define InputCapture7Interrupt_NUMBER		_INPUT_CAPTURE_7_VECTOR
#define OutputCompare7Interrupt_NUMBER		_OUTPUT_COMPARE_7_VECTOR
#define Timer8Interrupt_NUMBER				_TIMER_8_VECTOR
#define InputCapture8ErrorInterrupt			_INPUT_CAPTURE_8_ERROR_VECTOR
#define InputCapture8Interrupt_NUMBER		_INPUT_CAPTURE_8_VECTOR
#define OutputCompare8Interrupt_NUMBER		_OUTPUT_COMPARE_8_VECTOR
#define Timer9Interrupt_NUMBER				_TIMER_9_VECTOR
#define InputCapture9ErrorInterrupt			_INPUT_CAPTURE_9_ERROR_VECTOR
#define InputCapture9Interrupt_NUMBER		_INPUT_CAPTURE_9_VECTOR
#define OutputCompare9Interrupt_NUMBER		_OUTPUT_COMPARE_9_VECTOR
#define ADCInterrupt_NUMBER					_ADC_VECTOR
#define ADCFIFOInterrupt_NUMBER				_ADC_FIFO_VECTOR
#define ADCDC1Interrupt_NUMBER				_ADC_DC1_VECTOR
#define ADCDC2Interrupt_NUMBER				_ADC_DC2_VECTOR
#define ADCDC3Interrupt_NUMBER				_ADC_DC3_VECTOR
#define ADCDC4Interrupt_NUMBER				_ADC_DC4_VECTOR
#define ADCDC5Interrupt_NUMBER				_ADC_DC5_VECTOR
#define ADCDC6Interrupt_NUMBER				_ADC_DC6_VECTOR
#define ADCDF1Interrupt_NUMBER				_ADC_DF1_VECTOR 
#define ADCDF2Interrupt_NUMBER				_ADC_DF2_VECTOR
#define ADCDF3Interrupt_NUMBER				_ADC_DF3_VECTOR
#define ADCDF4Interrupt_NUMBER				_ADC_DF4_VECTOR
#define ADCDF5Interrupt_NUMBER				_ADC_DF5_VECTOR
#define ADCDF6Interrupt_NUMBER				_ADC_DF6_VECTOR
#define ADCFaultInterrupt_NUMBER			_ADC_FAULT_VECTOR
#define ADCData0Interrupt_NUMBER			_ADC_DATA0_VECTOR
#define ADCData1Interrupt_NUMBER			_ADC_DATA1_VECTOR
#define ADCData2Interrupt_NUMBER			_ADC_DATA2_VECTOR
#define ADCData3Interrupt_NUMBER			_ADC_DATA3_VECTOR
#define ADCData4Interrupt_NUMBER			_ADC_DATA4_VECTOR
#define ADCData5Interrupt_NUMBER			_ADC_DATA5_VECTOR
#define ADCData6Interrupt_NUMBER			_ADC_DATA6_VECTOR
#define ADCData7Interrupt_NUMBER			_ADC_DATA7_VECTOR
#define ADCData8Interrupt_NUMBER			_ADC_DATA8_VECTOR
#define ADCData9Interrupt_NUMBER			_ADC_DATA9_VECTOR
#define ADCData10Interrupt_NUMBER			_ADC_DATA10_VECTOR
#define ADCData11Interrupt_NUMBER			_ADC_DATA11_VECTOR
#define ADCData12Interrupt_NUMBER			_ADC_DATA12_VECTOR
#define ADCData13Interrupt_NUMBER			_ADC_DATA13_VECTOR
#define ADCData14Interrupt_NUMBER			_ADC_DATA14_VECTOR
#define ADCData15Interrupt_NUMBER			_ADC_DATA15_VECTOR
#define ADCData16Interrupt_NUMBER			_ADC_DATA16_VECTOR
#define ADCData17Interrupt_NUMBER			_ADC_DATA17_VECTOR
#define ADCData18Interrupt_NUMBER			_ADC_DATA18_VECTOR
#define ADCData19Interrupt_NUMBER			_ADC_DATA19_VECTOR
#define ADCData20Interrupt_NUMBER			_ADC_DATA20_VECTOR
#define ADCData21Interrupt_NUMBER			_ADC_DATA21_VECTOR
#define ADCData22Interrupt_NUMBER			_ADC_DATA22_VECTOR
#define ADCData23Interrupt_NUMBER			_ADC_DATA23_VECTOR
#define ADCData24Interrupt_NUMBER			_ADC_DATA24_VECTOR
#define ADCData25Interrupt_NUMBER			_ADC_DATA25_VECTOR
#define ADCData26Interrupt_NUMBER			_ADC_DATA26_VECTOR
#define ADCData27Interrupt_NUMBER			_ADC_DATA27_VECTOR
#define ADCData28Interrupt_NUMBER			_ADC_DATA28_VECTOR
#define ADCData29Interrupt_NUMBER			_ADC_DATA29_VECTOR
#define ADCData30Interrupt_NUMBER			_ADC_DATA30_VECTOR
#define ADCData31Interrupt_NUMBER			_ADC_DATA31_VECTOR
#define ADCData32Interrupt_NUMBER			_ADC_DATA32_VECTOR
#define ADCData33Interrupt_NUMBER			_ADC_DATA33_VECTOR
#define ADCData34Interrupt_NUMBER			_ADC_DATA34_VECTOR
#define ADCData35Interrupt_NUMBER			_ADC_DATA35_VECTOR
#define ADCData36Interrupt_NUMBER			_ADC_DATA36_VECTOR
#define ADCData37Interrupt_NUMBER			_ADC_DATA37_VECTOR
#define ADCData38Interrupt_NUMBER			_ADC_DATA38_VECTOR
#define ADCData39Interrupt_NUMBER			_ADC_DATA39_VECTOR
#define ADCData40Interrupt_NUMBER			_ADC_DATA40_VECTOR
#define ADCData41Interrupt_NUMBER			_ADC_DATA41_VECTOR
#define ADCData42Interrupt_NUMBER			_ADC_DATA42_VECTOR
#define ADCData43Interrupt_NUMBER			_ADC_DATA43_VECTOR
#define ADCData44Interrupt_NUMBER			_ADC_DATA44_VECTOR
#define PerformanceCounterInterrupt_NUMBER	_CORE_PERF_COUNT_VECTOR
#define FastDebugChannelInterrupt_NUMBER	_CORE_FAST_DEBUG_CHAN_VECTOR
#define SystemBusProtectionInterrupt_NUMBER	_SYSTEM_BUS_PROTECTION_VECTOR
#define CryptoInterrupt_NUMBER				_CRYPTO_VECTOR
#define SPI1FaultInterrupt_NUMBER			_SPI1_FAULT_VECTOR
#define SPI1RxInterrupt_NUMBER				_SPI1_RX_VECTOR
#define SPI1TxInterrupt_NUMBER				_SPI1_TX_VECTOR
#define UART1FaultInterrupt_NUMBER			_UART1_FAULT_VECTOR
#define UART1RxInterrupt_NUMBER				_UART1_RX_VECTOR
#define UART1TxInterrupt_NUMBER				_UART1_TX_VECTOR	
#define I2C1BusInterrupt_NUMBER				_I2C1_BUS_VECTOR
#define I2C1SlaveInterrupt_NUMBER			_I2C1_SLAVE_VECTOR
#define I2C1MasterInterrupt_NUMBER			_I2C1_MASTER_VECTOR
#define ChangeNoticeAInterrupt_NUMBER		_CHANGE_NOTICE_A_VECTOR
#define ChangeNoticeBInterrupt_NUMBER		_CHANGE_NOTICE_B_VECTOR
#define ChangeNoticeCInterrupt_NUMBER		_CHANGE_NOTICE_C_VECTOR
#define ChangeNoticeDInterrupt_NUMBER		_CHANGE_NOTICE_D_VECTOR
#define ChangeNoticeEInterrupt_NUMBER		_CHANGE_NOTICE_E_VECTOR
#define ChangeNoticeFInterrupt_NUMBER		_CHANGE_NOTICE_F_VECTOR
#define ChangeNoticeGInterrupt_NUMBER		_CHANGE_NOTICE_G_VECTOR
#define ChangeNoticeHInterrupt_NUMBER		_CHANGE_NOTICE_H_VECTOR
#define ChangeNoticeJInterrupt_NUMBER		_CHANGE_NOTICE_J_VECTOR
#define ChangeNoticeKInterrupt_NUMBER		_CHANGE_NOTICE_K_VECTOR
#define PMPInterrupt_NUMBER					_PMP_VECTOR
#define PMPErrorInterrupt_NUMBER			_PMP_ERROR_VECTOR
#define Comparator1Interrupt_NUMBER			_COMPARATOR_1_VECTOR
#define Comparator2Interrupt_NUMBER			_COMPARATOR_2_VECTOR
#define USBInterrupt_NUMBER					_USB_VECTOR
#define USBDMAInterrupt_NUMBER				_USB_DMA_VECTOR
#define DMA0Interrupt_NUMBER				_DMA0_VECTOR
#define DMA1Interrupt_NUMBER				_DMA1_VECTOR
#define DMA2Interrupt_NUMBER				_DMA2_VECTOR
#define DMA3Interrupt_NUMBER				_DMA3_VECTOR
#define DMA4Interrupt_NUMBER				_DMA4_VECTOR
#define DMA5Interrupt_NUMBER				_DMA5_VECTOR
#define DMA6Interrupt_NUMBER				_DMA6_VECTOR	
#define DMA7Interrupt_NUMBER				_DMA7_VECTOR
#define SPI2FaultInterrupt_NUMBER			_SPI2_FAULT_VECTOR
#define SPI2RxInterrupt_NUMBER				_SPI2_RX_VECTOR
#define SPI2TxInterrupt_NUMBER				_SPI2_TX_VECTOR
#define UART2FaultInterrupt_NUMBER			_UART2_FAULT_VECTOR	
#define UART2RxInterrupt_NUMBER				_UART2_RX_VECTOR
#define UART2TxInterrupt_NUMBER				_UART2_TX_VECTOR
#define I2C2BusInterrupt_NUMBER				_I2C2_BUS_VECTOR
#define I2C2SlaveInterrupt_NUMBER			_I2C2_SLAVE_VECTOR
#define I2C2MasterInterrupt_NUMBER			_I2C2_MASTER_VECTOR
#define CAN1Interrupt_NUMBER				_CAN1_VECTOR
#define CAN2Interrupt_NUMBER				_CAN2_VECTOR
#define ETHERNETInterrupt_NUMBER			_ETHERNET_VECTOR
#define SPI3FaultInterrupt_NUMBER			_SPI3_FAULT_VECTOR
#define SPI3RxInterrupt_NUMBER				_SPI3_RX_VECTOR
#define SPI3TxInterrupt_NUMBER				_SPI3_TX_VECTOR
#define UART3FaultInterrupt_NUMBER			_UART3_FAULT_VECTOR
#define UART3RxInterrupt_NUMBER				_UART3_RX_VECTOR
#define UART3TxInterrupt_NUMBER				_UART3_TX_VECTOR
#define I2C3BusInterrupt_NUMBER				_I2C3_BUS_VECTOR
#define I2C3SlaveInterrupt_NUMBER			_I2C3_SLAVE_VECTOR
#define I2C3MasterInterrupt_NUMBER			_I2C3_MASTER_VECTOR
#define SPI4FaultInterrupt_NUMBER			_SPI4_FAULT_VECTOR
#define SPI4RxInterrupt_NUMBER				_SPI4_RX_VECTOR
#define SPI4TxInterrupt_NUMBER				_SPI4_TX_VECTOR
#define RTCCInterrupt_NUMBER				_RTCC_VECTOR
#define FlashControlInterrupt_NUMBER		_FLASH_CONTROL_VECTOR
#define PrefetchInterrupt_NUMBER			_PREFETCH_VECTOR
#define SQI1Interrupt_NUMBER				_SQI1_VECTOR
#define UART4FaultInterrupt_NUMBER			_UART4_FAULT_VECTOR
#define UART4RxInterrupt_NUMBER				_UART4_RX_VECTOR
#define UART4TxInterrupt_NUMBER				_UART4_TX_VECTOR
#define I2C4BusInterrupt_NUMBER				_I2C4_BUS_VECTOR
#define I2C4SlaveInterrupt_NUMBER			_I2C4_SLAVE_VECTOR
#define I2C4MasterInterrupt_NUMBER			_I2C4_MASTER_VECTOR
#define SPI5FaultInterrupt_NUMBER			_SPI5_FAULT_VECTOR
#define SPI5RxInterrupt_NUMBER				_SPI5_RX_VECTOR
#define SPI5TxInterrupt_NUMBER				_SPI5_TX_VECTOR
#define UART5FaultInterrupt_NUMBER			_UART5_FAULT_VECTOR
#define UART5RxInterrupt_NUMBER				_UART5_RX_VECTOR
#define UART5TxInterrupt_NUMBER				_UART5_TX_VECTOR
#define I2C5BusInterrupt_NUMBER				_I2C5_BUS_VECTOR
#define I2C5SlaveInterrupt_NUMBER			_I2C5_SLAVE_VECTOR
#define I2C5MasterInterrupt_NUMBER			_I2C5_MASTER_VECTOR
#define SPI6FaultInterrupt_NUMBER			_SPI6_FAULT_VECTOR
#define SPI6RxInterrupt_NUMBER				_SPI6_RX_VECTOR
#define SPI6TxInterrupt_NUMBER				_SPI6_TX_VECTOR
#define UART6FaultInterrupt_NUMBER			_UART6_FAULT_VECTOR
#define UART6RxInterrupt_NUMBER				_UART6_RX_VECTOR
#define UART6TxInterrupt_NUMBER				_UART6_TX_VECTOR
#define ADCEOSInterrupt_NUMBER				_ADC_EOS_VECTOR
#define ADCARDYInterrupt_NUMBER				_ADC_ARDY_VECTOR
#define ADCURDYInterrupt_NUMBER				_ADC_URDY_VECTOR
#define ADCEARLYInterrupt_NUMBER			_ADC_EARLY_VECTOR
#define ADC0EARLYInterrupt_NUMBER			_ADC0_EARLY_VECTOR
#define ADC1EARLYInterrupt_NUMBER			_ADC1_EARLY_VECTOR
#define ADC2EARLYInterrupt_NUMBER			_ADC2_EARLY_VECTOR
#define ADC3EARLYInterrupt_NUMBER			_ADC3_EARLY_VECTOR
#define ADC4EARLYInterrupt_NUMBER			_ADC4_EARLY_VECTOR
#define ADC7EARLYInterrupt_NUMBER			_ADC7_EARLY_VECTOR
#define ADC0WARMInterrupt_NUMBER			_ADC0_WARM_VECTOR
#define ADC1WARMInterrupt_NUMBER			_ADC1_WARM_VECTOR
#define ADC2WARMInterrupt_NUMBER			_ADC2_WARM_VECTOR
#define ADC3WARMInterrupt_NUMBER			_ADC3_WARM_VECTOR
#define ADC4WARMInterrupt_NUMBER			_ADC4_WARM_VECTOR
#define ADC7WARMInterrupt_NUMBER			_ADC7_WARM_VECTOR

#endif
#endif

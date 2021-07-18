/*  --------------------------------------------------------------------
    FILE:               isrwrapper.c
    PROJECT:            pic32-parts-free
    PURPOSE:            weak definition of isr routines
    PROGRAMERS:         Regis Blanchot <rblanchot@gmail.com>
                        Primož "Neofoxx" Kranjec <kranjec.primoz@gmail.com>
    FIRST RELEASE:      05 Feb. 2015
    LAST RELEASE:       25 Jan. 2020
    --------------------------------------------------------------------
    CHANGELOG:
        20200125: Neofoxx:	
            Added all functions that can appear in MX&MM families
            Added the General Exception handler
    --------------------------------------------------------------------
    NOTE: Some vectors on PIC32MX5/6/7 are shared. Vectors were added.

    --------------------------------------------------------------------
    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
----------------------------------------------------------------------*/

#ifndef ISRWRAPPER_C
#define ISRWRAPPER_C


#include <xc.h>
#include <inttypes.h>

// Generally, in DoNothing, there should be an infinite loop,
// to help with debug, if interrupt is undefined.

#ifdef __PIC32MZ
void __attribute__ ((interrupt, __section__(".vector_default")))__DoNothing() {
#else
void __attribute__ ((interrupt))__DoNothing() {
#endif
	// Do something
}

void __attribute__ ((interrupt))__DoNothingGenException(){
	// In your handler, decode exception, then reset.
	// In this one, wait forever

	LATBbits.LATB8 = 1;

	for(;;){
	}
}

// PIC32MZ addition
void __attribute__ ((interrupt ))__DoNothingTlbException(){
	// TLB exception
	for(;;){
	}
}
// PIC32MZ addition
void __attribute__ ((interrupt ))__DoNothingCacheException(){
	// Cache exception
	for(;;){
	}
}


// The functions below don't need to have "interrupt" in the attributes,
// as the aliased function already has it.

// To define your own function elsewhere, define it with:
// ISR(functionName){}
// The ISR macro will expand into void __attribute__ ((interrupt)) functionName()

// CORE INTERRUPTS
void CoreTimerInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void CoreSoftware0Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void CoreSoftware1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ

// EXTERNAL INTERRUPTS
void External0Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void External1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void External2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void External3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void External4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ

// CHANGE NOTICE INTERRUPTS
void ChangeNoticeInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx
void ChangeNoticeAInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MM, PIC32MZ
void ChangeNoticeBInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MM, PIC32MZ
void ChangeNoticeCInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MM, PIC32MZ
void ChangeNoticeDInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MM, PIC32MZ
void ChangeNoticeEInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void ChangeNoticeFInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void ChangeNoticeGInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void ChangeNoticeHInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void ChangeNoticeJInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void ChangeNoticeKInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ



// TIMER INTERRUPTS
void Timer1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void Timer2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void Timer3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void Timer4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void Timer5Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void Timer6Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void Timer7Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void Timer8Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void Timer9Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

// COMPARATOR INTERRUPTS
void Comparator1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void Comparator2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void Comparator3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX1/2xx, PIC32MM

// RTCC INTERRUPTS
void RTCCInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ

// ADC INTERRUPTS
void ADCInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ

void ADCFIFOInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

void ADCDC1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCDC2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCDC3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCDC4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCDC5Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCDC6Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

void ADCDF1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCDF2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCDF3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCDF4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCDF5Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCDF6Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

void ADCFaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

void ADCData0Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCData1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCData2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCData3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCData4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCData5Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCData6Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCData7Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCData8Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCData9Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCData10Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData11Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData12Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData13Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData14Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData15Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData16Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData17Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData18Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData19Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData20Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData21Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData22Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData23Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData24Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData25Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData26Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData27Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData28Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData29Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData30Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData31Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData32Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData33Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData34Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData35Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData36Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData37Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData38Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData39Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData40Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData41Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData42Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData43Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADCData44Interrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ

void ADCEOSInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCARDYInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADCURDYInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

void ADCEARLYInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADC0EARLYInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADC1EARLYInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADC2EARLYInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADC3EARLYInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADC4EARLYInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void ADC7EARLYInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ

void ADC0WARMInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADC1WARMInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADC2WARMInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADC3WARMInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADC4WARMInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void ADC7WARMInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ


// CRC INTERRUPTS
void CRCInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM

// HLVD INTERRUPT
void HLVDInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM

// CLC INTERRUPTS
void CLC1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CLC2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CLC3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CLC4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM

// SPI INTERRUPTS
void SPI1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx
void SPI2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx
void SPI3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx
void SPI4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx

void SPI1TxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void SPI2TxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void SPI3TxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void SPI4TxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void SPI5TxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void SPI6TxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

void SPI1RxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void SPI2RxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void SPI3RxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void SPI4RxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void SPI5RxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void SPI6RxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

void SPI1ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MM
void SPI2ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MM
void SPI3ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MM

void SPI1FaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void SPI2FaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void SPI3FaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void SPI4FaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void SPI5FaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void SPI6FaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ




// UART INTERRUPTS
void UART1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MX1/2xx, PIC32MX3/4xx
void UART2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MX1/2xx, PIC32MX3/4xx
void UART3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MX1/2xx, IC32MX3/4xx
void UART4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MX1/2xx, PIC32MX3/4xx
void UART5Interrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MX1/2xx, PIC32MX3/4xx

void UART1RxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void UART2RxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void UART3RxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void UART4RxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void UART5RxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void UART6RxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

void UART1TxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void UART2TxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void UART3TxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void UART4TxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void UART5TxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void UART6TxInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

void UART1ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MM
void UART2ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MM
void UART3ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MM

void UART1FaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void UART2FaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void UART3FaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void UART4FaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void UART5FaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void UART6FaultInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ


// I2C INTERRUPTS
void I2C1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx
void I2C2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx

void I2C1BusInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void I2C2BusInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MM, PIC32MZ
void I2C3BusInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void I2C4BusInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void I2C5BusInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

void I2C1MasterInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MM, PIC32MZ
void I2C2MasterInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MM, PIC32MZ
void I2C3MasterInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void I2C4MasterInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void I2C5MasterInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ

void I2C1SlaveInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MM, PIC32MZ
void I2C2SlaveInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MM, PIC32MZ
void I2C3SlaveInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void I2C4SlaveInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void I2C5SlaveInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ



// UART/SPI/I2C SHARED INTERRUPTS
void I2C3_SPI3_UART1_SharedInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX5/6/7xx
void I2C4_SPI2_UART3_SharedInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX5/6/7xx
void I2C5_SPI4_UART2_SharedInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX5/6/7xx
void UART4_UART1B_SharedInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX5/6/7xx
void UART6_UART2B_SharedInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX5/6/7xx
void UART5_UART3B_SharedInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MX5/6/7xx



// INPUT CAPTURE / OUTPUT COMPARE INTERRUPTS
void InputCapture1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void InputCapture2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void InputCapture3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void InputCapture4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void InputCapture5Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void InputCapture6Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void InputCapture7Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void InputCapture8Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void InputCapture9Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ


void OutputCompare1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void OutputCompare2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void OutputCompare3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void OutputCompare4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void OutputCompare5Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void OutputCompare6Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void OutputCompare7Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void OutputCompare8Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void OutputCompare9Interrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ



void InputCapture1ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void InputCapture2ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void InputCapture3ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void InputCapture4ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void InputCapture5ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void InputCapture6ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void InputCapture7ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void InputCapture8ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void InputCapture9ErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ


void CCP1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCP2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCP3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCP4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCP5Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCP6Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCP7Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCP8Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCP9Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM

// Subset - CCP TIMER INTERRUPTS
void CCT1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCT2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCT3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCT4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCT5Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCT6Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCT7Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCT8Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void CCT9Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM

// FRC TUNE and DCO TUNE INTERRUPTS
void FRCTuneInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void DCOTuneInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM

// NVM or FCE INTERRUPT
void NVMInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM
void FCEInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx

// PERFORMANCE COUNTER INTERRUPT
void PerformanceCounterInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MM, PIC32MZ

// ECC Single Bit INTERRUPT
void ECCSingleBitErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MM

// FAILSAFE MONITOR INTERRUPT
void FailSafeMonitorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx

// USB INTERRUPT
void USB1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx
void USBInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MM, PIC32MZ
void USBDMAInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

// PMP INTERRUPT
void PMPInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MZ
void PMPErrorInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ

// CTMU INTERRUPT
void CTMUInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx

// DMA INTERRUPT
void DMA0Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void DMA1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void DMA2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void DMA3Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX3/4xx, PIC32MX5/6/7xx, PIC32MM, PIC32MZ
void DMA4Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX5/6/7xx, PIC32MZ
void DMA5Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX5/6/7xx, PIC32MZ
void DMA6Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX5/6/7xx, PIC32MZ
void DMA7Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX5/6/7xx, PIC32MZ

// CAN INTERRUPT
void CAN1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX1/2xx, PIC32MX5/6/7xx, PIC32MZ
void CAN2Interrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX5/6/7xx, PIC32MZ

// ETH INTERRUPT
void ETHInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MX5/6/7xx
void ETHERNETInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ


// MISCELLANEOUS INTERRUPTS
void FastDebugChannelInterrupt() __attribute__ ((weak, alias ("__DoNothing")));		// PIC32MZ
void SystemBusProtectionInterrupt() __attribute__ ((weak, alias ("__DoNothing")));	// PIC32MZ
void CryptoInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MZ
void FlashControlInterrupt() __attribute__ ((weak, alias ("__DoNothing")));			// PIC32MZ
void PrefetchInterrupt() __attribute__ ((weak, alias ("__DoNothing")));				// PIC32MZ
void SQI1Interrupt() __attribute__ ((weak, alias ("__DoNothing")));					// PIC32MZ



// General exception handler. Defined in general_exception.S
void _general_exception_handler() __attribute__ ((weak, alias ("__DoNothingGenException")));

// Simple TLB-Refill exception handler. Defined in simple-tlb-refill-exception.S
void _simple_tlb_refill_exception_handler() __attribute__ ((weak, alias ("__DoNothingTlbException")));
// Cache error exception handler. Defined in cache-err-exception.S
void _cache_err_exception_handler() __attribute__ ((weak, alias ("__DoNothingCacheException")));

#endif // ISRWRAPPER_C


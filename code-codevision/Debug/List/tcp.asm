
;CodeVisionAVR C Compiler V3.14 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32A
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32A
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF __lcd_x=R5
	.DEF __lcd_y=R4
	.DEF __lcd_maxx=R7

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G103:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G103:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x0:
	.DB  0x72,0x65,0x73,0x75,0x6C,0x74,0x2D,0x3E
	.DB  0x25,0x73,0xD,0x0,0x20,0x0,0x6C,0x65
	.DB  0x64,0x0,0x61,0x6C,0x63,0x64,0x0,0x61
	.DB  0x64,0x64,0x0,0x73,0x75,0x62,0x0,0x6D
	.DB  0x75,0x6C,0x0,0x64,0x69,0x76,0x0,0x6D
	.DB  0x6F,0x64,0x0,0x57,0x52,0x4F,0x4E,0x47
	.DB  0x20,0x43,0x4D,0x44,0x21,0xD,0x0,0x49
	.DB  0x4E,0x56,0x41,0x4C,0x49,0x44,0x20,0x43
	.DB  0x4D,0x44,0x21,0xD,0x0,0x3A,0x0,0x2D
	.DB  0x0,0x4E,0x4F,0x20,0x50,0x41,0x52,0x41
	.DB  0x4D,0x53,0x21,0xD,0x0,0x25,0x73,0x0
_0x2000060:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2020003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x04
	.DW  _0x27
	.DW  _0x0*2+14

	.DW  0x05
	.DW  _0x27+4
	.DW  _0x0*2+18

	.DW  0x04
	.DW  _0x27+9
	.DW  _0x0*2+23

	.DW  0x04
	.DW  _0x27+13
	.DW  _0x0*2+27

	.DW  0x04
	.DW  _0x27+17
	.DW  _0x0*2+31

	.DW  0x04
	.DW  _0x27+21
	.DW  _0x0*2+35

	.DW  0x04
	.DW  _0x27+25
	.DW  _0x0*2+39

	.DW  0x01
	.DW  __seed_G100
	.DW  _0x2000060*2

	.DW  0x02
	.DW  __base_y_G101
	.DW  _0x2020003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.14 Advanced
;Automatic Program Generator
;© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : test_controller_project
;Version :
;Date    : 2021-05-13
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega32A
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*******************************************************/
;
;#include <mega32a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include <stdlib.h>
;// Alphanumeric LCD functions
;#include <alcd.h>
;#include <string.h>
;// Declare your global variables here
;
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;
;// Get a character from the USART Receiver
;#ifndef _DEBUG_TERMINAL_IO_
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0000 002B {

	.CSEG
_getchar:
; .FSTART _getchar
; 0000 002C char status,data;
; 0000 002D while (1)
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
_0x3:
; 0000 002E       {
; 0000 002F       while (((status=UCSRA) & RX_COMPLETE)==0);
_0x6:
	IN   R30,0xB
	MOV  R17,R30
	ANDI R30,LOW(0x80)
	BREQ _0x6
; 0000 0030       data=UDR;
	IN   R16,12
; 0000 0031       if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x9
; 0000 0032          return data;
	MOV  R30,R16
	RJMP _0x20C000E
; 0000 0033       }
_0x9:
	RJMP _0x3
; 0000 0034 }
_0x20C000E:
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;#pragma used-
;#endif
;
;// Write a character to the USART Transmitter
;#ifndef _DEBUG_TERMINAL_IO_
;#define _ALTERNATE_PUTCHAR_
;#pragma used+
;void putchar(char c)
; 0000 003D {
_putchar:
; .FSTART _putchar
; 0000 003E while ((UCSRA & DATA_REGISTER_EMPTY)==0);
	ST   -Y,R26
;	c -> Y+0
_0xA:
	SBIS 0xB,5
	RJMP _0xA
; 0000 003F UDR=c;
	LD   R30,Y
	OUT  0xC,R30
; 0000 0040 }
	JMP  _0x20C0008
; .FEND
;#pragma used-
;#endif
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;void display_result(char * result){
; 0000 0047 void display_result(char * result){
_display_result:
; .FSTART _display_result
; 0000 0048  lcd_clear();
	ST   -Y,R27
	ST   -Y,R26
;	*result -> Y+0
	CALL _lcd_clear
; 0000 0049  printf("result->%s\r",result);
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
; 0000 004A  lcd_puts(result);
	LD   R26,Y
	LDD  R27,Y+1
	CALL _lcd_puts
; 0000 004B  return;
	JMP  _0x20C0009
; 0000 004C }
; .FEND
;
;int chartoint(char *charnumber)
; 0000 004F {
_chartoint:
; .FSTART _chartoint
; 0000 0050   return atoi(charnumber);
	ST   -Y,R27
	ST   -Y,R26
;	*charnumber -> Y+0
	LD   R26,Y
	LDD  R27,Y+1
	CALL _atoi
	JMP  _0x20C0009
; 0000 0051 }
; .FEND
;
;int *char_num_list_to_int(char input_param[], int default_value)
; 0000 0054 {
_char_num_list_to_int:
; .FSTART _char_num_list_to_int
; 0000 0055   static int int_numbers[10];
; 0000 0056     char *token;
; 0000 0057                  char char_numbers[100];
; 0000 0058              int index = 0;
; 0000 0059 
; 0000 005A   int i = 0;
; 0000 005B   if (default_value == 1)
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,63
	SBIW R28,37
	CALL __SAVELOCR6
;	input_param -> Y+108
;	default_value -> Y+106
;	*token -> R16,R17
;	char_numbers -> Y+6
;	index -> R18,R19
;	i -> R20,R21
	__GETWRN 18,19,0
	__GETWRN 20,21,0
	CALL SUBOPT_0x0
	SBIW R26,1
	BRNE _0xD
; 0000 005C   {
; 0000 005D     for (i = 0; i < 10; i++)
	__GETWRN 20,21,0
_0xF:
	__CPWRN 20,21,10
	BRGE _0x10
; 0000 005E       int_numbers[i] = 1;
	CALL SUBOPT_0x1
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   X+,R30
	ST   X,R31
	__ADDWRN 20,21,1
	RJMP _0xF
_0x10:
; 0000 005F }
; 0000 0060   else
	RJMP _0x11
_0xD:
; 0000 0061   {
; 0000 0062     for ( i = 0; i < 10; i++)
	__GETWRN 20,21,0
_0x13:
	__CPWRN 20,21,10
	BRGE _0x14
; 0000 0063       int_numbers[i] = 0;
	CALL SUBOPT_0x1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
	__ADDWRN 20,21,1
	RJMP _0x13
_0x14:
; 0000 0064 }
_0x11:
; 0000 0065   strcpy(char_numbers, input_param);
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	__GETW2SX 110
	CALL _strcpy
; 0000 0066 
; 0000 0067   token = strtok(char_numbers, " ");
	MOVW R30,R28
	ADIW R30,6
	CALL SUBOPT_0x2
; 0000 0068   /* walk through other tokens */
; 0000 0069   while (token != NULL)
_0x15:
	MOV  R0,R16
	OR   R0,R17
	BREQ _0x17
; 0000 006A   {
; 0000 006B     int_numbers[index] = chartoint(token);
	MOVW R30,R18
	LDI  R26,LOW(_int_numbers_S0000004000)
	LDI  R27,HIGH(_int_numbers_S0000004000)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	MOVW R26,R16
	RCALL _chartoint
	POP  R26
	POP  R27
	ST   X+,R30
	ST   X,R31
; 0000 006C 
; 0000 006D     token = strtok(NULL, " ");
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL SUBOPT_0x2
; 0000 006E     index += 1;
	__ADDWRN 18,19,1
; 0000 006F   }
	RJMP _0x15
_0x17:
; 0000 0070   return int_numbers;
	LDI  R30,LOW(_int_numbers_S0000004000)
	LDI  R31,HIGH(_int_numbers_S0000004000)
	CALL __LOADLOCR6
	ADIW R28,63
	ADIW R28,47
	RET
; 0000 0071 }
; .FEND
;
;void led_command(char *params)
; 0000 0074 {
_led_command:
; .FSTART _led_command
; 0000 0075   int led_index = params[0] - '0';
; 0000 0076   int led_status = params[1] - '0';
; 0000 0077 
; 0000 0078   if(led_status==1)
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
;	*params -> Y+4
;	led_index -> R16,R17
;	led_status -> R18,R19
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R30,X
	LDI  R31,0
	SBIW R30,48
	MOVW R16,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R30,Z+1
	LDI  R31,0
	SBIW R30,48
	MOVW R18,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R18
	CPC  R31,R19
	BRNE _0x18
; 0000 0079     PORTB = (PORTB | ( 1 << led_index ));
	IN   R1,24
	MOV  R30,R16
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	OUT  0x18,R30
; 0000 007A   if(led_status==0)
_0x18:
	MOV  R0,R18
	OR   R0,R19
	BRNE _0x19
; 0000 007B     PORTB = (PORTB & ~( 1 << led_index ));
	IN   R1,24
	MOV  R30,R16
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	OUT  0x18,R30
; 0000 007C 
; 0000 007D }
_0x19:
	CALL __LOADLOCR4
	JMP  _0x20C0007
; .FEND
;void alcd_command(char *text)
; 0000 007F {
_alcd_command:
; .FSTART _alcd_command
; 0000 0080   // print text to lcd.
; 0000 0081     lcd_clear();
	ST   -Y,R27
	ST   -Y,R26
;	*text -> Y+0
	CALL _lcd_clear
; 0000 0082     lcd_puts(text);
	LD   R26,Y
	LDD  R27,Y+1
	CALL _lcd_puts
; 0000 0083 }
	JMP  _0x20C0009
; .FEND
;void add_command(char *numbers_input)
; 0000 0085 {
_add_command:
; .FSTART _add_command
; 0000 0086    char result[10];
; 0000 0087 
; 0000 0088   int *numbers = char_num_list_to_int(numbers_input, 0);
; 0000 0089   int sum = 0;
; 0000 008A   int i;
; 0000 008B   for (i = 0; i < sizeof(numbers); i++)
	CALL SUBOPT_0x3
;	*numbers_input -> Y+16
;	result -> Y+6
;	*numbers -> R16,R17
;	sum -> R18,R19
;	i -> R20,R21
	LDI  R26,LOW(0)
	CALL SUBOPT_0x4
	__GETWRN 18,19,0
	__GETWRN 20,21,0
_0x1B:
	__CPWRN 20,21,2
	BRGE _0x1C
; 0000 008C     sum += numbers[i];
	CALL SUBOPT_0x5
	__ADDWRR 18,19,30,31
	__ADDWRN 20,21,1
	RJMP _0x1B
_0x1C:
; 0000 008F itoa(sum,result);
	RJMP _0x20C000D
; 0000 0090            display_result(result);
; 0000 0091 }
; .FEND
;
;void mul_command(char *numbers_input)
; 0000 0094 {
_mul_command:
; .FSTART _mul_command
; 0000 0095    char result[10];
; 0000 0096 
; 0000 0097   int *numbers = char_num_list_to_int(numbers_input, 1);
; 0000 0098   int mul = 1;
; 0000 0099   int i;
; 0000 009A   for (i = 0; i < sizeof(numbers); i++)
	CALL SUBOPT_0x3
;	*numbers_input -> Y+16
;	result -> Y+6
;	*numbers -> R16,R17
;	mul -> R18,R19
;	i -> R20,R21
	LDI  R26,LOW(1)
	CALL SUBOPT_0x4
	__GETWRN 18,19,1
	__GETWRN 20,21,0
_0x1E:
	__CPWRN 20,21,2
	BRGE _0x1F
; 0000 009B     mul *= numbers[i];
	CALL SUBOPT_0x5
	MOVW R26,R18
	CALL __MULW12
	MOVW R18,R30
	__ADDWRN 20,21,1
	RJMP _0x1E
_0x1F:
; 0000 009E itoa(mul,result);
	RJMP _0x20C000D
; 0000 009F            display_result(result);
; 0000 00A0 }
; .FEND
;void sub_command(char *numbers_input)
; 0000 00A2 {
_sub_command:
; .FSTART _sub_command
; 0000 00A3   char result[10];
; 0000 00A4 
; 0000 00A5   int *numbers = char_num_list_to_int(numbers_input, 0);
; 0000 00A6   int sub = numbers[0];
; 0000 00A7   int i=0;
; 0000 00A8   for ( i = 1; i < sizeof(numbers); i++)
	CALL SUBOPT_0x3
;	*numbers_input -> Y+16
;	result -> Y+6
;	*numbers -> R16,R17
;	sub -> R18,R19
;	i -> R20,R21
	LDI  R26,LOW(0)
	CALL SUBOPT_0x4
	MOVW R26,R16
	CALL __GETW1P
	MOVW R18,R30
	__GETWRN 20,21,0
	__GETWRN 20,21,1
_0x21:
	__CPWRN 20,21,2
	BRGE _0x22
; 0000 00A9     sub -= numbers[i];
	CALL SUBOPT_0x5
	__SUBWRR 18,19,30,31
	__ADDWRN 20,21,1
	RJMP _0x21
_0x22:
; 0000 00AC itoa(sub,result);
_0x20C000D:
	ST   -Y,R19
	ST   -Y,R18
	MOVW R26,R28
	ADIW R26,8
	CALL _itoa
; 0000 00AD            display_result(result);
	MOVW R26,R28
	ADIW R26,6
	RCALL _display_result
; 0000 00AE }
	CALL __LOADLOCR6
	ADIW R28,18
	RET
; .FEND
;
;void div_command(char *numbers_input)
; 0000 00B1 {
_div_command:
; .FSTART _div_command
; 0000 00B2   char result[10];
; 0000 00B3 
; 0000 00B4   int *numbers = char_num_list_to_int(numbers_input, 1);
; 0000 00B5   float div = numbers[0];
; 0000 00B6   int i;
; 0000 00B7   for (i = 1; i < sizeof(numbers); i++)
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,14
	CALL __SAVELOCR4
;	*numbers_input -> Y+18
;	result -> Y+8
;	*numbers -> R16,R17
;	div -> Y+4
;	i -> R18,R19
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL SUBOPT_0x4
	MOVW R26,R16
	CALL SUBOPT_0x6
	__PUTD1S 4
	__GETWRN 18,19,1
_0x24:
	__CPWRN 18,19,2
	BRGE _0x25
; 0000 00B8     div /= (float)numbers[i];
	MOVW R30,R18
	MOVW R26,R16
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL SUBOPT_0x6
	__GETD2S 4
	CALL __DIVF21
	__PUTD1S 4
	__ADDWRN 18,19,1
	RJMP _0x24
_0x25:
; 0000 00BB ftoa(div, 6, result);
	__GETD1S 4
	CALL __PUTPARD1
	LDI  R30,LOW(6)
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,13
	CALL _ftoa
; 0000 00BC            display_result(result);
	MOVW R26,R28
	ADIW R26,8
	RCALL _display_result
; 0000 00BD }
	CALL __LOADLOCR4
	JMP  _0x20C0004
; .FEND
;
;void mod_command(char *numbers_input)
; 0000 00C0 {
_mod_command:
; .FSTART _mod_command
; 0000 00C1   char result[10];
; 0000 00C2   int *numbers = char_num_list_to_int(numbers_input, 1);
; 0000 00C3   int mod;
; 0000 00C4   mod = numbers[0] % numbers[1];
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,10
	CALL __SAVELOCR4
;	*numbers_input -> Y+14
;	result -> Y+4
;	*numbers -> R16,R17
;	mod -> R18,R19
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL SUBOPT_0x4
	MOVW R26,R16
	LD   R0,X+
	LD   R1,X
	MOVW R26,R16
	ADIW R26,2
	CALL __GETW1P
	MOVW R26,R0
	CALL __MODW21
	MOVW R18,R30
; 0000 00C5 
; 0000 00C6   // SEND mod TO UART.
; 0000 00C7       ftoa(mod, 6, result);
	CALL SUBOPT_0x7
	CALL __PUTPARD1
	LDI  R30,LOW(6)
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,9
	CALL _ftoa
; 0000 00C8            display_result(result);
	MOVW R26,R28
	ADIW R26,4
	RCALL _display_result
; 0000 00C9 }
	CALL __LOADLOCR4
	ADIW R28,16
	RET
; .FEND
;void run_command(char *command_input, char *params_input)
; 0000 00CB {
_run_command:
; .FSTART _run_command
; 0000 00CC   if (strcmp(command_input, "led") == 0)
	ST   -Y,R27
	ST   -Y,R26
;	*command_input -> Y+2
;	*params_input -> Y+0
	CALL SUBOPT_0x8
	__POINTW2MN _0x27,0
	CALL _strcmp
	CPI  R30,0
	BRNE _0x26
; 0000 00CD   {
; 0000 00CE     led_command(params_input);
	LD   R26,Y
	LDD  R27,Y+1
	RCALL _led_command
; 0000 00CF   }
; 0000 00D0   else if (strcmp(command_input, "alcd") == 0)
	RJMP _0x28
_0x26:
	CALL SUBOPT_0x8
	__POINTW2MN _0x27,4
	CALL _strcmp
	CPI  R30,0
	BRNE _0x29
; 0000 00D1   {
; 0000 00D2     alcd_command(params_input);
	LD   R26,Y
	LDD  R27,Y+1
	RCALL _alcd_command
; 0000 00D3   }
; 0000 00D4   else if (strcmp(command_input, "add") == 0)
	RJMP _0x2A
_0x29:
	CALL SUBOPT_0x8
	__POINTW2MN _0x27,9
	CALL _strcmp
	CPI  R30,0
	BRNE _0x2B
; 0000 00D5   {
; 0000 00D6     add_command(params_input);
	LD   R26,Y
	LDD  R27,Y+1
	RCALL _add_command
; 0000 00D7   }
; 0000 00D8   else if (strcmp(command_input, "sub") == 0)
	RJMP _0x2C
_0x2B:
	CALL SUBOPT_0x8
	__POINTW2MN _0x27,13
	CALL _strcmp
	CPI  R30,0
	BRNE _0x2D
; 0000 00D9   {
; 0000 00DA     sub_command(params_input);
	LD   R26,Y
	LDD  R27,Y+1
	RCALL _sub_command
; 0000 00DB   }
; 0000 00DC   else if (strcmp(command_input, "mul") == 0)
	RJMP _0x2E
_0x2D:
	CALL SUBOPT_0x8
	__POINTW2MN _0x27,17
	CALL _strcmp
	CPI  R30,0
	BRNE _0x2F
; 0000 00DD   {
; 0000 00DE     mul_command(params_input);
	LD   R26,Y
	LDD  R27,Y+1
	RCALL _mul_command
; 0000 00DF   }
; 0000 00E0   else if (strcmp(command_input, "div") == 0)
	RJMP _0x30
_0x2F:
	CALL SUBOPT_0x8
	__POINTW2MN _0x27,21
	CALL _strcmp
	CPI  R30,0
	BRNE _0x31
; 0000 00E1   {
; 0000 00E2     div_command(params_input);
	LD   R26,Y
	LDD  R27,Y+1
	RCALL _div_command
; 0000 00E3   }
; 0000 00E4   else if (strcmp(command_input, "mod") == 0)
	RJMP _0x32
_0x31:
	CALL SUBOPT_0x8
	__POINTW2MN _0x27,25
	CALL _strcmp
	CPI  R30,0
	BRNE _0x33
; 0000 00E5   {
; 0000 00E6     mod_command(params_input);
	LD   R26,Y
	LDD  R27,Y+1
	RCALL _mod_command
; 0000 00E7   }
; 0000 00E8   else
	RJMP _0x34
_0x33:
; 0000 00E9   {
; 0000 00EA     // SEND UART ERROR MESSAGE
; 0000 00EB     printf("WRONG CMD!\r");
	__POINTW1FN _0x0,43
	CALL SUBOPT_0x9
; 0000 00EC     return;
	JMP  _0x20C0001
; 0000 00ED   }
_0x34:
_0x32:
_0x30:
_0x2E:
_0x2C:
_0x2A:
_0x28:
; 0000 00EE }
	JMP  _0x20C0001
; .FEND

	.DSEG
_0x27:
	.BYTE 0x1D
;
;void parse_command(char input_param[])
; 0000 00F1 {

	.CSEG
_parse_command:
; .FSTART _parse_command
; 0000 00F2 char *params;
; 0000 00F3   char *command;
; 0000 00F4   char input[100];
; 0000 00F5   strcpy(input, input_param);
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,63
	SBIW R28,37
	CALL __SAVELOCR4
;	input_param -> Y+104
;	*params -> R16,R17
;	*command -> R18,R19
;	input -> Y+4
	CALL SUBOPT_0xA
	CALL SUBOPT_0x0
	CALL _strcpy
; 0000 00F6 
; 0000 00F7 
; 0000 00F8   if (strchr(input, ':') == NULL)
	CALL SUBOPT_0xA
	LDI  R26,LOW(58)
	CALL _strchr
	SBIW R30,0
	BRNE _0x35
; 0000 00F9   {
; 0000 00FA     // wrong command, return and send error.
; 0000 00FB     printf("INVALID CMD!\r");
	__POINTW1FN _0x0,55
	CALL SUBOPT_0x9
; 0000 00FC     return;
	RJMP _0x20C000C
; 0000 00FD   }
; 0000 00FE   command = strtok(input, ":");
_0x35:
	CALL SUBOPT_0xA
	__POINTW2FN _0x0,69
	CALL _strtok
	MOVW R18,R30
; 0000 00FF   params = strtok(NULL, "-");
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	__POINTW2FN _0x0,71
	CALL _strtok
	MOVW R16,R30
; 0000 0100 
; 0000 0101   if (params == NULL)
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x36
; 0000 0102   {
; 0000 0103     // SEND NO PARAMS ERROR
; 0000 0104     printf("NO PARAMS!\r");
	__POINTW1FN _0x0,73
	CALL SUBOPT_0x9
; 0000 0105     return;
	RJMP _0x20C000C
; 0000 0106   }
; 0000 0107   run_command(command, params);
_0x36:
	ST   -Y,R19
	ST   -Y,R18
	MOVW R26,R16
	RCALL _run_command
; 0000 0108 }
_0x20C000C:
	CALL __LOADLOCR4
	ADIW R28,63
	ADIW R28,43
	RET
; .FEND
;
;
;
;void main(void)
; 0000 010D {
_main:
; .FSTART _main
; 0000 010E // Declare your local variables here
; 0000 010F          char buffer[50];
; 0000 0110 
; 0000 0111 // Input/Output Ports initialization
; 0000 0112 // Port A initialization
; 0000 0113 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0114 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	SBIW R28,50
;	buffer -> Y+0
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 0115 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0116 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 0117 
; 0000 0118 // Port B initialization
; 0000 0119 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 011A DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
	LDI  R30,LOW(15)
	OUT  0x17,R30
; 0000 011B // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 011C PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 011D 
; 0000 011E // Port C initialization
; 0000 011F // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0120 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x14,R30
; 0000 0121 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0122 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0000 0123 
; 0000 0124 // Port D initialization
; 0000 0125 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0126 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 0127 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0128 PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0000 0129 
; 0000 012A // Timer/Counter 0 initialization
; 0000 012B // Clock source: System Clock
; 0000 012C // Clock value: Timer 0 Stopped
; 0000 012D // Mode: Normal top=0xFF
; 0000 012E // OC0 output: Disconnected
; 0000 012F TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
; 0000 0130 TCNT0=0x00;
	OUT  0x32,R30
; 0000 0131 OCR0=0x00;
	OUT  0x3C,R30
; 0000 0132 
; 0000 0133 // Timer/Counter 1 initialization
; 0000 0134 // Clock source: System Clock
; 0000 0135 // Clock value: Timer1 Stopped
; 0000 0136 // Mode: Normal top=0xFFFF
; 0000 0137 // OC1A output: Disconnected
; 0000 0138 // OC1B output: Disconnected
; 0000 0139 // Noise Canceler: Off
; 0000 013A // Input Capture on Falling Edge
; 0000 013B // Timer1 Overflow Interrupt: Off
; 0000 013C // Input Capture Interrupt: Off
; 0000 013D // Compare A Match Interrupt: Off
; 0000 013E // Compare B Match Interrupt: Off
; 0000 013F TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 0140 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 0141 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 0142 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0143 ICR1H=0x00;
	OUT  0x27,R30
; 0000 0144 ICR1L=0x00;
	OUT  0x26,R30
; 0000 0145 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0146 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0147 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0148 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0149 
; 0000 014A // Timer/Counter 2 initialization
; 0000 014B // Clock source: System Clock
; 0000 014C // Clock value: Timer2 Stopped
; 0000 014D // Mode: Normal top=0xFF
; 0000 014E // OC2 output: Disconnected
; 0000 014F ASSR=0<<AS2;
	OUT  0x22,R30
; 0000 0150 TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 0151 TCNT2=0x00;
	OUT  0x24,R30
; 0000 0152 OCR2=0x00;
	OUT  0x23,R30
; 0000 0153 
; 0000 0154 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 0155 TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	OUT  0x39,R30
; 0000 0156 
; 0000 0157 // External Interrupt(s) initialization
; 0000 0158 // INT0: Off
; 0000 0159 // INT1: Off
; 0000 015A // INT2: Off
; 0000 015B MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 015C MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 015D 
; 0000 015E 
; 0000 015F // USART initialization
; 0000 0160 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0161 // USART Receiver: On
; 0000 0162 // USART Transmitter: On
; 0000 0163 // USART Mode: Asynchronous
; 0000 0164 // USART Baud Rate: 9600
; 0000 0165 UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
	OUT  0xB,R30
; 0000 0166 UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	LDI  R30,LOW(24)
	OUT  0xA,R30
; 0000 0167 UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 0168 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 0169 UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 016A 
; 0000 016B // Analog Comparator initialization
; 0000 016C // Analog Comparator: Off
; 0000 016D // The Analog Comparator's positive input is
; 0000 016E // connected to the AIN0 pin
; 0000 016F // The Analog Comparator's negative input is
; 0000 0170 // connected to the AIN1 pin
; 0000 0171 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0172 SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 0173 
; 0000 0174 // ADC initialization
; 0000 0175 // ADC disabled
; 0000 0176 ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	OUT  0x6,R30
; 0000 0177 
; 0000 0178 // SPI initialization
; 0000 0179 // SPI disabled
; 0000 017A SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
; 0000 017B 
; 0000 017C // TWI initialization
; 0000 017D // TWI disabled
; 0000 017E TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 017F 
; 0000 0180 // Alphanumeric LCD initialization
; 0000 0181 // Connections are specified in the
; 0000 0182 // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 0183 // RS - PORTA Bit 0
; 0000 0184 // RD - PORTA Bit 1
; 0000 0185 // EN - PORTA Bit 2
; 0000 0186 // D4 - PORTA Bit 4
; 0000 0187 // D5 - PORTA Bit 5
; 0000 0188 // D6 - PORTA Bit 6
; 0000 0189 // D7 - PORTA Bit 7
; 0000 018A // Characters/line: 16
; 0000 018B lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0000 018C // Global enable interrupts
; 0000 018D #asm("sei")
	sei
; 0000 018E lcd_clear();
	CALL _lcd_clear
; 0000 018F 
; 0000 0190 while (1)
_0x37:
; 0000 0191       {
; 0000 0192       // Place your code here
; 0000 0193            scanf("%s",buffer);
	__POINTW1FN _0x0,85
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,2
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _scanf
	ADIW R28,6
; 0000 0194 //            printf("ok get->%s\r",buffer);
; 0000 0195             parse_command(buffer);
	MOVW R26,R28
	RCALL _parse_command
; 0000 0196             printf("\r");
	__POINTW1FN _0x0,10
	CALL SUBOPT_0x9
; 0000 0197       }
	RJMP _0x37
; 0000 0198 }
_0x3A:
	RJMP _0x3A
; .FEND

	.CSEG
_atoi:
; .FSTART _atoi
	ST   -Y,R27
	ST   -Y,R26
   	ldd  r27,y+1
   	ld   r26,y
__atoi0:
   	ld   r30,x
        mov  r24,r26
	MOV  R26,R30
	CALL _isspace
        mov  r26,r24
   	tst  r30
   	breq __atoi1
   	adiw r26,1
   	rjmp __atoi0
__atoi1:
   	clt
   	ld   r30,x
   	cpi  r30,'-'
   	brne __atoi2
   	set
   	rjmp __atoi3
__atoi2:
   	cpi  r30,'+'
   	brne __atoi4
__atoi3:
   	adiw r26,1
__atoi4:
   	clr  r22
   	clr  r23
__atoi5:
   	ld   r30,x
        mov  r24,r26
	MOV  R26,R30
	CALL _isdigit
        mov  r26,r24
   	tst  r30
   	breq __atoi6
   	movw r30,r22
   	lsl  r22
   	rol  r23
   	lsl  r22
   	rol  r23
   	add  r22,r30
   	adc  r23,r31
   	lsl  r22
   	rol  r23
   	ld   r30,x+
   	clr  r31
   	subi r30,'0'
   	add  r22,r30
   	adc  r23,r31
   	rjmp __atoi5
__atoi6:
   	movw r30,r22
   	brtc __atoi7
   	com  r30
   	com  r31
   	adiw r30,1
__atoi7:
   	adiw r28,2
   	ret
; .FEND
_itoa:
; .FSTART _itoa
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    ld   r30,y+
    ld   r31,y+
    adiw r30,0
    brpl __itoa0
    com  r30
    com  r31
    adiw r30,1
    ldi  r22,'-'
    st   x+,r22
__itoa0:
    clt
    ldi  r24,low(10000)
    ldi  r25,high(10000)
    rcall __itoa1
    ldi  r24,low(1000)
    ldi  r25,high(1000)
    rcall __itoa1
    ldi  r24,100
    clr  r25
    rcall __itoa1
    ldi  r24,10
    rcall __itoa1
    mov  r22,r30
    rcall __itoa5
    clr  r22
    st   x,r22
    ret

__itoa1:
    clr	 r22
__itoa2:
    cp   r30,r24
    cpc  r31,r25
    brlo __itoa3
    inc  r22
    sub  r30,r24
    sbc  r31,r25
    brne __itoa2
__itoa3:
    tst  r22
    brne __itoa4
    brts __itoa5
    ret
__itoa4:
    set
__itoa5:
    subi r22,-0x30
    st   x+,r22
    ret
; .FEND
_ftoa:
; .FSTART _ftoa
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	LDI  R30,LOW(0)
	ST   Y,R30
	STD  Y+1,R30
	STD  Y+2,R30
	LDI  R30,LOW(63)
	STD  Y+3,R30
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0x200000D
	CALL SUBOPT_0xB
	__POINTW2FN _0x2000000,0
	CALL _strcpyf
	RJMP _0x20C000B
_0x200000D:
	CPI  R30,LOW(0x7FFF)
	LDI  R26,HIGH(0x7FFF)
	CPC  R31,R26
	BRNE _0x200000C
	CALL SUBOPT_0xB
	__POINTW2FN _0x2000000,1
	CALL _strcpyf
	RJMP _0x20C000B
_0x200000C:
	LDD  R26,Y+12
	TST  R26
	BRPL _0x200000F
	__GETD1S 9
	CALL __ANEGF1
	CALL SUBOPT_0xC
	CALL SUBOPT_0xD
	LDI  R30,LOW(45)
	ST   X,R30
_0x200000F:
	LDD  R26,Y+8
	CPI  R26,LOW(0x7)
	BRLO _0x2000010
	LDI  R30,LOW(6)
	STD  Y+8,R30
_0x2000010:
	LDD  R17,Y+8
_0x2000011:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x2000013
	CALL SUBOPT_0xE
	CALL SUBOPT_0xF
	CALL SUBOPT_0x10
	RJMP _0x2000011
_0x2000013:
	CALL SUBOPT_0x11
	CALL __ADDF12
	CALL SUBOPT_0xC
	LDI  R17,LOW(0)
	__GETD1N 0x3F800000
	CALL SUBOPT_0x10
_0x2000014:
	CALL SUBOPT_0x11
	CALL __CMPF12
	BRLO _0x2000016
	CALL SUBOPT_0xE
	CALL SUBOPT_0x12
	CALL SUBOPT_0x10
	SUBI R17,-LOW(1)
	CPI  R17,39
	BRLO _0x2000017
	CALL SUBOPT_0xB
	__POINTW2FN _0x2000000,5
	CALL _strcpyf
	RJMP _0x20C000B
_0x2000017:
	RJMP _0x2000014
_0x2000016:
	CPI  R17,0
	BRNE _0x2000018
	CALL SUBOPT_0xD
	LDI  R30,LOW(48)
	ST   X,R30
	RJMP _0x2000019
_0x2000018:
_0x200001A:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x200001C
	CALL SUBOPT_0xE
	CALL SUBOPT_0xF
	__GETD2N 0x3F000000
	CALL __ADDF12
	MOVW R26,R30
	MOVW R24,R22
	CALL _floor
	CALL SUBOPT_0x10
	CALL SUBOPT_0x11
	CALL __DIVF21
	CALL __CFD1U
	MOV  R16,R30
	CALL SUBOPT_0xD
	MOV  R30,R16
	SUBI R30,-LOW(48)
	ST   X,R30
	MOV  R30,R16
	LDI  R31,0
	CALL SUBOPT_0xE
	CALL SUBOPT_0x7
	CALL __MULF12
	CALL SUBOPT_0x13
	CALL SUBOPT_0x14
	RJMP _0x200001A
_0x200001C:
_0x2000019:
	LDD  R30,Y+8
	CPI  R30,0
	BREQ _0x20C000A
	CALL SUBOPT_0xD
	LDI  R30,LOW(46)
	ST   X,R30
_0x200001E:
	LDD  R30,Y+8
	SUBI R30,LOW(1)
	STD  Y+8,R30
	SUBI R30,-LOW(1)
	BREQ _0x2000020
	CALL SUBOPT_0x13
	CALL SUBOPT_0x12
	CALL SUBOPT_0xC
	__GETD1S 9
	CALL __CFD1U
	MOV  R16,R30
	CALL SUBOPT_0xD
	MOV  R30,R16
	SUBI R30,-LOW(48)
	ST   X,R30
	MOV  R30,R16
	LDI  R31,0
	CALL SUBOPT_0x13
	CALL SUBOPT_0x7
	CALL SUBOPT_0x14
	RJMP _0x200001E
_0x2000020:
_0x20C000A:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
_0x20C000B:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,13
	RET
; .FEND

	.DSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G101:
; .FSTART __lcd_write_nibble_G101
	ST   -Y,R26
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x1B,R30
	__DELAY_USB 13
	SBI  0x1B,2
	__DELAY_USB 13
	CBI  0x1B,2
	__DELAY_USB 13
	RJMP _0x20C0008
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
	__DELAY_USB 133
	RJMP _0x20C0008
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G101)
	SBCI R31,HIGH(-__base_y_G101)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R5,Y+1
	LDD  R4,Y+0
_0x20C0009:
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x15
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x15
	LDI  R30,LOW(0)
	MOV  R4,R30
	MOV  R5,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2020005
	CP   R5,R7
	BRLO _0x2020004
_0x2020005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R4
	MOV  R26,R4
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2020007
	RJMP _0x20C0008
_0x2020007:
_0x2020004:
	INC  R5
	SBI  0x1B,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x1B,0
	RJMP _0x20C0008
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2020008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x202000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2020008
_0x202000A:
	LDD  R17,Y+0
	JMP  _0x20C0005
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
	SBI  0x1A,2
	SBI  0x1A,0
	SBI  0x1A,1
	CBI  0x1B,2
	CBI  0x1B,0
	CBI  0x1B,1
	LDD  R7,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G101,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G101,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x16
	CALL SUBOPT_0x16
	CALL SUBOPT_0x16
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G101
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20C0008:
	ADIW R28,1
	RET
; .FEND

	.CSEG
_strchr:
; .FSTART _strchr
	ST   -Y,R26
    ld   r26,y+
    ld   r30,y+
    ld   r31,y+
strchr0:
    ld   r27,z
    cp   r26,r27
    breq strchr1
    adiw r30,1
    tst  r27
    brne strchr0
    clr  r30
    clr  r31
strchr1:
    ret
; .FEND
_strcmp:
; .FSTART _strcmp
	ST   -Y,R27
	ST   -Y,R26
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
strcmp0:
    ld   r22,x+
    ld   r23,z+
    cp   r22,r23
    brne strcmp1
    tst  r22
    brne strcmp0
strcmp3:
    clr  r30
    ret
strcmp1:
    sub  r22,r23
    breq strcmp3
    ldi  r30,1
    brcc strcmp2
    subi r30,2
strcmp2:
    ret
; .FEND
_strcpy:
; .FSTART _strcpy
	ST   -Y,R27
	ST   -Y,R26
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
    movw r24,r26
strcpy0:
    ld   r22,z+
    st   x+,r22
    tst  r22
    brne strcpy0
    movw r30,r24
    ret
; .FEND
_strcpyf:
; .FSTART _strcpyf
	ST   -Y,R27
	ST   -Y,R26
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
    movw r24,r26
strcpyf0:
	lpm  r0,z+
    st   x+,r0
    tst  r0
    brne strcpyf0
    movw r30,r24
    ret
; .FEND
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND
_strpbrkf:
; .FSTART _strpbrkf
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+3
    ldd  r26,y+2
strpbrkf0:
    ld   r22,x
    tst  r22
    breq strpbrkf2
    ldd  r31,y+1
    ld   r30,y
strpbrkf1:
	lpm
    tst  r0
    breq strpbrkf3
    adiw r30,1
    cp   r22,r0
    brne strpbrkf1
    movw r30,r26
    rjmp strpbrkf4
strpbrkf3:
    adiw r26,1
    rjmp strpbrkf0
strpbrkf2:
    clr  r30
    clr  r31
strpbrkf4:
	JMP  _0x20C0001
; .FEND
_strspnf:
; .FSTART _strspnf
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+3
    ldd  r26,y+2
    clr  r24
    clr  r25
strspnf0:
    ld   r22,x+
    tst  r22
    breq strspnf2
    ldd  r31,y+1
    ld   r30,y
strspnf1:
	lpm  r0,z+
    tst  r0
    breq strspnf2
    cp   r22,r0
    brne strspnf1
    adiw r24,1
    rjmp strspnf0
strspnf2:
    movw r30,r24
	JMP  _0x20C0001
; .FEND
_strtok:
; .FSTART _strtok
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	SBIW R30,0
	BRNE _0x2040003
	LDS  R30,_p_S1020026000
	LDS  R31,_p_S1020026000+1
	SBIW R30,0
	BRNE _0x2040004
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x20C0006
_0x2040004:
	LDS  R30,_p_S1020026000
	LDS  R31,_p_S1020026000+1
	STD  Y+4,R30
	STD  Y+4+1,R31
_0x2040003:
	CALL SUBOPT_0x17
	CALL _strspnf
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+4,R30
	STD  Y+4+1,R31
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R30,X
	CPI  R30,0
	BRNE _0x2040005
	LDI  R30,LOW(0)
	STS  _p_S1020026000,R30
	STS  _p_S1020026000+1,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x20C0006
_0x2040005:
	CALL SUBOPT_0x17
	CALL _strpbrkf
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2040006
	MOVW R26,R16
	__ADDWRN 16,17,1
	LDI  R30,LOW(0)
	ST   X,R30
_0x2040006:
	__PUTWMRN _p_S1020026000,0,16,17
	LDD  R30,Y+4
	LDD  R31,Y+4+1
_0x20C0006:
	LDD  R17,Y+1
	LDD  R16,Y+0
_0x20C0007:
	ADIW R28,6
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_put_usart_G103:
; .FSTART _put_usart_G103
	ST   -Y,R27
	ST   -Y,R26
	LDD  R26,Y+2
	CALL _putchar
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x20C0005:
	ADIW R28,3
	RET
; .FEND
__print_G103:
; .FSTART __print_G103
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2060016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2060018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x206001C
	CPI  R18,37
	BRNE _0x206001D
	LDI  R17,LOW(1)
	RJMP _0x206001E
_0x206001D:
	CALL SUBOPT_0x18
_0x206001E:
	RJMP _0x206001B
_0x206001C:
	CPI  R30,LOW(0x1)
	BRNE _0x206001F
	CPI  R18,37
	BRNE _0x2060020
	CALL SUBOPT_0x18
	RJMP _0x20600CC
_0x2060020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2060021
	LDI  R16,LOW(1)
	RJMP _0x206001B
_0x2060021:
	CPI  R18,43
	BRNE _0x2060022
	LDI  R20,LOW(43)
	RJMP _0x206001B
_0x2060022:
	CPI  R18,32
	BRNE _0x2060023
	LDI  R20,LOW(32)
	RJMP _0x206001B
_0x2060023:
	RJMP _0x2060024
_0x206001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2060025
_0x2060024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2060026
	ORI  R16,LOW(128)
	RJMP _0x206001B
_0x2060026:
	RJMP _0x2060027
_0x2060025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x206001B
_0x2060027:
	CPI  R18,48
	BRLO _0x206002A
	CPI  R18,58
	BRLO _0x206002B
_0x206002A:
	RJMP _0x2060029
_0x206002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x206001B
_0x2060029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x206002F
	CALL SUBOPT_0x19
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x1A
	RJMP _0x2060030
_0x206002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2060032
	CALL SUBOPT_0x19
	CALL SUBOPT_0x1B
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2060033
_0x2060032:
	CPI  R30,LOW(0x70)
	BRNE _0x2060035
	CALL SUBOPT_0x19
	CALL SUBOPT_0x1B
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2060033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2060036
_0x2060035:
	CPI  R30,LOW(0x64)
	BREQ _0x2060039
	CPI  R30,LOW(0x69)
	BRNE _0x206003A
_0x2060039:
	ORI  R16,LOW(4)
	RJMP _0x206003B
_0x206003A:
	CPI  R30,LOW(0x75)
	BRNE _0x206003C
_0x206003B:
	LDI  R30,LOW(_tbl10_G103*2)
	LDI  R31,HIGH(_tbl10_G103*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x206003D
_0x206003C:
	CPI  R30,LOW(0x58)
	BRNE _0x206003F
	ORI  R16,LOW(8)
	RJMP _0x2060040
_0x206003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2060071
_0x2060040:
	LDI  R30,LOW(_tbl16_G103*2)
	LDI  R31,HIGH(_tbl16_G103*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x206003D:
	SBRS R16,2
	RJMP _0x2060042
	CALL SUBOPT_0x19
	CALL SUBOPT_0x1C
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2060043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2060043:
	CPI  R20,0
	BREQ _0x2060044
	SUBI R17,-LOW(1)
	RJMP _0x2060045
_0x2060044:
	ANDI R16,LOW(251)
_0x2060045:
	RJMP _0x2060046
_0x2060042:
	CALL SUBOPT_0x19
	CALL SUBOPT_0x1C
_0x2060046:
_0x2060036:
	SBRC R16,0
	RJMP _0x2060047
_0x2060048:
	CP   R17,R21
	BRSH _0x206004A
	SBRS R16,7
	RJMP _0x206004B
	SBRS R16,2
	RJMP _0x206004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x206004D
_0x206004C:
	LDI  R18,LOW(48)
_0x206004D:
	RJMP _0x206004E
_0x206004B:
	LDI  R18,LOW(32)
_0x206004E:
	CALL SUBOPT_0x18
	SUBI R21,LOW(1)
	RJMP _0x2060048
_0x206004A:
_0x2060047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x206004F
_0x2060050:
	CPI  R19,0
	BREQ _0x2060052
	SBRS R16,3
	RJMP _0x2060053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2060054
_0x2060053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2060054:
	CALL SUBOPT_0x18
	CPI  R21,0
	BREQ _0x2060055
	SUBI R21,LOW(1)
_0x2060055:
	SUBI R19,LOW(1)
	RJMP _0x2060050
_0x2060052:
	RJMP _0x2060056
_0x206004F:
_0x2060058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x206005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x206005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x206005A
_0x206005C:
	CPI  R18,58
	BRLO _0x206005D
	SBRS R16,3
	RJMP _0x206005E
	SUBI R18,-LOW(7)
	RJMP _0x206005F
_0x206005E:
	SUBI R18,-LOW(39)
_0x206005F:
_0x206005D:
	SBRC R16,4
	RJMP _0x2060061
	CPI  R18,49
	BRSH _0x2060063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2060062
_0x2060063:
	RJMP _0x20600CD
_0x2060062:
	CP   R21,R19
	BRLO _0x2060067
	SBRS R16,0
	RJMP _0x2060068
_0x2060067:
	RJMP _0x2060066
_0x2060068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2060069
	LDI  R18,LOW(48)
_0x20600CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x206006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x1A
	CPI  R21,0
	BREQ _0x206006B
	SUBI R21,LOW(1)
_0x206006B:
_0x206006A:
_0x2060069:
_0x2060061:
	CALL SUBOPT_0x18
	CPI  R21,0
	BREQ _0x206006C
	SUBI R21,LOW(1)
_0x206006C:
_0x2060066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2060059
	RJMP _0x2060058
_0x2060059:
_0x2060056:
	SBRS R16,0
	RJMP _0x206006D
_0x206006E:
	CPI  R21,0
	BREQ _0x2060070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x1A
	RJMP _0x206006E
_0x2060070:
_0x206006D:
_0x2060071:
_0x2060030:
_0x20600CC:
	LDI  R17,LOW(0)
_0x206001B:
	RJMP _0x2060016
_0x2060018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
_0x20C0004:
	ADIW R28,20
	RET
; .FEND
_printf:
; .FSTART _printf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,4
	CALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	STD  Y+6,R30
	STD  Y+6+1,R30
	MOVW R26,R28
	ADIW R26,8
	CALL SUBOPT_0x1D
	LDI  R30,LOW(_put_usart_G103)
	LDI  R31,HIGH(_put_usart_G103)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL __print_G103
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	POP  R15
	RET
; .FEND
_get_usart_G103:
; .FSTART _get_usart_G103
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LDI  R30,LOW(0)
	ST   X,R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	LD   R30,X
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2060078
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0x2060079
_0x2060078:
	CALL _getchar
	MOV  R17,R30
_0x2060079:
	MOV  R30,R17
	LDD  R17,Y+0
	ADIW R28,5
	RET
; .FEND
__scanf_G103:
; .FSTART __scanf_G103
	PUSH R15
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR6
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STD  Y+8,R30
	STD  Y+8+1,R31
	MOV  R20,R30
_0x206007F:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	ADIW R30,1
	STD  Y+16,R30
	STD  Y+16+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R19,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2060081
	CALL SUBOPT_0x1E
	BREQ _0x2060082
_0x2060083:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x1F
	POP  R20
	MOV  R19,R30
	CPI  R30,0
	BREQ _0x2060086
	CALL SUBOPT_0x1E
	BRNE _0x2060087
_0x2060086:
	RJMP _0x2060085
_0x2060087:
	CALL SUBOPT_0x20
	BRGE _0x2060088
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0002
_0x2060088:
	RJMP _0x2060083
_0x2060085:
	MOV  R20,R19
	RJMP _0x2060089
_0x2060082:
	CPI  R19,37
	BREQ PC+2
	RJMP _0x206008A
	LDI  R21,LOW(0)
_0x206008B:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LPM  R19,Z+
	STD  Y+16,R30
	STD  Y+16+1,R31
	CPI  R19,48
	BRLO _0x206008F
	CPI  R19,58
	BRLO _0x206008E
_0x206008F:
	RJMP _0x206008D
_0x206008E:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x206008B
_0x206008D:
	CPI  R19,0
	BRNE _0x2060091
	RJMP _0x2060081
_0x2060091:
_0x2060092:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x1F
	POP  R20
	MOV  R18,R30
	MOV  R26,R30
	CALL _isspace
	CPI  R30,0
	BREQ _0x2060094
	CALL SUBOPT_0x20
	BRGE _0x2060095
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0002
_0x2060095:
	RJMP _0x2060092
_0x2060094:
	CPI  R18,0
	BRNE _0x2060096
	RJMP _0x2060097
_0x2060096:
	MOV  R20,R18
	CPI  R21,0
	BRNE _0x2060098
	LDI  R21,LOW(255)
_0x2060098:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0x206009C
	CALL SUBOPT_0x21
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x1F
	POP  R20
	MOVW R26,R16
	ST   X,R30
	CALL SUBOPT_0x20
	BRGE _0x206009D
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0002
_0x206009D:
	RJMP _0x206009B
_0x206009C:
	CPI  R30,LOW(0x73)
	BRNE _0x20600A6
	CALL SUBOPT_0x21
_0x206009F:
	MOV  R30,R21
	SUBI R21,1
	CPI  R30,0
	BREQ _0x20600A1
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x1F
	POP  R20
	MOV  R19,R30
	CPI  R30,0
	BREQ _0x20600A3
	CALL SUBOPT_0x1E
	BREQ _0x20600A2
_0x20600A3:
	CALL SUBOPT_0x20
	BRGE _0x20600A5
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0002
_0x20600A5:
	RJMP _0x20600A1
_0x20600A2:
	PUSH R17
	PUSH R16
	__ADDWRN 16,17,1
	MOV  R30,R19
	POP  R26
	POP  R27
	ST   X,R30
	RJMP _0x206009F
_0x20600A1:
	MOVW R26,R16
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0x206009B
_0x20600A6:
	SET
	BLD  R15,1
	CLT
	BLD  R15,2
	MOV  R30,R19
	CPI  R30,LOW(0x64)
	BREQ _0x20600AB
	CPI  R30,LOW(0x69)
	BRNE _0x20600AC
_0x20600AB:
	CLT
	BLD  R15,1
	RJMP _0x20600AD
_0x20600AC:
	CPI  R30,LOW(0x75)
	BRNE _0x20600AE
_0x20600AD:
	LDI  R18,LOW(10)
	RJMP _0x20600A9
_0x20600AE:
	CPI  R30,LOW(0x78)
	BRNE _0x20600AF
	LDI  R18,LOW(16)
	RJMP _0x20600A9
_0x20600AF:
	CPI  R30,LOW(0x25)
	BRNE _0x20600B2
	RJMP _0x20600B1
_0x20600B2:
	RJMP _0x20C0003
_0x20600A9:
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
	SET
	BLD  R15,0
_0x20600B3:
	MOV  R30,R21
	SUBI R21,1
	CPI  R30,0
	BRNE PC+2
	RJMP _0x20600B5
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x1F
	POP  R20
	MOV  R19,R30
	CPI  R30,LOW(0x21)
	BRSH _0x20600B6
	CALL SUBOPT_0x20
	BRGE _0x20600B7
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0002
_0x20600B7:
	RJMP _0x20600B8
_0x20600B6:
	SBRC R15,1
	RJMP _0x20600B9
	SET
	BLD  R15,1
	CPI  R19,45
	BRNE _0x20600BA
	BLD  R15,2
	RJMP _0x20600B3
_0x20600BA:
	CPI  R19,43
	BREQ _0x20600B3
_0x20600B9:
	CPI  R18,16
	BRNE _0x20600BC
	MOV  R26,R19
	CALL _isxdigit
	CPI  R30,0
	BREQ _0x20600B8
	RJMP _0x20600BE
_0x20600BC:
	MOV  R26,R19
	CALL _isdigit
	CPI  R30,0
	BRNE _0x20600BF
_0x20600B8:
	SBRC R15,0
	RJMP _0x20600C1
	MOV  R20,R19
	RJMP _0x20600B5
_0x20600BF:
_0x20600BE:
	CPI  R19,97
	BRLO _0x20600C2
	SUBI R19,LOW(87)
	RJMP _0x20600C3
_0x20600C2:
	CPI  R19,65
	BRLO _0x20600C4
	SUBI R19,LOW(55)
	RJMP _0x20600C5
_0x20600C4:
	SUBI R19,LOW(48)
_0x20600C5:
_0x20600C3:
	MOV  R30,R18
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R31,0
	CALL __MULW12U
	MOVW R26,R30
	MOV  R30,R19
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	CLT
	BLD  R15,0
	RJMP _0x20600B3
_0x20600B5:
	CALL SUBOPT_0x21
	SBRS R15,2
	RJMP _0x20600C6
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __ANEGW1
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x20600C6:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	MOVW R26,R16
	ST   X+,R30
	ST   X,R31
_0x206009B:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,1
	STD  Y+8,R30
	STD  Y+8+1,R31
	RJMP _0x20600C7
_0x206008A:
_0x20600B1:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x1F
	POP  R20
	CP   R30,R19
	BREQ _0x20600C8
	CALL SUBOPT_0x20
	BRGE _0x20600C9
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0002
_0x20600C9:
_0x2060097:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	SBIW R30,0
	BRNE _0x20600CA
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0002
_0x20600CA:
	RJMP _0x2060081
_0x20600C8:
_0x20600C7:
_0x2060089:
	RJMP _0x206007F
_0x2060081:
_0x20600C1:
_0x20C0003:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
_0x20C0002:
	CALL __LOADLOCR6
	ADIW R28,18
	POP  R15
	RET
; .FEND
_scanf:
; .FSTART _scanf
	PUSH R15
	MOV  R15,R24
	SBIW R28,3
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,1
	CALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+3,R30
	STD  Y+3+1,R30
	MOVW R26,R28
	ADIW R26,5
	CALL SUBOPT_0x1D
	LDI  R30,LOW(_get_usart_G103)
	LDI  R31,HIGH(_get_usart_G103)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL __scanf_G103
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	POP  R15
	RET
; .FEND

	.CSEG
_isdigit:
; .FSTART _isdigit
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    cpi  r31,'0'
    brlo isdigit0
    cpi  r31,'9'+1
    brlo isdigit1
isdigit0:
    clr  r30
isdigit1:
    ret
; .FEND
_isspace:
; .FSTART _isspace
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    cpi  r31,' '
    breq isspace1
    cpi  r31,9
    brlo isspace0
    cpi  r31,13+1
    brlo isspace1
isspace0:
    clr  r30
isspace1:
    ret
; .FEND
_isxdigit:
; .FSTART _isxdigit
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    subi r31,0x30
    brcs isxdigit0
    cpi  r31,10
    brcs isxdigit1
    andi r31,0x5f
    subi r31,7
    cpi  r31,10
    brcs isxdigit0
    cpi  r31,16
    brcs isxdigit1
isxdigit0:
    clr  r30
isxdigit1:
    ret
; .FEND

	.CSEG
_ftrunc:
; .FSTART _ftrunc
	CALL __PUTPARD2
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
; .FEND
_floor:
; .FSTART _floor
	CALL __PUTPARD2
	CALL __GETD2S0
	CALL _ftrunc
	CALL __PUTD1S0
    brne __floor1
__floor0:
	CALL __GETD1S0
	RJMP _0x20C0001
__floor1:
    brtc __floor0
	CALL __GETD1S0
	__GETD2N 0x3F800000
	CALL __SUBF12
_0x20C0001:
	ADIW R28,4
	RET
; .FEND

	.DSEG
_int_numbers_S0000004000:
	.BYTE 0x14
__seed_G100:
	.BYTE 0x4
__base_y_G101:
	.BYTE 0x4
_p_S1020026000:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	__GETW2SX 106
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1:
	MOVW R30,R20
	LDI  R26,LOW(_int_numbers_S0000004000)
	LDI  R27,HIGH(_int_numbers_S0000004000)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	ST   -Y,R31
	ST   -Y,R30
	__POINTW2FN _0x0,12
	CALL _strtok
	MOVW R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x3:
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,10
	CALL __SAVELOCR6
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	LDI  R27,0
	CALL _char_num_list_to_int
	MOVW R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x5:
	MOVW R30,R20
	MOVW R26,R16
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	CALL __GETW1P
	CALL __CWD1
	CALL __CDF1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	CALL __CWD1
	CALL __CDF1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x8:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x9:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xC:
	__PUTD1S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xD:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,1
	STD  Y+6,R26
	STD  Y+6+1,R27
	SBIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE:
	__GETD2S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	__GETD1N 0x3DCCCCCD
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x10:
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x11:
	__GETD1S 2
	__GETD2S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	__GETD1N 0x41200000
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	__GETD2S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x14:
	CALL __SWAPD12
	CALL __SUBF12
	RJMP SUBOPT_0xC

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x15:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x16:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G101
	__DELAY_USW 200
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x18:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x19:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1A:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1B:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1C:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1D:
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	MOV  R26,R19
	CALL _isspace
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x1F:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x20:
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LD   R26,X
	CPI  R26,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x21:
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	SBIW R30,4
	STD  Y+14,R30
	STD  Y+14+1,R31
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	ADIW R26,4
	LD   R16,X+
	LD   R17,X
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7D0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGF1:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __ANEGF10
	SUBI R23,0x80
__ANEGF10:
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSLB12R
__LSLB12L:
	LSL  R30
	DEC  R0
	BRNE __LSLB12L
__LSLB12R:
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:

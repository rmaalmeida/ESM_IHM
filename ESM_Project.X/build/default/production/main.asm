;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4520
	radix	dec
	CONFIG	MCLRE=ON
	CONFIG	OSC=HS
	CONFIG	WDT=OFF
	CONFIG	LVP=OFF
	CONFIG	DEBUG=OFF
	CONFIG	WDTPS=1


;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global	_main

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_timerWait
	extern	_timerReset
	extern	_timerInit
	extern	_lcdInit
	extern	_kpDebounce
	extern	_kpInit
	extern	_eventInit
	extern	_varInit
	extern	_getTime
	extern	_smLoop
	extern	_outputInit

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PRODL	equ	0xff3


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_main__main	code
_main:
;	.line	18; main.c	kpInit();
	CALL	_kpInit
;	.line	19; main.c	lcdInit();
	CALL	_lcdInit
;	.line	20; main.c	timerInit();
	CALL	_timerInit
;	.line	21; main.c	varInit();
	CALL	_varInit
;	.line	22; main.c	eventInit();
	CALL	_eventInit
;	.line	23; main.c	outputInit();
	CALL	_outputInit
_00106_DS_:
;	.line	27; main.c	timerReset(getTime());
	CALL	_getTime
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_timerReset
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	31; main.c	kpDebounce();
	CALL	_kpDebounce
;	.line	34; main.c	smLoop();
	CALL	_smLoop
;	.line	36; main.c	timerWait();
	CALL	_timerWait
	BRA	_00106_DS_
	RETURN	



; Statistics:
; code size:	   66 (0x0042) bytes ( 0.05%)
;           	   33 (0x0021) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    2 (0x0002) bytes


	end

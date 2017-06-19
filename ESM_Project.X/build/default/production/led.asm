;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4520
	radix	dec


;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global	_initLed
	global	_ledON
	global	_ledOFF

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_led__ledOFF	code
_ledOFF:
;	.line	19; led.c	void ledOFF (int x){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	20; led.c	BitClr(PORTD,x);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x02
	MOVLW	0x01
	MOVWF	r0x03
	CLRF	r0x04
	MOVF	r0x00, W
	BZ	_00122_DS_
	BN	_00125_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00123_DS_:
	RLCF	r0x03, F
	RLCF	r0x04, F
	ADDLW	0x01
	BNC	_00123_DS_
	BRA	_00122_DS_
_00125_DS_:
	BCF	STATUS, 0
_00124_DS_:
	RRCF	r0x04, F
	RRCF	r0x03, F
	ADDLW	0x01
	BNC	_00124_DS_
_00122_DS_:
	COMF	r0x03, W
	MOVWF	r0x00
	MOVF	r0x00, W
	ANDWF	r0x02, F
	LFSR	0x00, 0xf83
	MOVFF	r0x02, INDF0
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__ledON	code
_ledON:
;	.line	14; led.c	void ledON (int x){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	15; led.c	BitSet(PORTD,x);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x02
	MOVLW	0x01
	MOVWF	r0x03
	CLRF	r0x04
	MOVF	r0x00, W
	BZ	_00112_DS_
	BN	_00115_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00113_DS_:
	RLCF	r0x03, F
	RLCF	r0x04, F
	ADDLW	0x01
	BNC	_00113_DS_
	BRA	_00112_DS_
_00115_DS_:
	BCF	STATUS, 0
_00114_DS_:
	RRCF	r0x04, F
	RRCF	r0x03, F
	ADDLW	0x01
	BNC	_00114_DS_
_00112_DS_:
	MOVF	r0x03, W
	MOVWF	r0x00
	MOVF	r0x00, W
	IORWF	r0x02, F
	LFSR	0x00, 0xf83
	MOVFF	r0x02, INDF0
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__initLed	code
_initLed:
;	.line	9; led.c	void initLed (void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	10; led.c	TRISD = 0x00;
	LFSR	0x00, 0xf95
	MOVLW	0x00
	MOVWF	INDF0
;	.line	11; led.c	PORTD = 0xFF;
	LFSR	0x00, 0xf83
	MOVLW	0xff
	MOVWF	INDF0
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  282 (0x011a) bytes ( 0.22%)
;           	  141 (0x008d) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    5 (0x0005) bytes


	end

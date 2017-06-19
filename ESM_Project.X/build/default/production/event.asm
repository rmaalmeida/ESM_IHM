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
	global	_eventInit
	global	_eventRead

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_kpRead
	extern	_kpInit

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PRODL	equ	0xff3


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1

udata_event_0	udata
_key_ant	res	2

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_event__eventRead	code
_eventRead:
;	.line	12; event.c	unsigned int eventRead(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
;	.line	14; event.c	int ev = EV_NOEVENT;
	MOVLW	0x05
	MOVWF	r0x00
	CLRF	r0x01
;	.line	15; event.c	key = kpRead();
	CALL	_kpRead
	MOVWF	r0x02
	CLRF	r0x03
;	.line	16; event.c	if (key != key_ant) {
	MOVF	r0x02, W
	MOVWF	r0x04
	MOVF	r0x03, W
	MOVWF	r0x05
	MOVF	r0x04, W
	BANKSEL	_key_ant
	XORWF	_key_ant, W, B
	BNZ	_00133_DS_
	MOVF	r0x05, W
	BANKSEL	(_key_ant + 1)
	XORWF	(_key_ant + 1), W, B
	BZ	_00117_DS_
_00133_DS_:
;	.line	17; event.c	if (BitTst(key, 0)) {
	BTFSS	r0x02, 0
	BRA	_00111_DS_
;	.line	18; event.c	ev = EV_RIGHT;
	MOVLW	0x03
	MOVWF	r0x00
	CLRF	r0x01
_00111_DS_:
;	.line	21; event.c	if (BitTst(key, 1)) {
	BTFSS	r0x02, 1
	BRA	_00113_DS_
;	.line	22; event.c	ev = EV_LEFT;
	MOVLW	0x02
	MOVWF	r0x00
	CLRF	r0x01
_00113_DS_:
;	.line	25; event.c	if (BitTst(key, 2)) {
	BTFSS	r0x02, 2
	BRA	_00117_DS_
;	.line	26; event.c	ev = EV_ENTER;
	MOVLW	0x04
	MOVWF	r0x00
	CLRF	r0x01
_00117_DS_:
;	.line	30; event.c	key_ant = key;
	MOVFF	r0x02, _key_ant
	MOVFF	r0x03, (_key_ant + 1)
;	.line	31; event.c	return ev;
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_event__eventInit	code
_eventInit:
;	.line	7; event.c	void eventInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	8; event.c	kpInit();
	CALL	_kpInit
	BANKSEL	_key_ant
;	.line	9; event.c	key_ant = 0;
	CLRF	_key_ant, B
	BANKSEL	(_key_ant + 1)
	CLRF	(_key_ant + 1), B
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  170 (0x00aa) bytes ( 0.13%)
;           	   85 (0x0055) words
; udata size:	    2 (0x0002) bytes ( 0.16%)
; access size:	    6 (0x0006) bytes


	end

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
	global	_smInit
	global	_smLoop

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_getState
	extern	_setState
	extern	_getTime
	extern	_setTime
	extern	_getAlarmLevel
	extern	_setAlarmLevel
	extern	_getLanguage
	extern	_setLanguage
	extern	_eventRead
	extern	_outputPrint

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PRODL	equ	0xff3


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_stateMachine__smLoop	code
_smLoop:
;	.line	12; stateMachine.c	void smLoop(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	16; stateMachine.c	evento = eventRead();
	CALL	_eventRead
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
;	.line	18; stateMachine.c	switch (getState()) {
	CALL	_getState
	MOVWF	r0x01
	MOVLW	0x03
	SUBWF	r0x01, W
	BTFSC	STATUS, 0
	BRA	_00131_DS_
	CLRF	PCLATH
	CLRF	PCLATU
	RLCF	r0x01, W
	RLCF	PCLATH, F
	RLCF	WREG, W
	RLCF	PCLATH, F
	ANDLW	0xfc
	ADDLW	LOW(_00165_DS_)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_00165_DS_)
	ADDWFC	PCLATH, F
	MOVLW	UPPER(_00165_DS_)
	ADDWFC	PCLATU, F
	MOVF	PREINC1, W
	MOVWF	PCL
_00165_DS_:
	GOTO	_00110_DS_
	GOTO	_00117_DS_
	GOTO	_00124_DS_
_00110_DS_:
;	.line	21; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00112_DS_
;	.line	22; stateMachine.c	setAlarmLevel(getAlarmLevel() + 1);
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setAlarmLevel
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00112_DS_:
;	.line	24; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00114_DS_
;	.line	25; stateMachine.c	setAlarmLevel(getAlarmLevel() - 1);
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setAlarmLevel
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00114_DS_:
;	.line	29; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_00171_DS_
	BRA	_00131_DS_
_00171_DS_:
;	.line	30; stateMachine.c	setState(STATE_TEMPO);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	32; stateMachine.c	break;
	BRA	_00131_DS_
_00117_DS_:
;	.line	36; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00119_DS_
;	.line	37; stateMachine.c	setTime(getTime() + 1);
	CALL	_getTime
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setTime
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00119_DS_:
;	.line	39; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00121_DS_
;	.line	40; stateMachine.c	setTime(getTime() - 1);
	CALL	_getTime
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setTime
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00121_DS_:
;	.line	44; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00131_DS_
;	.line	45; stateMachine.c	setState(STATE_IDIOMA);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	47; stateMachine.c	break;
	BRA	_00131_DS_
_00124_DS_:
;	.line	52; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00126_DS_
;	.line	53; stateMachine.c	setLanguage(getLanguage() + 1);
	CALL	_getLanguage
	MOVWF	r0x01
	INCF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setLanguage
	MOVF	POSTINC1, F
_00126_DS_:
;	.line	55; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00128_DS_
;	.line	56; stateMachine.c	setLanguage(getLanguage() - 1);
	CALL	_getLanguage
	MOVWF	r0x01
	DECF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setLanguage
	MOVF	POSTINC1, F
_00128_DS_:
;	.line	60; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00131_DS_
;	.line	61; stateMachine.c	setState(STATE_ALARME);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00131_DS_:
;	.line	66; stateMachine.c	outputPrint(getState(), getLanguage());
	CALL	_getState
	MOVWF	r0x00
	CLRF	r0x01
	CALL	_getLanguage
	MOVWF	r0x02
	CLRF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_outputPrint
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_stateMachine__smInit	code
_smInit:
;	.line	8; stateMachine.c	void smInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	9; stateMachine.c	setState(STATE_TEMPO);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  426 (0x01aa) bytes ( 0.33%)
;           	  213 (0x00d5) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    4 (0x0004) bytes


	end

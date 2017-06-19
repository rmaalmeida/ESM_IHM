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
	global	_varInit
	global	_getState
	global	_setState
	global	_getTime
	global	_setTime
	global	_getAlarmLevel
	global	_setAlarmLevel
	global	_getLanguage
	global	_setLanguage

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1

udata_var_0	udata
_state	res	1

udata_var_1	udata
_language	res	1

udata_var_2	udata
_time	res	2

udata_var_3	udata
_alarmLevel	res	2

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_var__setLanguage	code
_setLanguage:
;	.line	43; var.c	void setLanguage(char newLanguage){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	46; var.c	language = newLanguage%2;
	MOVLW	0x01
	ANDWF	r0x00, W
	BANKSEL	_language
	MOVWF	_language, B
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getLanguage	code
_getLanguage:
;	.line	40; var.c	char getLanguage(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_language
;	.line	41; var.c	return language;
	MOVF	_language, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setAlarmLevel	code
_setAlarmLevel:
;	.line	35; var.c	void setAlarmLevel(int newAlarmLevel) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _alarmLevel
	MOVLW	0x03
	MOVFF	PLUSW2, (_alarmLevel + 1)
;	.line	36; var.c	alarmLevel = newAlarmLevel;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getAlarmLevel	code
_getAlarmLevel:
;	.line	32; var.c	int getAlarmLevel(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	33; var.c	return alarmLevel;
	MOVFF	(_alarmLevel + 1), PRODL
	BANKSEL	_alarmLevel
	MOVF	_alarmLevel, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setTime	code
_setTime:
;	.line	27; var.c	void setTime(int newTime) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _time
	MOVLW	0x03
	MOVFF	PLUSW2, (_time + 1)
;	.line	28; var.c	time = newTime;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getTime	code
_getTime:
;	.line	24; var.c	int getTime(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	25; var.c	return time;
	MOVFF	(_time + 1), PRODL
	BANKSEL	_time
	MOVF	_time, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setState	code
_setState:
;	.line	19; var.c	void setState(char newState) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _state
;	.line	20; var.c	state = newState;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getState	code
_getState:
;	.line	16; var.c	char getState(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_state
;	.line	17; var.c	return state;
	MOVF	_state, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__varInit	code
_varInit:
;	.line	9; var.c	void varInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_state
;	.line	10; var.c	state = 0;
	CLRF	_state, B
;	.line	11; var.c	time = 1000;
	MOVLW	0xe8
	BANKSEL	_time
	MOVWF	_time, B
	MOVLW	0x03
	BANKSEL	(_time + 1)
	MOVWF	(_time + 1), B
	BANKSEL	_alarmLevel
;	.line	12; var.c	alarmLevel = 512;
	CLRF	_alarmLevel, B
	MOVLW	0x02
	BANKSEL	(_alarmLevel + 1)
	MOVWF	(_alarmLevel + 1), B
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  228 (0x00e4) bytes ( 0.17%)
;           	  114 (0x0072) words
; udata size:	    6 (0x0006) bytes ( 0.47%)
; access size:	    1 (0x0001) bytes


	end

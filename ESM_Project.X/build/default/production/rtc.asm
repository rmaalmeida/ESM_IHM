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
	global	_rtcInit
	global	_ht1380write
	global	_ht1380read
	global	_rtcSetDateTime
	global	_rtcGetSeconds
	global	_rtcGetMinutes
	global	_rtcGetHours
	global	_rtcGetDate
	global	_rtcGetMonth
	global	_rtcGetYear
	global	_rtcGetDay
	global	_rtcPutSeconds
	global	_rtcPutMinutes
	global	_rtcPutHours
	global	_rtcPutDate
	global	_rtcPutMonth
	global	_rtcPutDay
	global	_rtcPutYear
	global	_de
	global	_rtcStart
	global	_writeByte
	global	_readByte

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	__moduchar
	extern	__divuchar

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1

udata_rtc_0	udata
_de	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_rtc__rtcPutYear	code
_rtcPutYear:
;	.line	228; rtc.c	void rtcPutYear(unsigned char year) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	229; rtc.c	ht1380write(6, (year % 10) | ((year / 10) << 4));
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVFF	r0x00, POSTDEC1
	CALL	__moduchar
	MOVWF	r0x01
	MOVF	PREINC1, W
	MOVF	PREINC1, W
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVFF	r0x00, POSTDEC1
	CALL	__divuchar
	MOVWF	r0x00
	MOVF	PREINC1, W
	MOVF	PREINC1, W
	SWAPF	r0x00, W
	ANDLW	0xf0
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcPutDay	code
_rtcPutDay:
;	.line	224; rtc.c	void rtcPutDay(unsigned char day) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	225; rtc.c	ht1380write(5, day);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcPutMonth	code
_rtcPutMonth:
;	.line	220; rtc.c	void rtcPutMonth(unsigned char month) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	221; rtc.c	ht1380write(4, (month % 10) | ((month / 10) << 4));
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVFF	r0x00, POSTDEC1
	CALL	__moduchar
	MOVWF	r0x01
	MOVF	PREINC1, W
	MOVF	PREINC1, W
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVFF	r0x00, POSTDEC1
	CALL	__divuchar
	MOVWF	r0x00
	MOVF	PREINC1, W
	MOVF	PREINC1, W
	SWAPF	r0x00, W
	ANDLW	0xf0
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcPutDate	code
_rtcPutDate:
;	.line	216; rtc.c	void rtcPutDate(unsigned char date) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	217; rtc.c	ht1380write(3, (date % 10) | ((date / 10) << 4));
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVFF	r0x00, POSTDEC1
	CALL	__moduchar
	MOVWF	r0x01
	MOVF	PREINC1, W
	MOVF	PREINC1, W
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVFF	r0x00, POSTDEC1
	CALL	__divuchar
	MOVWF	r0x00
	MOVF	PREINC1, W
	MOVF	PREINC1, W
	SWAPF	r0x00, W
	ANDLW	0xf0
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcPutHours	code
_rtcPutHours:
;	.line	212; rtc.c	void rtcPutHours(unsigned char hours) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	213; rtc.c	ht1380write(2, (hours % 10) | ((hours / 10) << 4));
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVFF	r0x00, POSTDEC1
	CALL	__moduchar
	MOVWF	r0x01
	MOVF	PREINC1, W
	MOVF	PREINC1, W
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVFF	r0x00, POSTDEC1
	CALL	__divuchar
	MOVWF	r0x00
	MOVF	PREINC1, W
	MOVF	PREINC1, W
	SWAPF	r0x00, W
	ANDLW	0xf0
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcPutMinutes	code
_rtcPutMinutes:
;	.line	208; rtc.c	void rtcPutMinutes(unsigned char minutes) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	209; rtc.c	ht1380write(1, (minutes % 10) | ((minutes / 10) << 4));
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVFF	r0x00, POSTDEC1
	CALL	__moduchar
	MOVWF	r0x01
	MOVF	PREINC1, W
	MOVF	PREINC1, W
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVFF	r0x00, POSTDEC1
	CALL	__divuchar
	MOVWF	r0x00
	MOVF	PREINC1, W
	MOVF	PREINC1, W
	SWAPF	r0x00, W
	ANDLW	0xf0
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcPutSeconds	code
_rtcPutSeconds:
;	.line	204; rtc.c	void rtcPutSeconds(unsigned char seconds) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	205; rtc.c	ht1380write(0, (seconds % 10) | ((seconds / 10) << 4));
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVFF	r0x00, POSTDEC1
	CALL	__moduchar
	MOVWF	r0x01
	MOVF	PREINC1, W
	MOVF	PREINC1, W
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVFF	r0x00, POSTDEC1
	CALL	__divuchar
	MOVWF	r0x00
	MOVF	PREINC1, W
	MOVF	PREINC1, W
	SWAPF	r0x00, W
	ANDLW	0xf0
	MOVWF	r0x02
	MOVF	r0x02, W
	IORWF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcGetDay	code
_rtcGetDay:
;	.line	188; rtc.c	unsigned char rtcGetDay(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	190; rtc.c	value = ht1380read(5);
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_ht1380read
	MOVWF	r0x00
	MOVF	POSTINC1, F
;	.line	191; rtc.c	return (value & 0x0f); // 1..7
	MOVLW	0x0f
	ANDWF	r0x00, F
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcGetYear	code
_rtcGetYear:
;	.line	182; rtc.c	unsigned char rtcGetYear(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	184; rtc.c	value = ht1380read(6);
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_ht1380read
	MOVWF	r0x00
	MOVF	POSTINC1, F
;	.line	185; rtc.c	return (((value >> 4)&0x0f)*10 + (value & 0x0f));
	SWAPF	r0x00, W
	ANDLW	0x0f
	MOVWF	r0x01
	MOVLW	0x0f
	ANDWF	r0x01, F
; ;multiply lit val:0x0a by variable r0x01 and store in r0x01
	MOVF	r0x01, W
	MULLW	0x0a
	MOVFF	PRODL, r0x01
	MOVLW	0x0f
	ANDWF	r0x00, F
	MOVF	r0x00, W
	ADDWF	r0x01, F
	MOVF	r0x01, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcGetMonth	code
_rtcGetMonth:
;	.line	176; rtc.c	unsigned char rtcGetMonth(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	178; rtc.c	value = ht1380read(4);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_ht1380read
	MOVWF	r0x00
	MOVF	POSTINC1, F
;	.line	179; rtc.c	return (((value >> 4)&0x01)*10 + (value & 0x0f));
	MOVF	r0x00, W
	ANDLW	0x10
	SWAPF	WREG, W
	MOVWF	r0x01
; ;multiply lit val:0x0a by variable r0x01 and store in r0x01
	MOVF	r0x01, W
	MULLW	0x0a
	MOVFF	PRODL, r0x01
	MOVLW	0x0f
	ANDWF	r0x00, F
	MOVF	r0x00, W
	ADDWF	r0x01, F
	MOVF	r0x01, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcGetDate	code
_rtcGetDate:
;	.line	170; rtc.c	unsigned char rtcGetDate(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	172; rtc.c	value = ht1380read(3);
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_ht1380read
	MOVWF	r0x00
	MOVF	POSTINC1, F
;	.line	173; rtc.c	return (((value >> 4)&0x03)*10 + (value & 0x0f));
	SWAPF	r0x00, W
	ANDLW	0x0f
	MOVWF	r0x01
	MOVLW	0x03
	ANDWF	r0x01, F
; ;multiply lit val:0x0a by variable r0x01 and store in r0x01
	MOVF	r0x01, W
	MULLW	0x0a
	MOVFF	PRODL, r0x01
	MOVLW	0x0f
	ANDWF	r0x00, F
	MOVF	r0x00, W
	ADDWF	r0x01, F
	MOVF	r0x01, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcGetHours	code
_rtcGetHours:
;	.line	164; rtc.c	unsigned char rtcGetHours(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	166; rtc.c	value = ht1380read(2);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_ht1380read
	MOVWF	r0x00
	MOVF	POSTINC1, F
;	.line	167; rtc.c	return (((value >> 4)&0x03)*10 + (value & 0x0f));
	SWAPF	r0x00, W
	ANDLW	0x0f
	MOVWF	r0x01
	MOVLW	0x03
	ANDWF	r0x01, F
; ;multiply lit val:0x0a by variable r0x01 and store in r0x01
	MOVF	r0x01, W
	MULLW	0x0a
	MOVFF	PRODL, r0x01
	MOVLW	0x0f
	ANDWF	r0x00, F
	MOVF	r0x00, W
	ADDWF	r0x01, F
	MOVF	r0x01, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcGetMinutes	code
_rtcGetMinutes:
;	.line	158; rtc.c	unsigned char rtcGetMinutes(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	160; rtc.c	value = ht1380read(1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_ht1380read
	MOVWF	r0x00
	MOVF	POSTINC1, F
;	.line	161; rtc.c	return (((value >> 4)&0x07)*10 + (value & 0x0f));
	SWAPF	r0x00, W
	ANDLW	0x0f
	MOVWF	r0x01
	MOVLW	0x07
	ANDWF	r0x01, F
; ;multiply lit val:0x0a by variable r0x01 and store in r0x01
	MOVF	r0x01, W
	MULLW	0x0a
	MOVFF	PRODL, r0x01
	MOVLW	0x0f
	ANDWF	r0x00, F
	MOVF	r0x00, W
	ADDWF	r0x01, F
	MOVF	r0x01, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcGetSeconds	code
_rtcGetSeconds:
;	.line	151; rtc.c	unsigned char rtcGetSeconds(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	153; rtc.c	value = ht1380read(0); // read seconds
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_ht1380read
	MOVWF	r0x00
	MOVF	POSTINC1, F
;	.line	154; rtc.c	return (((value >> 4)&0x07)*10 + (value & 0x0f));
	SWAPF	r0x00, W
	ANDLW	0x0f
	MOVWF	r0x01
	MOVLW	0x07
	ANDWF	r0x01, F
; ;multiply lit val:0x0a by variable r0x01 and store in r0x01
	MOVF	r0x01, W
	MULLW	0x0a
	MOVFF	PRODL, r0x01
	MOVLW	0x0f
	ANDWF	r0x00, F
	MOVF	r0x00, W
	ADDWF	r0x01, F
	MOVF	r0x01, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcSetDateTime	code
_rtcSetDateTime:
;	.line	139; rtc.c	void rtcSetDateTime(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	141; rtc.c	ht1380write(7, 0); //disable write protection
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x07
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	142; rtc.c	ht1380write(0, 0x0); //sec
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	143; rtc.c	ht1380write(1, 0x21); //min
	MOVLW	0x21
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	144; rtc.c	ht1380write(2, 0x23); //hora
	MOVLW	0x23
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	145; rtc.c	ht1380write(3, 0x28); //dia
	MOVLW	0x28
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	146; rtc.c	ht1380write(4, 0x10); //mes
	MOVLW	0x10
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	147; rtc.c	ht1380write(5, 0x6); //dia semana
	MOVLW	0x06
	MOVWF	POSTDEC1
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	148; rtc.c	ht1380write(6, 0x12); //ano
	MOVLW	0x12
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__ht1380read	code
_ht1380read:
;	.line	119; rtc.c	unsigned char ht1380read(unsigned char addr) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	121; rtc.c	RESET_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x01
	BCF	r0x01, 5
	LFSR	0x00, 0xf82
	MOVFF	r0x01, INDF0
;	.line	122; rtc.c	SCL_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x01
	BCF	r0x01, 3
	LFSR	0x00, 0xf82
	MOVFF	r0x01, INDF0
;	.line	123; rtc.c	SDA_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x01
	BCF	r0x01, 4
	LFSR	0x00, 0xf82
	MOVFF	r0x01, INDF0
;	.line	125; rtc.c	RESET_ON();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x01
	BSF	r0x01, 5
	LFSR	0x00, 0xf82
	MOVFF	r0x01, INDF0
;	.line	126; rtc.c	addr <<= 1;   //corrige endere?o
	BCF	STATUS, 0
	RLCF	r0x00, F
;	.line	127; rtc.c	addr |= 0x81; //liga bit de leitura e hab. clk
	MOVLW	0x81
	IORWF	r0x00, F
;	.line	128; rtc.c	writeByte(addr);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_writeByte
	MOVF	POSTINC1, F
;	.line	129; rtc.c	SDA_IN();
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BSF	r0x00, 4
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
;	.line	130; rtc.c	DELAY();DELAY();DELAY();DELAY();
	MOVLW	0x64
	BANKSEL	_de
	MOVWF	_de, B
_00217_DS_:
	BANKSEL	_de
	DECF	_de, F, B
	BANKSEL	_de
	MOVF	_de, W, B
	BNZ	_00217_DS_
	MOVLW	0x64
	BANKSEL	_de
	MOVWF	_de, B
_00220_DS_:
	BANKSEL	_de
	DECF	_de, F, B
	BANKSEL	_de
	MOVF	_de, W, B
	BNZ	_00220_DS_
	MOVLW	0x64
	BANKSEL	_de
	MOVWF	_de, B
_00223_DS_:
	BANKSEL	_de
	DECF	_de, F, B
	BANKSEL	_de
	MOVF	_de, W, B
	BNZ	_00223_DS_
	MOVLW	0x64
	BANKSEL	_de
	MOVWF	_de, B
_00226_DS_:
	BANKSEL	_de
	DECF	_de, F, B
	BANKSEL	_de
	MOVF	_de, W, B
	BNZ	_00226_DS_
	MOVLW	0x64
	BANKSEL	_de
	MOVWF	_de, B
;	.line	131; rtc.c	dados = readByte();
	CALL	_readByte
	MOVWF	r0x00
;	.line	132; rtc.c	RESET_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x01
	BCF	r0x01, 5
	LFSR	0x00, 0xf82
	MOVFF	r0x01, INDF0
;	.line	133; rtc.c	SCL_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x01
	BCF	r0x01, 3
	LFSR	0x00, 0xf82
	MOVFF	r0x01, INDF0
;	.line	134; rtc.c	SDA_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x01
	BCF	r0x01, 4
	LFSR	0x00, 0xf82
	MOVFF	r0x01, INDF0
;	.line	135; rtc.c	SDA_OUT();
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x01
	BCF	r0x01, 4
	LFSR	0x00, 0xf94
	MOVFF	r0x01, INDF0
;	.line	136; rtc.c	return dados;
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__ht1380write	code
_ht1380write:
;	.line	102; rtc.c	void ht1380write(unsigned char addr, unsigned char dados) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	103; rtc.c	RESET_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x02
	BCF	r0x02, 5
	LFSR	0x00, 0xf82
	MOVFF	r0x02, INDF0
;	.line	104; rtc.c	SCL_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x02
	BCF	r0x02, 3
	LFSR	0x00, 0xf82
	MOVFF	r0x02, INDF0
;	.line	105; rtc.c	SDA_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x02
	BCF	r0x02, 4
	LFSR	0x00, 0xf82
	MOVFF	r0x02, INDF0
;	.line	108; rtc.c	RESET_ON();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x02
	BSF	r0x02, 5
	LFSR	0x00, 0xf82
	MOVFF	r0x02, INDF0
;	.line	110; rtc.c	addr <<= 1;   //corrige endere?o
	BCF	STATUS, 0
	RLCF	r0x00, F
;	.line	111; rtc.c	addr |= 0x80; //habilita clock
	BSF	r0x00, 7
;	.line	112; rtc.c	writeByte(addr);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_writeByte
	MOVF	POSTINC1, F
;	.line	113; rtc.c	writeByte(dados);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_writeByte
	MOVF	POSTINC1, F
;	.line	114; rtc.c	RESET_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf82
	MOVFF	r0x00, INDF0
;	.line	115; rtc.c	SCL_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x00
	BCF	r0x00, 3
	LFSR	0x00, 0xf82
	MOVFF	r0x00, INDF0
;	.line	116; rtc.c	SDA_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf82
	MOVFF	r0x00, INDF0
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__readByte	code
_readByte:
;	.line	82; rtc.c	unsigned char readByte() {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	85; rtc.c	dados = 0;
	CLRF	r0x00
;	.line	86; rtc.c	for (i = 0; i < 8; i++) {
	CLRF	r0x01
_00171_DS_:
;	.line	87; rtc.c	SCL_ON();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x02
	BSF	r0x02, 3
	LFSR	0x00, 0xf82
	MOVFF	r0x02, INDF0
;	.line	88; rtc.c	DELAY();
	MOVLW	0x64
	BANKSEL	_de
	MOVWF	_de, B
_00167_DS_:
	BANKSEL	_de
	DECF	_de, F, B
	BANKSEL	_de
	MOVF	_de, W, B
	BNZ	_00167_DS_
	MOVLW	0x64
	BANKSEL	_de
	MOVWF	_de, B
;	.line	90; rtc.c	dados >>= 1;
	BCF	STATUS, 0
	RRCF	r0x00, F
;	.line	92; rtc.c	if (SDA()) {
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x02
	BTFSS	r0x02, 4
	BRA	_00162_DS_
;	.line	93; rtc.c	dados |= 0x80;
	BSF	r0x00, 7
_00162_DS_:
;	.line	96; rtc.c	SCL_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x02
	BCF	r0x02, 3
	LFSR	0x00, 0xf82
	MOVFF	r0x02, INDF0
;	.line	97; rtc.c	DELAY();
	MOVLW	0x64
	BANKSEL	_de
	MOVWF	_de, B
_00170_DS_:
	BANKSEL	_de
	DECF	_de, F, B
	BANKSEL	_de
	MOVF	_de, W, B
	BNZ	_00170_DS_
	MOVLW	0x64
	BANKSEL	_de
	MOVWF	_de, B
;	.line	86; rtc.c	for (i = 0; i < 8; i++) {
	INCF	r0x01, F
	MOVLW	0x08
	SUBWF	r0x01, W
	BTFSS	STATUS, 0
	BRA	_00171_DS_
;	.line	99; rtc.c	return dados;
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__writeByte	code
_writeByte:
;	.line	61; rtc.c	void writeByte(unsigned char dados) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	63; rtc.c	for (i = 0; i < 8; i++) {
	CLRF	r0x01
_00127_DS_:
;	.line	65; rtc.c	if (dados & 0x01) {
	BTFSS	r0x00, 0
	BRA	_00116_DS_
;	.line	66; rtc.c	SDA_ON();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x02
	BSF	r0x02, 4
	LFSR	0x00, 0xf82
	MOVFF	r0x02, INDF0
	BRA	_00117_DS_
_00116_DS_:
;	.line	68; rtc.c	SDA_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x02
	BCF	r0x02, 4
	LFSR	0x00, 0xf82
	MOVFF	r0x02, INDF0
_00117_DS_:
;	.line	71; rtc.c	dados >>= 1;
	BCF	STATUS, 0
	RRCF	r0x00, F
;	.line	73; rtc.c	SCL_ON();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x02
	BSF	r0x02, 3
	LFSR	0x00, 0xf82
	MOVFF	r0x02, INDF0
;	.line	74; rtc.c	DELAY();
	MOVLW	0x64
	BANKSEL	_de
	MOVWF	_de, B
_00123_DS_:
	BANKSEL	_de
	DECF	_de, F, B
	BANKSEL	_de
	MOVF	_de, W, B
	BNZ	_00123_DS_
;	.line	76; rtc.c	SCL_OFF();
	LFSR	0x00, 0xf82
	MOVFF	INDF0, r0x02
	BCF	r0x02, 3
	LFSR	0x00, 0xf82
	MOVFF	r0x02, INDF0
;	.line	77; rtc.c	DELAY();
	MOVLW	0x64
	BANKSEL	_de
	MOVWF	_de, B
_00126_DS_:
	BANKSEL	_de
	DECF	_de, F, B
	BANKSEL	_de
	MOVF	_de, W, B
	BNZ	_00126_DS_
	MOVLW	0x64
	BANKSEL	_de
	MOVWF	_de, B
;	.line	63; rtc.c	for (i = 0; i < 8; i++) {
	INCF	r0x01, F
	MOVLW	0x08
	SUBWF	r0x01, W
	BTFSS	STATUS, 0
	BRA	_00127_DS_
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcStart	code
_rtcStart:
;	.line	53; rtc.c	void rtcStart() {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	55; rtc.c	RESET_OUT();
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
;	.line	56; rtc.c	SDA_OUT();
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
;	.line	57; rtc.c	SCL_OUT();
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BCF	r0x00, 3
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
;	.line	58; rtc.c	BitClr(INTCON2, 7); //liga pull up
	LFSR	0x00, 0xff1
	MOVFF	INDF0, r0x00
	BCF	r0x00, 7
	LFSR	0x00, 0xff1
	MOVFF	r0x00, INDF0
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcInit	code
_rtcInit:
;	.line	46; rtc.c	void rtcInit() {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	48; rtc.c	RESET_OUT();
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
;	.line	49; rtc.c	SDA_OUT();
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
;	.line	50; rtc.c	SCL_OUT();
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BCF	r0x00, 3
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 2274 (0x08e2) bytes ( 1.73%)
;           	 1137 (0x0471) words
; udata size:	    1 (0x0001) bytes ( 0.08%)
; access size:	    3 (0x0003) bytes


	end

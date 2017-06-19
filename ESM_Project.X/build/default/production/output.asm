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
	global	_outputInit
	global	_outputPrint

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_lcdCommand
	extern	_lcdString
	extern	_lcdInt
	extern	_lcdInit
	extern	_getTime
	extern	_getAlarmLevel
	extern	_getLanguage
	extern	__mulint

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTINC0	equ	0xfee
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3


	idata
_msgs	db	LOW(___str_3), HIGH(___str_3), UPPER(___str_3), LOW(___str_4), HIGH(___str_4), UPPER(___str_4), LOW(___str_5), HIGH(___str_5), UPPER(___str_5), LOW(___str_6), HIGH(___str_6), UPPER(___str_6)
	db	LOW(___str_7), HIGH(___str_7), UPPER(___str_7), LOW(___str_8), HIGH(___str_8), UPPER(___str_8)


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1
r0x07	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_output__outputPrint	code
_outputPrint:
;	.line	20; output.c	void outputPrint(int numTela, int idioma) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	22; output.c	if (numTela == STATE_TEMPO) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00137_DS_
	MOVF	r0x01, W
	BZ	_00138_DS_
_00137_DS_:
	BRA	_00111_DS_
_00138_DS_:
;	.line	23; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	24; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	25; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	26; output.c	lcdInt(getTime());
	CALL	_getTime
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	27; output.c	lcdString("           ");//para apagar os textos depois do numero
	MOVLW	UPPER(___str_0)
	MOVWF	r0x06
	MOVLW	HIGH(___str_0)
	MOVWF	r0x05
	MOVLW	LOW(___str_0)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00111_DS_:
;	.line	29; output.c	if (numTela == STATE_ALARME) {
	MOVF	r0x00, W
	IORWF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00113_DS_
;	.line	30; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	31; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	32; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	33; output.c	lcdInt(getAlarmLevel());
	CALL	_getAlarmLevel
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	34; output.c	lcdString("           ");//para apagar os textos depois do numero
	MOVLW	UPPER(___str_0)
	MOVWF	r0x06
	MOVLW	HIGH(___str_0)
	MOVWF	r0x05
	MOVLW	LOW(___str_0)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00113_DS_:
;	.line	36; output.c	if (numTela == STATE_IDIOMA) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00139_DS_
	MOVF	r0x01, W
	BZ	_00140_DS_
_00139_DS_:
	BRA	_00120_DS_
_00140_DS_:
;	.line	37; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	38; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x00, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x01, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	POSTINC0, r0x00
	MOVFF	POSTINC0, r0x01
	MOVFF	INDF0, r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	39; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	40; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x00
	MOVF	r0x00, W
	BNZ	_00115_DS_
;	.line	41; output.c	lcdString("Portugues       ");
	MOVLW	UPPER(___str_1)
	MOVWF	r0x02
	MOVLW	HIGH(___str_1)
	MOVWF	r0x01
	MOVLW	LOW(___str_1)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00115_DS_:
;	.line	43; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x00
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00120_DS_
;	.line	44; output.c	lcdString("English         ");
	MOVLW	UPPER(___str_2)
	MOVWF	r0x02
	MOVLW	HIGH(___str_2)
	MOVWF	r0x01
	MOVLW	LOW(___str_2)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00120_DS_:
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_output__outputInit	code
_outputInit:
;	.line	16; output.c	void outputInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	17; output.c	lcdInit();
	CALL	_lcdInit
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
___str_0:
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_1:
	DB	0x50, 0x6f, 0x72, 0x74, 0x75, 0x67, 0x75, 0x65, 0x73, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_2:
	DB	0x45, 0x6e, 0x67, 0x6c, 0x69, 0x73, 0x68, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_3:
	DB	0x41, 0x6c, 0x74, 0x65, 0x72, 0x61, 0x72, 0x20, 0x61, 0x6c, 0x61, 0x72
	DB	0x6d, 0x65, 0x20, 0x00
; ; Starting pCode block
___str_4:
	DB	0x43, 0x68, 0x61, 0x6e, 0x67, 0x65, 0x20, 0x61, 0x6c, 0x61, 0x72, 0x6d
	DB	0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_5:
	DB	0x41, 0x6c, 0x74, 0x65, 0x72, 0x61, 0x72, 0x20, 0x74, 0x65, 0x6d, 0x70
	DB	0x6f, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_6:
	DB	0x43, 0x68, 0x61, 0x6e, 0x67, 0x65, 0x20, 0x74, 0x69, 0x6d, 0x65, 0x20
	DB	0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_7:
	DB	0x41, 0x6c, 0x74, 0x65, 0x72, 0x61, 0x72, 0x20, 0x69, 0x64, 0x69, 0x6f
	DB	0x6d, 0x61, 0x20, 0x00
; ; Starting pCode block
___str_8:
	DB	0x43, 0x68, 0x61, 0x6e, 0x67, 0x65, 0x20, 0x6c, 0x61, 0x6e, 0x67, 0x75
	DB	0x61, 0x67, 0x65, 0x00


; Statistics:
; code size:	  796 (0x031c) bytes ( 0.61%)
;           	  398 (0x018e) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    8 (0x0008) bytes


	end

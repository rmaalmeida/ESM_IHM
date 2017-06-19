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
	global	_ssdDigit
	global	_ssdUpdate
	global	_ssdInit

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
TBLPTRL	equ	0xff6
TBLPTRH	equ	0xff7
TBLPTRU	equ	0xff8
TABLAT	equ	0xff5
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

udata_ssd_0	udata
_display	res	1

udata_ssd_1	udata
_v0	res	1

udata_ssd_2	udata
_v1	res	1

udata_ssd_3	udata
_v2	res	1

udata_ssd_4	udata
_v3	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_ssd__ssdInit	code
_ssdInit:
;	.line	85; ssd.c	void ssdInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	87; ssd.c	BitClr(TRISA, 2);
	LFSR	0x00, 0xf92
	MOVFF	INDF0, r0x00
	BCF	r0x00, 2
	LFSR	0x00, 0xf92
	MOVFF	r0x00, INDF0
;	.line	88; ssd.c	BitClr(TRISA, 5);
	LFSR	0x00, 0xf92
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf92
	MOVFF	r0x00, INDF0
;	.line	89; ssd.c	BitClr(TRISE, 0);
	LFSR	0x00, 0xf96
	MOVFF	INDF0, r0x00
	BCF	r0x00, 0
	LFSR	0x00, 0xf96
	MOVFF	r0x00, INDF0
;	.line	90; ssd.c	BitClr(TRISE, 2);
	LFSR	0x00, 0xf96
	MOVFF	INDF0, r0x00
	BCF	r0x00, 2
	LFSR	0x00, 0xf96
	MOVFF	r0x00, INDF0
;	.line	91; ssd.c	ADCON1 = 0x0E; //apenas AN0 é analogico, a referencia é baseada na fonte
	LFSR	0x00, 0xfc1
	MOVLW	0x0e
	MOVWF	INDF0
;	.line	92; ssd.c	TRISD = 0x00; //Porta de dados
	LFSR	0x00, 0xf95
	MOVLW	0x00
	MOVWF	INDF0
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ssd__ssdUpdate	code
_ssdUpdate:
;	.line	47; ssd.c	void ssdUpdate(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	49; ssd.c	PORTA = 0x00;
	LFSR	0x00, 0xf80
	MOVLW	0x00
	MOVWF	INDF0
;	.line	50; ssd.c	PORTE = 0x00;
	LFSR	0x00, 0xf84
	MOVLW	0x00
	MOVWF	INDF0
;	.line	52; ssd.c	PORTD = 0x00;
	LFSR	0x00, 0xf83
	MOVLW	0x00
	MOVWF	INDF0
;	.line	54; ssd.c	switch (display){ //liga apenas o display da vez
	MOVLW	0x04
	BANKSEL	_display
	SUBWF	_display, W, B
	BTFSC	STATUS, 0
	BRA	_00141_DS_
	CLRF	PCLATH
	CLRF	PCLATU
	BANKSEL	_display
	RLCF	_display, W, B
	RLCF	PCLATH, F
	RLCF	WREG, W
	RLCF	PCLATH, F
	ANDLW	0xfc
	ADDLW	LOW(_00149_DS_)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_00149_DS_)
	ADDWFC	PCLATH, F
	MOVLW	UPPER(_00149_DS_)
	ADDWFC	PCLATU, F
	MOVF	PREINC1, W
	MOVWF	PCL
_00149_DS_:
	GOTO	_00137_DS_
	GOTO	_00138_DS_
	GOTO	_00139_DS_
	GOTO	_00140_DS_
_00137_DS_:
;	.line	56; ssd.c	PORTD = valor[v0];
	MOVLW	LOW(_valor)
	BANKSEL	_v0
	ADDWF	_v0, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_valor)
	ADDWFC	r0x01, F
	CLRF	r0x02
	MOVLW	UPPER(_valor)
	ADDWFC	r0x02, F
	MOVFF	r0x00, TBLPTRL
	MOVFF	r0x01, TBLPTRH
	MOVFF	r0x02, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x00
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	57; ssd.c	BitSet(PORTA, 5);
	LFSR	0x00, 0xf80
	MOVFF	INDF0, r0x00
	BSF	r0x00, 5
	LFSR	0x00, 0xf80
	MOVFF	r0x00, INDF0
;	.line	58; ssd.c	display = 1;
	MOVLW	0x01
	BANKSEL	_display
	MOVWF	_display, B
;	.line	59; ssd.c	break;
	BRA	_00143_DS_
_00138_DS_:
;	.line	62; ssd.c	PORTD = valor[v1];
	MOVLW	LOW(_valor)
	BANKSEL	_v1
	ADDWF	_v1, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_valor)
	ADDWFC	r0x01, F
	CLRF	r0x02
	MOVLW	UPPER(_valor)
	ADDWFC	r0x02, F
	MOVFF	r0x00, TBLPTRL
	MOVFF	r0x01, TBLPTRH
	MOVFF	r0x02, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x00
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	63; ssd.c	BitSet(PORTA, 2);
	LFSR	0x00, 0xf80
	MOVFF	INDF0, r0x00
	BSF	r0x00, 2
	LFSR	0x00, 0xf80
	MOVFF	r0x00, INDF0
;	.line	64; ssd.c	display = 2;
	MOVLW	0x02
	BANKSEL	_display
	MOVWF	_display, B
;	.line	65; ssd.c	break;
	BRA	_00143_DS_
_00139_DS_:
;	.line	68; ssd.c	PORTD = valor[v2];
	MOVLW	LOW(_valor)
	BANKSEL	_v2
	ADDWF	_v2, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_valor)
	ADDWFC	r0x01, F
	CLRF	r0x02
	MOVLW	UPPER(_valor)
	ADDWFC	r0x02, F
	MOVFF	r0x00, TBLPTRL
	MOVFF	r0x01, TBLPTRH
	MOVFF	r0x02, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x00
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	69; ssd.c	BitSet(PORTE, 0);
	LFSR	0x00, 0xf84
	MOVFF	INDF0, r0x00
	BSF	r0x00, 0
	LFSR	0x00, 0xf84
	MOVFF	r0x00, INDF0
;	.line	70; ssd.c	display = 3;
	MOVLW	0x03
	BANKSEL	_display
	MOVWF	_display, B
;	.line	71; ssd.c	break;
	BRA	_00143_DS_
_00140_DS_:
;	.line	74; ssd.c	PORTD = valor[v3];
	MOVLW	LOW(_valor)
	BANKSEL	_v3
	ADDWF	_v3, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_valor)
	ADDWFC	r0x01, F
	CLRF	r0x02
	MOVLW	UPPER(_valor)
	ADDWFC	r0x02, F
	MOVFF	r0x00, TBLPTRL
	MOVFF	r0x01, TBLPTRH
	MOVFF	r0x02, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x00
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	75; ssd.c	BitSet(PORTE, 2);
	LFSR	0x00, 0xf84
	MOVFF	INDF0, r0x00
	BSF	r0x00, 2
	LFSR	0x00, 0xf84
	MOVFF	r0x00, INDF0
	BANKSEL	_display
;	.line	76; ssd.c	display = 0;
	CLRF	_display, B
;	.line	77; ssd.c	break;
	BRA	_00143_DS_
_00141_DS_:
	BANKSEL	_display
;	.line	80; ssd.c	display = 0;
	CLRF	_display, B
_00143_DS_:
;	.line	82; ssd.c	}
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ssd__ssdDigit	code
_ssdDigit:
;	.line	31; ssd.c	void ssdDigit(char val, char pos) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	32; ssd.c	if (pos == 0) {
	MOVF	r0x01, W
	BNZ	_00106_DS_
;	.line	33; ssd.c	v0 = val;
	MOVFF	r0x00, _v0
_00106_DS_:
;	.line	35; ssd.c	if (pos == 1) {
	MOVF	r0x01, W
	XORLW	0x01
	BNZ	_00108_DS_
;	.line	36; ssd.c	v1 = val;
	MOVFF	r0x00, _v1
_00108_DS_:
;	.line	38; ssd.c	if (pos == 2) {
	MOVF	r0x01, W
	XORLW	0x02
	BNZ	_00110_DS_
;	.line	39; ssd.c	v2 = val;
	MOVFF	r0x00, _v2
_00110_DS_:
;	.line	41; ssd.c	if (pos == 3) {
	MOVF	r0x01, W
	XORLW	0x03
	BNZ	_00113_DS_
;	.line	42; ssd.c	v3 = val;
	MOVFF	r0x00, _v3
_00113_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block for Ival
	code
_valor:
	DB	0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x6f, 0x77, 0x7c
	DB	0x39, 0x5e, 0x79, 0x71


; Statistics:
; code size:	  606 (0x025e) bytes ( 0.46%)
;           	  303 (0x012f) words
; udata size:	    5 (0x0005) bytes ( 0.39%)
; access size:	    3 (0x0003) bytes


	end

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
	global	_kpRead
	global	_kpDebounce
	global	_kpInit

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


	idata
_valor	db	0x00
_kpDebounce_valorNovo_1_7	db	0x00
_kpDebounce_valorAntigo_1_7	db	0x00


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
r0x08	res	1
r0x09	res	1

udata_keypad_0	udata
_kpDebounce_tempo_1_7	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_keypad__kpInit	code
_kpInit:
;	.line	59; keypad.c	void kpInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	60; keypad.c	TRISB = 0xF0; //quatro entradas e quatro saidas
	LFSR	0x00, 0xf93
	MOVLW	0xf0
	MOVWF	INDF0
;	.line	61; keypad.c	BitClr(INTCON2, 7); //liga pull up
	LFSR	0x00, 0xff1
	MOVFF	INDF0, r0x00
	BCF	r0x00, 7
	LFSR	0x00, 0xff1
	MOVFF	r0x00, INDF0
;	.line	62; keypad.c	ADCON1 = 0b00001110; //apenas AN0 é analogico, a referencia é baseada na fonte
	LFSR	0x00, 0xfc1
	MOVLW	0x0e
	MOVWF	INDF0
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_keypad__kpDebounce	code
_kpDebounce:
;	.line	29; keypad.c	void kpDebounce(void) {
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
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
;	.line	35; keypad.c	for (i = 0; i < 4; i++) {
	CLRF	r0x00
	CLRF	r0x01
	CLRF	r0x02
_00122_DS_:
;	.line	36; keypad.c	TRISB = ~((unsigned char)1<<i);
	MOVLW	0x01
	MOVWF	r0x03
	MOVF	r0x00, W
	BZ	_00149_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00150_DS_:
	RLCF	r0x03, F
	ADDLW	0x01
	BNC	_00150_DS_
_00149_DS_:
	COMF	r0x03, F
	LFSR	0x00, 0xf93
	MOVFF	r0x03, INDF0
;	.line	37; keypad.c	PORTB = ~((unsigned char)1<<i);
	LFSR	0x00, 0xf81
	MOVFF	r0x03, INDF0
;	.line	40; keypad.c	for (j = 0; j < 2; j++) {
	CLRF	r0x03
_00120_DS_:
;	.line	41; keypad.c	if (!BitTst(PORTB, j + 4)) {
	LFSR	0x00, 0xf81
	MOVFF	INDF0, r0x04
	MOVFF	r0x03, r0x05
	CLRF	r0x06
	MOVLW	0x04
	ADDWF	r0x05, F
	BTFSC	STATUS, 0
	INCF	r0x06, F
	MOVLW	0x01
	MOVWF	r0x07
	MOVLW	0x00
	MOVWF	r0x08
	MOVF	r0x05, W
	BZ	_00151_DS_
	BN	_00154_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00152_DS_:
	RLCF	r0x07, F
	RLCF	r0x08, F
	ADDLW	0x01
	BNC	_00152_DS_
	BRA	_00151_DS_
_00154_DS_:
	BCF	STATUS, 0
_00153_DS_:
	BTFSC	r0x08, 7
	BSF	STATUS, 0
	RRCF	r0x08, F
	RRCF	r0x07, F
	ADDLW	0x01
	BNC	_00153_DS_
_00151_DS_:
	CLRF	r0x09
	MOVF	r0x04, W
	ANDWF	r0x07, F
	MOVF	r0x09, W
	ANDWF	r0x08, F
	MOVF	r0x07, W
	IORWF	r0x08, W
	BNZ	_00111_DS_
;	.line	42; keypad.c	BitSet(valorNovo, (i * 2) + j);
	MOVF	r0x03, W
	ADDWF	r0x02, W
	MOVWF	r0x04
	MOVLW	0x01
	MOVWF	r0x05
	MOVF	r0x04, W
	BZ	_00155_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00156_DS_:
	RLCF	r0x05, F
	ADDLW	0x01
	BNC	_00156_DS_
_00155_DS_:
	MOVF	r0x05, W
	BANKSEL	_kpDebounce_valorNovo_1_7
	IORWF	_kpDebounce_valorNovo_1_7, F, B
	BRA	_00121_DS_
_00111_DS_:
;	.line	44; keypad.c	BitClr(valorNovo, (i * 2) + j);
	MOVF	r0x03, W
	ADDWF	r0x01, W
	MOVWF	r0x04
	MOVLW	0x01
	MOVWF	r0x05
	MOVF	r0x04, W
	BZ	_00158_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00159_DS_:
	RLCF	r0x05, F
	ADDLW	0x01
	BNC	_00159_DS_
_00158_DS_:
	COMF	r0x05, W
	MOVWF	r0x04
	MOVF	r0x04, W
	BANKSEL	_kpDebounce_valorNovo_1_7
	ANDWF	_kpDebounce_valorNovo_1_7, F, B
_00121_DS_:
;	.line	40; keypad.c	for (j = 0; j < 2; j++) {
	INCF	r0x03, F
	MOVLW	0x02
	SUBWF	r0x03, W
	BTFSS	STATUS, 0
	BRA	_00120_DS_
;	.line	35; keypad.c	for (i = 0; i < 4; i++) {
	INCF	r0x01, F
	INCF	r0x01, F
	INCF	r0x02, F
	INCF	r0x02, F
	INCF	r0x00, F
	MOVLW	0x04
	SUBWF	r0x00, W
	BTFSS	STATUS, 0
	BRA	_00122_DS_
	BANKSEL	_kpDebounce_valorAntigo_1_7
;	.line	48; keypad.c	if (valorAntigo == valorNovo) {
	MOVF	_kpDebounce_valorAntigo_1_7, W, B
	BANKSEL	_kpDebounce_valorNovo_1_7
	XORWF	_kpDebounce_valorNovo_1_7, W, B
	BNZ	_00116_DS_
_00164_DS_:
	BANKSEL	_kpDebounce_tempo_1_7
;	.line	49; keypad.c	tempo--;
	DECF	_kpDebounce_tempo_1_7, F, B
	BRA	_00117_DS_
_00116_DS_:
;	.line	51; keypad.c	tempo = 10;
	MOVLW	0x0a
	BANKSEL	_kpDebounce_tempo_1_7
	MOVWF	_kpDebounce_tempo_1_7, B
;	.line	52; keypad.c	valorAntigo = valorNovo;
	MOVFF	_kpDebounce_valorNovo_1_7, _kpDebounce_valorAntigo_1_7
_00117_DS_:
	BANKSEL	_kpDebounce_tempo_1_7
;	.line	54; keypad.c	if (tempo == 0) {
	MOVF	_kpDebounce_tempo_1_7, W, B
	BNZ	_00124_DS_
;	.line	55; keypad.c	valor = valorAntigo;
	MOVFF	_kpDebounce_valorAntigo_1_7, _valor
_00124_DS_:
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
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
S_keypad__kpRead	code
_kpRead:
;	.line	25; keypad.c	unsigned char kpRead(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_valor
;	.line	26; keypad.c	return valor;
	MOVF	_valor, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  422 (0x01a6) bytes ( 0.32%)
;           	  211 (0x00d3) words
; udata size:	    1 (0x0001) bytes ( 0.08%)
; access size:	   10 (0x000a) bytes


	end

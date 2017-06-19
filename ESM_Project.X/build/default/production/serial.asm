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
	global	_serialSend
	global	_serialRead
	global	_serialInit

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
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

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_serial__serialInit	code
_serialInit:
;	.line	41; serial.c	void serialInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	42; serial.c	TXSTA = 0b00101100; //configura a transmissão de dados da serial
	LFSR	0x00, 0xfac
	MOVLW	0x2c
	MOVWF	INDF0
;	.line	43; serial.c	RCSTA = 0b10010000; //configura a recepção de dados da serial
	LFSR	0x00, 0xfab
	MOVLW	0x90
	MOVWF	INDF0
;	.line	44; serial.c	BAUDCON = 0b00001000; //configura sistema de velocidade da serial
	LFSR	0x00, 0xfb8
	MOVLW	0x08
	MOVWF	INDF0
;	.line	45; serial.c	SPBRGH = 0; //configura para 57.6k
	LFSR	0x00, 0xfb0
	MOVLW	0x00
	MOVWF	INDF0
;	.line	46; serial.c	SPBRG = 34; //configura para 57.6k
	LFSR	0x00, 0xfaf
	MOVLW	0x22
	MOVWF	INDF0
;	.line	47; serial.c	BitSet(TRISC, 6); //pino de recepção de dados
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BSF	r0x00, 6
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
;	.line	48; serial.c	BitSet(TRISC, 7); //pino de envio de dados
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BSF	r0x00, 7
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serialRead	code
_serialRead:
;	.line	28; serial.c	unsigned char serialRead(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	29; serial.c	unsigned char resp = 0;
	CLRF	r0x00
;	.line	31; serial.c	if (BitTst(RCSTA, 1)) { //Verifica se há erro de overrun e reseta a serial
	LFSR	0x00, 0xfab
	MOVFF	INDF0, r0x01
	BTFSS	r0x01, 1
	BRA	_00122_DS_
;	.line	32; serial.c	BitClr(RCSTA, 4);
	LFSR	0x00, 0xfab
	MOVFF	INDF0, r0x01
	BCF	r0x01, 4
	LFSR	0x00, 0xfab
	MOVFF	r0x01, INDF0
;	.line	33; serial.c	BitSet(RCSTA, 4);
	LFSR	0x00, 0xfab
	MOVFF	INDF0, r0x01
	BSF	r0x01, 4
	LFSR	0x00, 0xfab
	MOVFF	r0x01, INDF0
_00122_DS_:
;	.line	35; serial.c	if (BitTst(PIR1, 5)) { //Verifica se existe algum valor disponivel
	LFSR	0x00, 0xf9e
	MOVFF	INDF0, r0x01
	BTFSS	r0x01, 5
	BRA	_00124_DS_
;	.line	36; serial.c	resp = RCREG; //retorna o valor
	LFSR	0x00, 0xfae
	MOVFF	INDF0, r0x00
_00124_DS_:
;	.line	38; serial.c	return resp; //retorna zero
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serialSend	code
_serialSend:
;	.line	23; serial.c	void serialSend(unsigned char c) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
_00105_DS_:
;	.line	24; serial.c	while (!BitTst(PIR1, 4)); //aguarda o registro ficar disponível
	LFSR	0x00, 0xf9e
	MOVFF	INDF0, r0x01
	BTFSS	r0x01, 4
	BRA	_00105_DS_
;	.line	25; serial.c	TXREG = c; //coloca o valor para ser enviado
	LFSR	0x00, 0xfad
	MOVFF	r0x00, INDF0
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  256 (0x0100) bytes ( 0.20%)
;           	  128 (0x0080) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    2 (0x0002) bytes


	end

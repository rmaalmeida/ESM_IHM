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
	global	_lcdCommand
	global	_lcdData
	global	_lcdInt
	global	_lcdString
	global	_lcdInit
	global	_Delay40us
	global	_Delay2ms

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	__gptrget1
	extern	__divsint
	extern	__modsint

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR0L	equ	0xfe9
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
S_lcd__lcdInit	code
_lcdInit:
;	.line	92; lcd.c	void lcdInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	96; lcd.c	Delay2ms();
	CALL	_Delay2ms
;	.line	97; lcd.c	Delay2ms();
	CALL	_Delay2ms
;	.line	98; lcd.c	Delay2ms();
	CALL	_Delay2ms
;	.line	99; lcd.c	Delay2ms();
	CALL	_Delay2ms
;	.line	100; lcd.c	Delay2ms();
	CALL	_Delay2ms
;	.line	101; lcd.c	Delay2ms();
	CALL	_Delay2ms
;	.line	104; lcd.c	BitClr(TRISE, RS); //RS
	LFSR	0x00, 0xf96
	MOVFF	INDF0, r0x00
	BCF	r0x00, 0
	LFSR	0x00, 0xf96
	MOVFF	r0x00, INDF0
;	.line	105; lcd.c	BitClr(TRISE, EN); //EN
	LFSR	0x00, 0xf96
	MOVFF	INDF0, r0x00
	BCF	r0x00, 1
	LFSR	0x00, 0xf96
	MOVFF	r0x00, INDF0
;	.line	106; lcd.c	BitClr(TRISE, RW); //RW
	LFSR	0x00, 0xf96
	MOVFF	INDF0, r0x00
	BCF	r0x00, 2
	LFSR	0x00, 0xf96
	MOVFF	r0x00, INDF0
;	.line	107; lcd.c	TRISD = 0x00; //dados
	LFSR	0x00, 0xf95
	MOVLW	0x00
	MOVWF	INDF0
;	.line	108; lcd.c	ADCON1 = 0b00001110; //apenas
	LFSR	0x00, 0xfc1
	MOVLW	0x0e
	MOVWF	INDF0
;	.line	111; lcd.c	lcdCommand(0x38); //0b0011 1000 8bits, 2 linhas, 5x8
	MOVLW	0x38
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	112; lcd.c	lcdCommand(0x0F); //0b0000 1111 display e cursor on, com blink
	MOVLW	0x0f
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	113; lcd.c	lcdCommand(0x06); //0b0000 0110 modo incremental
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	114; lcd.c	lcdCommand(0x03); //0b0000 0011 zera variáveis internas
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	115; lcd.c	lcdCommand(0x01); //0b0000 0001 Limpa a tela
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_lcd__lcdString	code
_lcdString:
;	.line	84; lcd.c	void lcdString(char msg[]) {
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
;	.line	86; lcd.c	while (msg[i]!=0) {
	CLRF	r0x03
	CLRF	r0x04
_00152_DS_:
	MOVF	r0x03, W
	ADDWF	r0x00, W
	MOVWF	r0x05
	MOVF	r0x04, W
	ADDWFC	r0x01, W
	MOVWF	r0x06
	CLRF	WREG
	BTFSC	r0x04, 7
	SETF	WREG
	ADDWFC	r0x02, W
	MOVWF	r0x07
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, PRODL
	MOVF	r0x07, W
	CALL	__gptrget1
	MOVWF	r0x05
	MOVF	r0x05, W
	BZ	_00155_DS_
;	.line	87; lcd.c	lcdData(msg[i]);
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	88; lcd.c	i++;
	INFSNZ	r0x03, F
	INCF	r0x04, F
	BRA	_00152_DS_
_00155_DS_:
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
S_lcd__lcdInt	code
_lcdInt:
;	.line	71; lcd.c	void lcdInt(int val) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	72; lcd.c	if (val < 0) {
	BSF	STATUS, 0
	BTFSS	r0x01, 7
	BCF	STATUS, 0
	BNC	_00146_DS_
;	.line	73; lcd.c	val = val * (-1);
	COMF	r0x01, F
	NEGF	r0x00
	BTFSC	STATUS, 2
	INCF	r0x01, F
;	.line	74; lcd.c	lcdData('-');
	MOVLW	0x2d
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
_00146_DS_:
;	.line	76; lcd.c	lcdData((val / 10000) % 10 + 48);
	MOVLW	0x27
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x30
	ADDWF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	77; lcd.c	lcdData((val / 1000) % 10 + 48);
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x30
	ADDWF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	78; lcd.c	lcdData((val / 100) % 10 + 48);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x30
	ADDWF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	79; lcd.c	lcdData((val / 10) % 10 + 48);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x30
	ADDWF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	80; lcd.c	lcdData((val / 1) % 10 + 48);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x30
	ADDWF	r0x00, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_lcd__lcdData	code
_lcdData:
;	.line	56; lcd.c	void lcdData(unsigned char valor) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	57; lcd.c	BitSet(PORTE, RS); //dados
	LFSR	0x00, 0xf84
	MOVFF	INDF0, r0x01
	BSF	r0x01, 0
	LFSR	0x00, 0xf84
	MOVFF	r0x01, INDF0
;	.line	58; lcd.c	BitClr(PORTE, RW); // habilita escrita
	LFSR	0x00, 0xf84
	MOVFF	INDF0, r0x01
	BCF	r0x01, 2
	LFSR	0x00, 0xf84
	MOVFF	r0x01, INDF0
;	.line	60; lcd.c	PORTD = valor;
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	62; lcd.c	BitSet(PORTE, EN); //Pulso no Enable
	LFSR	0x00, 0xf84
	MOVFF	INDF0, r0x00
	BSF	r0x00, 1
	LFSR	0x00, 0xf84
	MOVFF	r0x00, INDF0
;	.line	63; lcd.c	BitClr(PORTE, EN);
	LFSR	0x00, 0xf84
	MOVFF	INDF0, r0x00
	BCF	r0x00, 1
	LFSR	0x00, 0xf84
	MOVFF	r0x00, INDF0
;	.line	65; lcd.c	BitClr(PORTE, RS); //deixa em nivel baixo por causa do display de 7 seg
	LFSR	0x00, 0xf84
	MOVFF	INDF0, r0x00
	BCF	r0x00, 0
	LFSR	0x00, 0xf84
	MOVFF	r0x00, INDF0
;	.line	66; lcd.c	Delay40us();
	CALL	_Delay40us
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_lcd__lcdCommand	code
_lcdCommand:
;	.line	40; lcd.c	void lcdCommand(unsigned char cmd) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	41; lcd.c	BitClr(PORTE, RS); //comando
	LFSR	0x00, 0xf84
	MOVFF	INDF0, r0x01
	BCF	r0x01, 0
	LFSR	0x00, 0xf84
	MOVFF	r0x01, INDF0
;	.line	42; lcd.c	BitClr(PORTE, RW); // habilita escrita
	LFSR	0x00, 0xf84
	MOVFF	INDF0, r0x01
	BCF	r0x01, 2
	LFSR	0x00, 0xf84
	MOVFF	r0x01, INDF0
;	.line	44; lcd.c	PORTD = cmd;
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	46; lcd.c	BitSet(PORTE, EN); //Pulso no Enable
	LFSR	0x00, 0xf84
	MOVFF	INDF0, r0x01
	BSF	r0x01, 1
	LFSR	0x00, 0xf84
	MOVFF	r0x01, INDF0
;	.line	47; lcd.c	BitClr(PORTE, EN);
	LFSR	0x00, 0xf84
	MOVFF	INDF0, r0x01
	BCF	r0x01, 1
	LFSR	0x00, 0xf84
	MOVFF	r0x01, INDF0
;	.line	49; lcd.c	if (BitTst(cmd, 1)) { //o comando de reset exige mais tempo
	BTFSS	r0x00, 1
	BRA	_00124_DS_
;	.line	50; lcd.c	Delay2ms();
	CALL	_Delay2ms
	BRA	_00126_DS_
_00124_DS_:
;	.line	52; lcd.c	Delay40us();
	CALL	_Delay40us
_00126_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_lcd__Delay2ms	code
_Delay2ms:
;	.line	33; lcd.c	void Delay2ms(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	35; lcd.c	for (i = 0; i < 50; i++) {
	MOVLW	0x32
	MOVWF	r0x00
_00117_DS_:
;	.line	36; lcd.c	Delay40us();
	CALL	_Delay40us
	DECF	r0x00, W
	MOVWF	r0x01
	MOVFF	r0x01, r0x00
;	.line	35; lcd.c	for (i = 0; i < 50; i++) {
	MOVF	r0x01, W
	BNZ	_00117_DS_
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_lcd__Delay40us	code
_Delay40us:
;	.line	28; lcd.c	void Delay40us(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	30; lcd.c	for (i = 0; i < 10; i++); //valor aproximado
	MOVLW	0x0a
	MOVWF	r0x00
_00108_DS_:
	DECF	r0x00, W
	MOVWF	r0x01
	MOVFF	r0x01, r0x00
	MOVF	r0x01, W
	BNZ	_00108_DS_
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 1112 (0x0458) bytes ( 0.85%)
;           	  556 (0x022c) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    8 (0x0008) bytes


	end

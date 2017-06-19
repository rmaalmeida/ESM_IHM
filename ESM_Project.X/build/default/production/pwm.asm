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
	global	_pwmSet1
	global	_pwmSet2
	global	_pwmFrequency
	global	_pwmInit

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	__mulint
	extern	__divuint
	extern	__divslong

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
FSR0L	equ	0xfe9
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


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
S_pwm__pwmInit	code
_pwmInit:
;	.line	56; pwm.c	void pwmInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	57; pwm.c	BitClr(TRISC, 1); //configura os pinos correspondentes como saídas
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BCF	r0x00, 1
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
;	.line	58; pwm.c	BitClr(TRISC, 2);
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BCF	r0x00, 2
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
;	.line	60; pwm.c	T2CON |= 0b00000011; //configura o prescale do timer 2 para 1:16
	LFSR	0x00, 0xfca
	MOVFF	INDF0, r0x00
	MOVLW	0x03
	IORWF	r0x00, F
	LFSR	0x00, 0xfca
	MOVFF	r0x00, INDF0
;	.line	61; pwm.c	BitSet(T2CON, 2); //Liga o timer 2
	LFSR	0x00, 0xfca
	MOVFF	INDF0, r0x00
	BSF	r0x00, 2
	LFSR	0x00, 0xfca
	MOVFF	r0x00, INDF0
;	.line	64; pwm.c	CCP1CON |= 0b00001100; //configura CCP1 como um PWM
	LFSR	0x00, 0xfbd
	MOVFF	INDF0, r0x00
	MOVLW	0x0c
	IORWF	r0x00, F
	LFSR	0x00, 0xfbd
	MOVFF	r0x00, INDF0
;	.line	65; pwm.c	CCP2CON |= 0b00001100; //configura CCP2 como um PWM
	LFSR	0x00, 0xfba
	MOVFF	INDF0, r0x00
	MOVLW	0x0c
	IORWF	r0x00, F
	LFSR	0x00, 0xfba
	MOVFF	r0x00, INDF0
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_pwm__pwmFrequency	code
_pwmFrequency:
;	.line	50; pwm.c	void pwmFrequency(unsigned int freq) {
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
;	.line	53; pwm.c	PR2 = (125000 / (freq)) - 1;
	CLRF	r0x02
	CLRF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	MOVLW	0x48
	MOVWF	POSTDEC1
	CALL	__divslong
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVLW	0x08
	ADDWF	FSR1L, F
	DECF	r0x00, F
	LFSR	0x00, 0xfcb
	MOVFF	r0x00, INDF0
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_pwm__pwmSet2	code
_pwmSet2:
;	.line	39; pwm.c	void pwmSet2(unsigned char porcento) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	40; pwm.c	unsigned int val = ((unsigned int) porcento) *(PR2 + 1);
	CLRF	r0x01
	LFSR	0x00, 0xfcb
	MOVFF	INDF0, r0x02
	CLRF	r0x03
	INFSNZ	r0x02, F
	INCF	r0x03, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	41; pwm.c	val /= 25;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x19
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divuint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	43; pwm.c	val &= 0x03ff;
	MOVLW	0x03
	ANDWF	r0x01, F
;	.line	45; pwm.c	CCPR2L = val >> 2;
	BCF	STATUS, 0
	RRCF	r0x01, W
	MOVWF	r0x03
	RRCF	r0x00, W
	MOVWF	r0x02
	BCF	STATUS, 0
	RRCF	r0x03, F
	RRCF	r0x02, F
	LFSR	0x00, 0xfbb
	MOVFF	r0x02, INDF0
;	.line	47; pwm.c	CCP2CON |= (val & 0x0003) << 4;
	LFSR	0x00, 0xfba
	MOVFF	INDF0, r0x02
	MOVLW	0x03
	ANDWF	r0x00, F
	CLRF	r0x01
	SWAPF	r0x00, W
	ANDLW	0xf0
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x02, F
	LFSR	0x00, 0xfba
	MOVFF	r0x02, INDF0
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_pwm__pwmSet1	code
_pwmSet1:
;	.line	23; pwm.c	void pwmSet1(unsigned char porcento) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	29; pwm.c	unsigned int val = ((unsigned int) porcento) *(PR2 + 1);
	CLRF	r0x01
	LFSR	0x00, 0xfcb
	MOVFF	INDF0, r0x02
	CLRF	r0x03
	INFSNZ	r0x02, F
	INCF	r0x03, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	30; pwm.c	val = val / 25;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x19
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divuint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	32; pwm.c	val &= 0x03ff;
	MOVLW	0x03
	ANDWF	r0x01, F
;	.line	34; pwm.c	CCPR1L = val >> 2;
	BCF	STATUS, 0
	RRCF	r0x01, W
	MOVWF	r0x03
	RRCF	r0x00, W
	MOVWF	r0x02
	BCF	STATUS, 0
	RRCF	r0x03, F
	RRCF	r0x02, F
	LFSR	0x00, 0xfbe
	MOVFF	r0x02, INDF0
;	.line	36; pwm.c	CCP1CON |= (val & 0x0003) << 4;
	LFSR	0x00, 0xfbd
	MOVFF	INDF0, r0x02
	MOVLW	0x03
	ANDWF	r0x00, F
	CLRF	r0x01
	SWAPF	r0x00, W
	ANDLW	0xf0
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x02, F
	LFSR	0x00, 0xfbd
	MOVFF	r0x02, INDF0
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  638 (0x027e) bytes ( 0.49%)
;           	  319 (0x013f) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    4 (0x0004) bytes


	end

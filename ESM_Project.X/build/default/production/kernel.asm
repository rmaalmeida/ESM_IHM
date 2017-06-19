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
	global	_kernelInit
	global	_kernelAddProc
	global	_kernelLoop
	global	_ini
	global	_fim
	global	_pool

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	__gptrget3
	extern	__modsint
	extern	__mulint

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
INTCON	equ	0xff2
WREG	equ	0xfe8
TOSL	equ	0xffd
TOSH	equ	0xffe
TOSU	equ	0xfff
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTINC0	equ	0xfee
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
r0x04	res	1

udata_kernel_0	udata
_ini	res	2

udata_kernel_1	udata
_fim	res	2

udata_kernel_2	udata
_pool	res	30

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_kernel__kernelLoop	code
_kernelLoop:
;	.line	42; kernel.c	void kernelLoop(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
_00128_DS_:
	BANKSEL	_ini
;	.line	45; kernel.c	if (ini != fim){
	MOVF	_ini, W, B
	BANKSEL	_fim
	XORWF	_fim, W, B
	BNZ	_00142_DS_
	BANKSEL	(_ini + 1)
	MOVF	(_ini + 1), W, B
	BANKSEL	(_fim + 1)
	XORWF	(_fim + 1), W, B
	BZ	_00128_DS_
_00142_DS_:
	BANKSEL	(_ini + 1)
;	.line	47; kernel.c	if (pool[ini]->function() == REPEAT){
	MOVF	(_ini + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_ini
	MOVF	_ini, W, B
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_pool)
	ADDWF	r0x00, F
	MOVLW	HIGH(_pool)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	POSTINC0, r0x00
	MOVFF	POSTINC0, r0x01
	MOVFF	INDF0, r0x02
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget3
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_00143_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_00143_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_00143_DS_)
	MOVWF	TOSU
	BTFSC	PREINC1, 7
	BSF	INTCON, 7
	MOVFF	r0x02, PCLATU
	MOVFF	r0x01, PCLATH
	MOVF	r0x00, W
	MOVWF	PCL
_00143_DS_:
	MOVWF	r0x00
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00124_DS_
_00145_DS_:
	BANKSEL	(_ini + 1)
;	.line	48; kernel.c	kernelAddProc(pool[ini]);
	MOVF	(_ini + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_ini
	MOVF	_ini, W, B
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_pool)
	ADDWF	r0x00, F
	MOVLW	HIGH(_pool)
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
	CALL	_kernelAddProc
	MOVLW	0x03
	ADDWF	FSR1L, F
_00124_DS_:
	BANKSEL	_ini
;	.line	51; kernel.c	ini = (ini+1)%POOLSIZE;
	MOVF	_ini, W, B
	ADDLW	0x01
	MOVWF	r0x00
	MOVLW	0x00
	BANKSEL	(_ini + 1)
	ADDWFC	(_ini + 1), W, B
	MOVWF	r0x01
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__modsint
	BANKSEL	_ini
	MOVWF	_ini, B
	MOVFF	PRODL, (_ini + 1)
	MOVLW	0x04
	ADDWF	FSR1L, F
	BRA	_00128_DS_
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_kernel__kernelAddProc	code
_kernelAddProc:
;	.line	32; kernel.c	char kernelAddProc(process * newProc){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	BANKSEL	_fim
;	.line	34; kernel.c	if ( ((fim+1)%POOLSIZE) != ini){
	MOVF	_fim, W, B
	ADDLW	0x01
	MOVWF	r0x03
	MOVLW	0x00
	BANKSEL	(_fim + 1)
	ADDWFC	(_fim + 1), W, B
	MOVWF	r0x04
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x03, W
	BANKSEL	_ini
	XORWF	_ini, W, B
	BNZ	_00118_DS_
	MOVF	r0x04, W
	BANKSEL	(_ini + 1)
	XORWF	(_ini + 1), W, B
	BNZ	_00118_DS_
	BRA	_00111_DS_
_00118_DS_:
	BANKSEL	(_fim + 1)
;	.line	35; kernel.c	pool[fim] = newProc;
	MOVF	(_fim + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_fim
	MOVF	_fim, W, B
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_pool)
	ADDWF	r0x03, F
	MOVLW	HIGH(_pool)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	r0x00, POSTINC0
	MOVFF	r0x01, POSTINC0
	MOVFF	r0x02, INDF0
	BANKSEL	_fim
;	.line	36; kernel.c	fim = (fim+1)%POOLSIZE;
	MOVF	_fim, W, B
	ADDLW	0x01
	MOVWF	r0x00
	MOVLW	0x00
	BANKSEL	(_fim + 1)
	ADDWFC	(_fim + 1), W, B
	MOVWF	r0x01
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__modsint
	BANKSEL	_fim
	MOVWF	_fim, B
	MOVFF	PRODL, (_fim + 1)
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	37; kernel.c	return SUCCESS;
	CLRF	WREG
	BRA	_00112_DS_
_00111_DS_:
;	.line	39; kernel.c	return FAIL;
	MOVLW	0x01
_00112_DS_:
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_kernel__kernelInit	code
_kernelInit:
;	.line	27; kernel.c	char kernelInit(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_ini
;	.line	28; kernel.c	ini = 0;
	CLRF	_ini, B
	BANKSEL	(_ini + 1)
	CLRF	(_ini + 1), B
	BANKSEL	_fim
;	.line	29; kernel.c	fim = 0;
	CLRF	_fim, B
	BANKSEL	(_fim + 1)
	CLRF	(_fim + 1), B
;	.line	30; kernel.c	return SUCCESS;
	CLRF	WREG
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  604 (0x025c) bytes ( 0.46%)
;           	  302 (0x012e) words
; udata size:	   34 (0x0022) bytes ( 2.66%)
; access size:	    5 (0x0005) bytes


	end

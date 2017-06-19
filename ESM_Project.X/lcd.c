// -----------------------------------------------------------------------
//   Copyright (C) Rodrigo Almeida 2010
// -----------------------------------------------------------------------
//   Arquivo: lcd.c
//            Biblioteca de manipulação do LCD
//   Autor:   Rodrigo Maximiano Antunes de Almeida
//            rodrigomax at unifei.edu.br
//   Licença: GNU GPL 2
// -----------------------------------------------------------------------
//   This program is free software; you can redistribute it and/or modify
//   it under the terms of the GNU General Public License as published by
//   the Free Software Foundation; version 2 of the License.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
// -----------------------------------------------------------------------


#include "lcd.h"
#include "pic18f4520.h"

#define RS 0
#define EN 1
#define RW 2

void Delay40us(void) {
    unsigned char i;
    for (i = 0; i < 10; i++); //valor aproximado
}

void Delay2ms(void) {
    unsigned char i;
    for (i = 0; i < 50; i++) {
        Delay40us();
    }
}

void lcdCommand(unsigned char cmd) {
    BitClr(PORTE, RS); //comando
    BitClr(PORTE, RW); // habilita escrita

    PORTD = cmd;

    BitSet(PORTE, EN); //Pulso no Enable
    BitClr(PORTE, EN);

    if (BitTst(cmd, 1)) { //o comando de reset exige mais tempo
        Delay2ms();
    } else {
        Delay40us();
    }
}

void lcdData(unsigned char valor) {
    BitSet(PORTE, RS); //dados
    BitClr(PORTE, RW); // habilita escrita

    PORTD = valor;

    BitSet(PORTE, EN); //Pulso no Enable
    BitClr(PORTE, EN);

    BitClr(PORTE, RS); //deixa em nivel baixo por causa do display de 7 seg
    Delay40us();
}

//int max 5 digitos

void lcdInt(int val) {
    if (val < 0) {
        val = val * (-1);
        lcdData('-');
    }
    lcdData((val / 10000) % 10 + 48);
    lcdData((val / 1000) % 10 + 48);
    lcdData((val / 100) % 10 + 48);
    lcdData((val / 10) % 10 + 48);
    lcdData((val / 1) % 10 + 48);

}

void lcdString(char msg[]) {
    int i=0;
    while (msg[i]!=0) {
        lcdData(msg[i]);
        i++;
    }
}

void lcdInit(void) {
    // Inicializa o LCD

    // garante inicialização do LCD (+-10ms)
    Delay2ms();
    Delay2ms();
    Delay2ms();
    Delay2ms();
    Delay2ms();
    Delay2ms();

    // configurações de direção dos terminais
    BitClr(TRISE, RS); //RS
    BitClr(TRISE, EN); //EN
    BitClr(TRISE, RW); //RW
    TRISD = 0x00; //dados
    ADCON1 = 0b00001110; //apenas

    //configura o display
    lcdCommand(0x38); //0b0011 1000 8bits, 2 linhas, 5x8
    lcdCommand(0x0F); //0b0000 1111 display e cursor on, com blink
    lcdCommand(0x06); //0b0000 0110 modo incremental
    lcdCommand(0x03); //0b0000 0011 zera variáveis internas
    lcdCommand(0x01); //0b0000 0001 Limpa a tela
}

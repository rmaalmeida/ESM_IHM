// -----------------------------------------------------------------------
//   Copyright (C) Rodrigo Almeida 2010
// -----------------------------------------------------------------------
//   Arquivo: serial.c
//            Biblioteca da porta serial (USART) do PIC18F4520
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

#include "serial.h"
#include "pic18f4520.h"

void serialSend(unsigned char c) {
    while (!BitTst(PIR1, 4)); //aguarda o registro ficar disponível
    TXREG = c; //coloca o valor para ser enviado
}

unsigned char serialRead(void) {
    unsigned char resp = 0;

    if (BitTst(RCSTA, 1)) { //Verifica se há erro de overrun e reseta a serial
        BitClr(RCSTA, 4);
        BitSet(RCSTA, 4);
    }
    if (BitTst(PIR1, 5)) { //Verifica se existe algum valor disponivel
        resp = RCREG; //retorna o valor
    }
    return resp; //retorna zero
}

void serialInit(void) {
    TXSTA = 0b00101100; //configura a transmissão de dados da serial
    RCSTA = 0b10010000; //configura a recepção de dados da serial
    BAUDCON = 0b00001000; //configura sistema de velocidade da serial
    SPBRGH = 0; //configura para 57.6k
    SPBRG = 34; //configura para 57.6k
    BitSet(TRISC, 6); //pino de recepção de dados
    BitSet(TRISC, 7); //pino de envio de dados
}
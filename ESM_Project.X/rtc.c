// -----------------------------------------------------------------------
//   Copyright (C) Rodrigo Almeida 2010
// -----------------------------------------------------------------------
//   Arquivo: rtc.c
//            Biblioteca de comunicação com o RTC HT1380 via SPI
//   Autor:   Rodrigo Maximiano Antunes de Almeida
//            rodrigomax at unifei.edu.br
//   Licen�a: GNU GPL 2
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


#include "rtc.h"

char de;

#define DELAY() for(de=0;de<100;de++)

#define RESET_ON()  (BitSet(PORTC,5))
#define RESET_OFF() (BitClr(PORTC,5))
#define RESET_IN()  (BitSet(TRISC,5))
#define RESET_OUT() (BitClr(TRISC,5))


#define SDA_ON()    (BitSet(PORTC,4))
#define SDA_OFF()   (BitClr(PORTC,4))
#define SDA()       (BitTst(PORTC,4))
#define SDA_IN()    (BitSet(TRISC,4))
#define SDA_OUT()   (BitClr(TRISC,4))



#define SCL_ON()    (BitSet(PORTC,3))
#define SCL_OFF()   (BitClr(PORTC,3))
#define SCL_IN()    (BitSet(TRISC,3))
#define SCL_OUT()   (BitClr(TRISC,3))

void rtcInit() {

    RESET_OUT();
    SDA_OUT();
    SCL_OUT();
    //BitClr(INTCON2, 7); //liga pull up
}
void rtcStart() {

   RESET_OUT();
   SDA_OUT();
   SCL_OUT();
   BitClr(INTCON2, 7); //liga pull up
}

void writeByte(unsigned char dados) {
   unsigned char i;
   for (i = 0; i < 8; i++) {
       //Analisa o bit a ser transmitido
       if (dados & 0x01) {
           SDA_ON();
       } else {
           SDA_OFF();
       }
       //pega o pr?ximo bit
       dados >>= 1;
       //gera??o do pulso de clock
       SCL_ON();
       DELAY();
       //informa??o v?lida
       SCL_OFF();
       DELAY();

   }
}

unsigned char readByte() {
   unsigned char i;
   unsigned char dados;
   dados = 0;
   for (i = 0; i < 8; i++) {
       SCL_ON();
       DELAY();
       // informacao valida
       dados >>= 1;

       if (SDA()) {
           dados |= 0x80;
       }
       
       SCL_OFF();
       DELAY();
   }
   return dados;
}

void ht1380write(unsigned char addr, unsigned char dados) {
   RESET_OFF();
   SCL_OFF();
   SDA_OFF();

   //liga o RTC
   RESET_ON();

   addr <<= 1;   //corrige endere?o
   addr |= 0x80; //habilita clock
   writeByte(addr);
   writeByte(dados);
   RESET_OFF();
   SCL_OFF();
   SDA_OFF();
}

unsigned char ht1380read(unsigned char addr) {
   unsigned char dados;
   RESET_OFF();
   SCL_OFF();
   SDA_OFF();

   RESET_ON();
   addr <<= 1;   //corrige endere?o
   addr |= 0x81; //liga bit de leitura e hab. clk
   writeByte(addr);
   SDA_IN();
   DELAY();DELAY();DELAY();DELAY();
   dados = readByte();
   RESET_OFF();
   SCL_OFF();
   SDA_OFF();
   SDA_OUT();
   return dados;
}

void rtcSetDateTime(void) {

   ht1380write(7, 0); //disable write protection
   ht1380write(0, 0x0); //sec
   ht1380write(1, 0x21); //min
   ht1380write(2, 0x23); //hora
   ht1380write(3, 0x28); //dia
   ht1380write(4, 0x10); //mes
   ht1380write(5, 0x6); //dia semana
   ht1380write(6, 0x12); //ano
}

unsigned char rtcGetSeconds(void) {
   unsigned char value;
   value = ht1380read(0); // read seconds
   return (((value >> 4)&0x07)*10 + (value & 0x0f));
   //return value;
}

unsigned char rtcGetMinutes(void) {
   unsigned char value;
   value = ht1380read(1);
   return (((value >> 4)&0x07)*10 + (value & 0x0f));
}

unsigned char rtcGetHours(void) {
   unsigned char value;
   value = ht1380read(2);
   return (((value >> 4)&0x03)*10 + (value & 0x0f));
}

unsigned char rtcGetDate(void) {
   unsigned char value;
   value = ht1380read(3);
   return (((value >> 4)&0x03)*10 + (value & 0x0f));
}

unsigned char rtcGetMonth(void) {
   unsigned char value;
   value = ht1380read(4);
   return (((value >> 4)&0x01)*10 + (value & 0x0f));
}

unsigned char rtcGetYear(void) {
   unsigned char value;
   value = ht1380read(6);
   return (((value >> 4)&0x0f)*10 + (value & 0x0f));
}

unsigned char rtcGetDay(void) {
   unsigned char value;
   value = ht1380read(5);
   return (value & 0x0f); // 1..7
}

//void rtcGetDateTime(void) {
//  seconds=rtcGetSeconds();
//  minutes=rtcGetMinutes();
//  hours=rtcGetHours();
//  day=rtcGetDay();
//  date=rtcGetDate();
//  month=rtcGetMonth();
//  year=rtcGetYear();
//}

void rtcPutSeconds(unsigned char seconds) {
   ht1380write(0, (seconds % 10) | ((seconds / 10) << 4));
}

void rtcPutMinutes(unsigned char minutes) {
   ht1380write(1, (minutes % 10) | ((minutes / 10) << 4));
}

void rtcPutHours(unsigned char hours) {
   ht1380write(2, (hours % 10) | ((hours / 10) << 4));
}

void rtcPutDate(unsigned char date) {
   ht1380write(3, (date % 10) | ((date / 10) << 4));
}

void rtcPutMonth(unsigned char month) {
   ht1380write(4, (month % 10) | ((month / 10) << 4));
}

void rtcPutDay(unsigned char day) {
   ht1380write(5, day);
}

void rtcPutYear(unsigned char year) {
   ht1380write(6, (year % 10) | ((year / 10) << 4));
}
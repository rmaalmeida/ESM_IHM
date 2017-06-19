#include "lcd.h"

void printf(char txt[16]) {
    int i;
    for (i = 0; i < 16; i++) {
        lcdData(txt[i]);
    }
}
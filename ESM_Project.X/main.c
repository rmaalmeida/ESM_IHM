#include "config.h"
#include "pic18f4520.h"
#include "pwm.h"
#include "timer.h"
#include "adc.h"
#include "lcd.h"
#include "ssd.h"
#include "keypad.h"
#include "event.h"
#include "var.h"
#include "stateMachine.h"
#include "output.h"


void main(void) {
     
    //init das bibliotecas
    kpInit();
    lcdInit();
    timerInit();
    varInit();
    eventInit();
    outputInit();
            
                
    for (;;) {
        timerReset(getTime());
        
        //infraestrutura da placa
        
        kpDebounce();
        
        //máquina de estados
        smLoop();
        
        timerWait();

    }
}
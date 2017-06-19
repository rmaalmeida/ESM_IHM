#define BitSet(arg,bit) ((arg) |= (1<<bit))
#define BitClr(arg,bit) ((arg) &= ~(1<<bit)) 
#define BitFlp(arg,bit) ((arg) ^= (1<<bit)) 
#define BitTst(arg,bit) ((arg) & (1<<bit)) 
#define TRISD (*(__near unsigned char *)0xf95) 
#define PORTD (*(__near unsigned char *)0xf83) 


void initLed (void){
    TRISD = 0x00;
    PORTD = 0xFF;
}

void ledON (int x){
    BitSet(PORTD,x);
}


void ledOFF (int x){
    BitClr(PORTD,x);
}

#include "keypad.h"
#include "event.h"
#include "pic18f4520.h"

static unsigned int key_ant;

void eventInit(void) {
    kpInit();
    key_ant = 0;
}

unsigned int eventRead(void) {
    int key;
    int ev = EV_NOEVENT;
    key = kpRead();
    if (key != key_ant) {
        if (BitTst(key, 0)) {
            ev = EV_RIGHT;
        }

        if (BitTst(key, 1)) {
            ev = EV_LEFT;
        }

        if (BitTst(key, 2)) {
            ev = EV_ENTER;
        }
    }

    key_ant = key;
    return ev;
}

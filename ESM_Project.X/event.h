/* 
 * File:   evento.h
 * Author: Avell
 *
 * Created on 14 de Junho de 2017, 16:09
 */

#ifndef EVENT_H
#define	EVENT_H
enum{
    EV_UP,
    EV_DOWN,
    EV_LEFT,
    EV_RIGHT,
    EV_ENTER,
    EV_NOEVENT
};
void eventInit(void);
unsigned int eventRead(void);

#endif	/* EVENT_H */


#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/ESM_Project.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/ESM_Project.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=adc.c keypad.c lcd.c led.c main.c pwm.c rtc.c serial.c ssd.c stdio.c timer.c output.c var.c event.c stateMachine.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/adc.o ${OBJECTDIR}/keypad.o ${OBJECTDIR}/lcd.o ${OBJECTDIR}/led.o ${OBJECTDIR}/main.o ${OBJECTDIR}/pwm.o ${OBJECTDIR}/rtc.o ${OBJECTDIR}/serial.o ${OBJECTDIR}/ssd.o ${OBJECTDIR}/stdio.o ${OBJECTDIR}/timer.o ${OBJECTDIR}/output.o ${OBJECTDIR}/var.o ${OBJECTDIR}/event.o ${OBJECTDIR}/stateMachine.o
POSSIBLE_DEPFILES=${OBJECTDIR}/adc.o.d ${OBJECTDIR}/keypad.o.d ${OBJECTDIR}/lcd.o.d ${OBJECTDIR}/led.o.d ${OBJECTDIR}/main.o.d ${OBJECTDIR}/pwm.o.d ${OBJECTDIR}/rtc.o.d ${OBJECTDIR}/serial.o.d ${OBJECTDIR}/ssd.o.d ${OBJECTDIR}/stdio.o.d ${OBJECTDIR}/timer.o.d ${OBJECTDIR}/output.o.d ${OBJECTDIR}/var.o.d ${OBJECTDIR}/event.o.d ${OBJECTDIR}/stateMachine.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/adc.o ${OBJECTDIR}/keypad.o ${OBJECTDIR}/lcd.o ${OBJECTDIR}/led.o ${OBJECTDIR}/main.o ${OBJECTDIR}/pwm.o ${OBJECTDIR}/rtc.o ${OBJECTDIR}/serial.o ${OBJECTDIR}/ssd.o ${OBJECTDIR}/stdio.o ${OBJECTDIR}/timer.o ${OBJECTDIR}/output.o ${OBJECTDIR}/var.o ${OBJECTDIR}/event.o ${OBJECTDIR}/stateMachine.o

# Source Files
SOURCEFILES=adc.c keypad.c lcd.c led.c main.c pwm.c rtc.c serial.c ssd.c stdio.c timer.c output.c var.c event.c stateMachine.c


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/ESM_Project.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/adc.o: adc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/adc.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 adc.c  -o${OBJECTDIR}/adc.o
	
${OBJECTDIR}/keypad.o: keypad.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/keypad.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 keypad.c  -o${OBJECTDIR}/keypad.o
	
${OBJECTDIR}/lcd.o: lcd.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/lcd.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 lcd.c  -o${OBJECTDIR}/lcd.o
	
${OBJECTDIR}/led.o: led.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/led.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 led.c  -o${OBJECTDIR}/led.o
	
${OBJECTDIR}/main.o: main.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/main.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 main.c  -o${OBJECTDIR}/main.o
	
${OBJECTDIR}/pwm.o: pwm.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/pwm.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 pwm.c  -o${OBJECTDIR}/pwm.o
	
${OBJECTDIR}/rtc.o: rtc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/rtc.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 rtc.c  -o${OBJECTDIR}/rtc.o
	
${OBJECTDIR}/serial.o: serial.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/serial.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 serial.c  -o${OBJECTDIR}/serial.o
	
${OBJECTDIR}/ssd.o: ssd.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/ssd.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 ssd.c  -o${OBJECTDIR}/ssd.o
	
${OBJECTDIR}/stdio.o: stdio.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/stdio.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 stdio.c  -o${OBJECTDIR}/stdio.o
	
${OBJECTDIR}/timer.o: timer.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/timer.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 timer.c  -o${OBJECTDIR}/timer.o
	
${OBJECTDIR}/output.o: output.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/output.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 output.c  -o${OBJECTDIR}/output.o
	
${OBJECTDIR}/var.o: var.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/var.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 var.c  -o${OBJECTDIR}/var.o
	
${OBJECTDIR}/event.o: event.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/event.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 event.c  -o${OBJECTDIR}/event.o
	
${OBJECTDIR}/stateMachine.o: stateMachine.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/stateMachine.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 stateMachine.c  -o${OBJECTDIR}/stateMachine.o
	
else
${OBJECTDIR}/adc.o: adc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/adc.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 adc.c  -o${OBJECTDIR}/adc.o
	
${OBJECTDIR}/keypad.o: keypad.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/keypad.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 keypad.c  -o${OBJECTDIR}/keypad.o
	
${OBJECTDIR}/lcd.o: lcd.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/lcd.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 lcd.c  -o${OBJECTDIR}/lcd.o
	
${OBJECTDIR}/led.o: led.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/led.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 led.c  -o${OBJECTDIR}/led.o
	
${OBJECTDIR}/main.o: main.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/main.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 main.c  -o${OBJECTDIR}/main.o
	
${OBJECTDIR}/pwm.o: pwm.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/pwm.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 pwm.c  -o${OBJECTDIR}/pwm.o
	
${OBJECTDIR}/rtc.o: rtc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/rtc.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 rtc.c  -o${OBJECTDIR}/rtc.o
	
${OBJECTDIR}/serial.o: serial.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/serial.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 serial.c  -o${OBJECTDIR}/serial.o
	
${OBJECTDIR}/ssd.o: ssd.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/ssd.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 ssd.c  -o${OBJECTDIR}/ssd.o
	
${OBJECTDIR}/stdio.o: stdio.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/stdio.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 stdio.c  -o${OBJECTDIR}/stdio.o
	
${OBJECTDIR}/timer.o: timer.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/timer.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 timer.c  -o${OBJECTDIR}/timer.o
	
${OBJECTDIR}/output.o: output.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/output.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 output.c  -o${OBJECTDIR}/output.o
	
${OBJECTDIR}/var.o: var.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/var.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 var.c  -o${OBJECTDIR}/var.o
	
${OBJECTDIR}/event.o: event.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/event.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 event.c  -o${OBJECTDIR}/event.o
	
${OBJECTDIR}/stateMachine.o: stateMachine.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${RM} ${OBJECTDIR}/stateMachine.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4520 stateMachine.c  -o${OBJECTDIR}/stateMachine.o
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/ESM_Project.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} -Wl-c -Wl-m --use-non-free -mpic16 -p18f4520 ${OBJECTFILES} -odist/${CND_CONF}/${IMAGE_TYPE}/ESM_Project.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} 
else
dist/${CND_CONF}/${IMAGE_TYPE}/ESM_Project.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} -Wl-c -Wl-m --use-non-free -mpic16 -p18f4520 ${OBJECTFILES} -odist/${CND_CONF}/${IMAGE_TYPE}/ESM_Project.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif

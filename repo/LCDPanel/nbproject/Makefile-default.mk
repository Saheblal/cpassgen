#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
include Makefile

# Environment
# Adding MPLAB X bin directory to path
PATH:=/opt/microchip/mplabx/mplab_ide/mplab_ide/modules/../../bin/:$(PATH)
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/LCDPanel.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/LCDPanel.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/src/registers.o ${OBJECTDIR}/src/xlcd.o ${OBJECTDIR}/src/uart.o ${OBJECTDIR}/src/maths.o ${OBJECTDIR}/src/LCDPanel.o ${OBJECTDIR}/src/prg_tests.o
POSSIBLE_DEPFILES=${OBJECTDIR}/src/registers.o.d ${OBJECTDIR}/src/xlcd.o.d ${OBJECTDIR}/src/uart.o.d ${OBJECTDIR}/src/maths.o.d ${OBJECTDIR}/src/LCDPanel.o.d ${OBJECTDIR}/src/prg_tests.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/src/registers.o ${OBJECTDIR}/src/xlcd.o ${OBJECTDIR}/src/uart.o ${OBJECTDIR}/src/maths.o ${OBJECTDIR}/src/LCDPanel.o ${OBJECTDIR}/src/prg_tests.o


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

# Path to java used to run MPLAB X when this makefile was created
MP_JAVA_PATH="/usr/lib/jvm/java-6-sun-1.6.0.26/jre/bin/"
OS_CURRENT="$(shell uname -s)"
############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# MP_CC is not defined
# MP_BC is not defined
MP_AS="/opt/microchip/mplabx/mpasmx/mpasmx"
MP_LD="/opt/microchip/mplabx/mpasmx/mplink"
MP_AR="/opt/microchip/mplabx/mpasmx/mplib"
DEP_GEN=${MP_JAVA_PATH}java -jar "/opt/microchip/mplabx/mplab_ide/mplab_ide/modules/../../bin/extractobjectdependencies.jar" 
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps
# MP_CC_DIR is not defined
# MP_BC_DIR is not defined
MP_AS_DIR="/opt/microchip/mplabx/mpasmx"
MP_LD_DIR="/opt/microchip/mplabx/mpasmx"
MP_AR_DIR="/opt/microchip/mplabx/mpasmx"
# MP_BC_DIR is not defined

.build-conf:  ${BUILD_SUBPROJECTS}
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/LCDPanel.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=16f877a
MP_LINKER_DEBUG_OPTION= -u_DEBUGCODESTART=0x1f00 -u_DEBUGCODELEN=0x100 -u_DEBUGDATASTART=0x1e5 -u_DEBUGDATALEN=0xb
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/src/registers.o: src/registers.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/registers.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/registers.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/src/registers.lst\" -e\"${OBJECTDIR}/src/registers.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/src/registers.o\" src/registers.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/src/registers.o 
	
${OBJECTDIR}/src/xlcd.o: src/xlcd.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/xlcd.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xlcd.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/src/xlcd.lst\" -e\"${OBJECTDIR}/src/xlcd.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/src/xlcd.o\" src/xlcd.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/src/xlcd.o 
	
${OBJECTDIR}/src/uart.o: src/uart.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/uart.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/uart.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/src/uart.lst\" -e\"${OBJECTDIR}/src/uart.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/src/uart.o\" src/uart.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/src/uart.o 
	
${OBJECTDIR}/src/maths.o: src/maths.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/maths.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/maths.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/src/maths.lst\" -e\"${OBJECTDIR}/src/maths.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/src/maths.o\" src/maths.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/src/maths.o 
	
${OBJECTDIR}/src/LCDPanel.o: src/LCDPanel.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/LCDPanel.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/LCDPanel.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/src/LCDPanel.lst\" -e\"${OBJECTDIR}/src/LCDPanel.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/src/LCDPanel.o\" src/LCDPanel.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/src/LCDPanel.o 
	
${OBJECTDIR}/src/prg_tests.o: src/prg_tests.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/prg_tests.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/prg_tests.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/src/prg_tests.lst\" -e\"${OBJECTDIR}/src/prg_tests.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/src/prg_tests.o\" src/prg_tests.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/src/prg_tests.o 
	
else
${OBJECTDIR}/src/registers.o: src/registers.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/registers.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/registers.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/src/registers.lst\" -e\"${OBJECTDIR}/src/registers.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/src/registers.o\" src/registers.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/src/registers.o 
	
${OBJECTDIR}/src/xlcd.o: src/xlcd.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/xlcd.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xlcd.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/src/xlcd.lst\" -e\"${OBJECTDIR}/src/xlcd.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/src/xlcd.o\" src/xlcd.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/src/xlcd.o 
	
${OBJECTDIR}/src/uart.o: src/uart.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/uart.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/uart.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/src/uart.lst\" -e\"${OBJECTDIR}/src/uart.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/src/uart.o\" src/uart.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/src/uart.o 
	
${OBJECTDIR}/src/maths.o: src/maths.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/maths.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/maths.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/src/maths.lst\" -e\"${OBJECTDIR}/src/maths.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/src/maths.o\" src/maths.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/src/maths.o 
	
${OBJECTDIR}/src/LCDPanel.o: src/LCDPanel.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/LCDPanel.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/LCDPanel.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/src/LCDPanel.lst\" -e\"${OBJECTDIR}/src/LCDPanel.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/src/LCDPanel.o\" src/LCDPanel.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/src/LCDPanel.o 
	
${OBJECTDIR}/src/prg_tests.o: src/prg_tests.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/prg_tests.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/prg_tests.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/src/prg_tests.lst\" -e\"${OBJECTDIR}/src/prg_tests.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/src/prg_tests.o\" src/prg_tests.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/src/prg_tests.o 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/LCDPanel.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w -x -u_DEBUG -z__ICD2RAM=1    -z__MPLAB_BUILD=1  -z__MPLAB_DEBUG=1 -z__MPLAB_DEBUGGER_PICKIT2=1 $(MP_LINKER_DEBUG_OPTION) -odist/${CND_CONF}/${IMAGE_TYPE}/LCDPanel.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES}     
else
dist/${CND_CONF}/${IMAGE_TYPE}/LCDPanel.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w     -z__MPLAB_BUILD=1  -odist/${CND_CONF}/${IMAGE_TYPE}/LCDPanel.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES}     
endif


# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf:
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell "/opt/microchip/mplabx/mplab_ide/mplab_ide/modules/../../bin/"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif

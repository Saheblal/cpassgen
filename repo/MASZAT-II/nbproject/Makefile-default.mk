#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
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
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/MASZAT-II.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/MASZAT-II.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/RALLY_001.o ${OBJECTDIR}/XLCD.o ${OBJECTDIR}/UART.o ${OBJECTDIR}/MATHS.o ${OBJECTDIR}/crc.o ${OBJECTDIR}/registers.o
POSSIBLE_DEPFILES=${OBJECTDIR}/RALLY_001.o.d ${OBJECTDIR}/XLCD.o.d ${OBJECTDIR}/UART.o.d ${OBJECTDIR}/MATHS.o.d ${OBJECTDIR}/crc.o.d ${OBJECTDIR}/registers.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/RALLY_001.o ${OBJECTDIR}/XLCD.o ${OBJECTDIR}/UART.o ${OBJECTDIR}/MATHS.o ${OBJECTDIR}/crc.o ${OBJECTDIR}/registers.o


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
	${MAKE} ${MAKE_OPTIONS} -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/MASZAT-II.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=16f877a
MP_LINKER_DEBUG_OPTION= -u_DEBUGCODESTART=0x1f00 -u_DEBUGCODELEN=0x100 -u_DEBUGDATASTART=0x1e5 -u_DEBUGDATALEN=0xb
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/RALLY_001.o: RALLY_001.ASM  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/RALLY_001.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/RALLY_001.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/RALLY_001.lst\" -e\"${OBJECTDIR}/RALLY_001.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/RALLY_001.o\" RALLY_001.ASM 
	@${DEP_GEN} -d ${OBJECTDIR}/RALLY_001.o 
	
${OBJECTDIR}/XLCD.o: XLCD.ASM  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/XLCD.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/XLCD.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/XLCD.lst\" -e\"${OBJECTDIR}/XLCD.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/XLCD.o\" XLCD.ASM 
	@${DEP_GEN} -d ${OBJECTDIR}/XLCD.o 
	
${OBJECTDIR}/UART.o: UART.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/UART.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/UART.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/UART.lst\" -e\"${OBJECTDIR}/UART.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/UART.o\" UART.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/UART.o 
	
${OBJECTDIR}/MATHS.o: MATHS.ASM  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/MATHS.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/MATHS.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/MATHS.lst\" -e\"${OBJECTDIR}/MATHS.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/MATHS.o\" MATHS.ASM 
	@${DEP_GEN} -d ${OBJECTDIR}/MATHS.o 
	
${OBJECTDIR}/crc.o: crc.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/crc.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/crc.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/crc.lst\" -e\"${OBJECTDIR}/crc.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/crc.o\" crc.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/crc.o 
	
${OBJECTDIR}/registers.o: registers.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/registers.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/registers.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/registers.lst\" -e\"${OBJECTDIR}/registers.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/registers.o\" registers.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/registers.o 
	
else
${OBJECTDIR}/RALLY_001.o: RALLY_001.ASM  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/RALLY_001.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/RALLY_001.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/RALLY_001.lst\" -e\"${OBJECTDIR}/RALLY_001.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/RALLY_001.o\" RALLY_001.ASM 
	@${DEP_GEN} -d ${OBJECTDIR}/RALLY_001.o 
	
${OBJECTDIR}/XLCD.o: XLCD.ASM  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/XLCD.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/XLCD.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/XLCD.lst\" -e\"${OBJECTDIR}/XLCD.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/XLCD.o\" XLCD.ASM 
	@${DEP_GEN} -d ${OBJECTDIR}/XLCD.o 
	
${OBJECTDIR}/UART.o: UART.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/UART.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/UART.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/UART.lst\" -e\"${OBJECTDIR}/UART.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/UART.o\" UART.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/UART.o 
	
${OBJECTDIR}/MATHS.o: MATHS.ASM  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/MATHS.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/MATHS.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/MATHS.lst\" -e\"${OBJECTDIR}/MATHS.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/MATHS.o\" MATHS.ASM 
	@${DEP_GEN} -d ${OBJECTDIR}/MATHS.o 
	
${OBJECTDIR}/crc.o: crc.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/crc.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/crc.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/crc.lst\" -e\"${OBJECTDIR}/crc.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/crc.o\" crc.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/crc.o 
	
${OBJECTDIR}/registers.o: registers.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/registers.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/registers.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/registers.lst\" -e\"${OBJECTDIR}/registers.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/registers.o\" registers.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/registers.o 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/MASZAT-II.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w -x -u_DEBUG -z__ICD2RAM=1 -m"MASZAT.MAP"   -z__MPLAB_BUILD=1  -z__MPLAB_DEBUG=1 -z__MPLAB_DEBUGGER_PICKIT2=1 $(MP_LINKER_DEBUG_OPTION) -odist/${CND_CONF}/${IMAGE_TYPE}/MASZAT-II.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES}     
else
dist/${CND_CONF}/${IMAGE_TYPE}/MASZAT-II.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w  -m"MASZAT.MAP"   -z__MPLAB_BUILD=1  -odist/${CND_CONF}/${IMAGE_TYPE}/MASZAT-II.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES}     
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

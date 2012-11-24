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
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/PIC32MTest.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/PIC32MTest.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/src/graphics/GOL.o ${OBJECTDIR}/src/graphics/GOLFontDefault.o ${OBJECTDIR}/src/graphics/GOLSchemeDefault.o ${OBJECTDIR}/src/graphics/Primitive.o ${OBJECTDIR}/src/graphics/Drivers/HX8347.o ${OBJECTDIR}/configuration_bits.o ${OBJECTDIR}/exceptions.o ${OBJECTDIR}/interrupts.o ${OBJECTDIR}/main.o ${OBJECTDIR}/system.o ${OBJECTDIR}/user.o ${OBJECTDIR}/resources.o
POSSIBLE_DEPFILES=${OBJECTDIR}/src/graphics/GOL.o.d ${OBJECTDIR}/src/graphics/GOLFontDefault.o.d ${OBJECTDIR}/src/graphics/GOLSchemeDefault.o.d ${OBJECTDIR}/src/graphics/Primitive.o.d ${OBJECTDIR}/src/graphics/Drivers/HX8347.o.d ${OBJECTDIR}/configuration_bits.o.d ${OBJECTDIR}/exceptions.o.d ${OBJECTDIR}/interrupts.o.d ${OBJECTDIR}/main.o.d ${OBJECTDIR}/system.o.d ${OBJECTDIR}/user.o.d ${OBJECTDIR}/resources.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/src/graphics/GOL.o ${OBJECTDIR}/src/graphics/GOLFontDefault.o ${OBJECTDIR}/src/graphics/GOLSchemeDefault.o ${OBJECTDIR}/src/graphics/Primitive.o ${OBJECTDIR}/src/graphics/Drivers/HX8347.o ${OBJECTDIR}/configuration_bits.o ${OBJECTDIR}/exceptions.o ${OBJECTDIR}/interrupts.o ${OBJECTDIR}/main.o ${OBJECTDIR}/system.o ${OBJECTDIR}/user.o ${OBJECTDIR}/resources.o


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
	${MAKE} ${MAKE_OPTIONS} -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/PIC32MTest.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=32MX460F512L
MP_LINKER_FILE_OPTION=
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/src/graphics/GOL.o: src/graphics/GOL.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src/graphics 
	@${RM} ${OBJECTDIR}/src/graphics/GOL.o.d 
	@${FIXDEPS} "${OBJECTDIR}/src/graphics/GOL.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/src/graphics/GOL.o.d" -o ${OBJECTDIR}/src/graphics/GOL.o src/graphics/GOL.c  
	
${OBJECTDIR}/src/graphics/GOLFontDefault.o: src/graphics/GOLFontDefault.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src/graphics 
	@${RM} ${OBJECTDIR}/src/graphics/GOLFontDefault.o.d 
	@${FIXDEPS} "${OBJECTDIR}/src/graphics/GOLFontDefault.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/src/graphics/GOLFontDefault.o.d" -o ${OBJECTDIR}/src/graphics/GOLFontDefault.o src/graphics/GOLFontDefault.c  
	
${OBJECTDIR}/src/graphics/GOLSchemeDefault.o: src/graphics/GOLSchemeDefault.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src/graphics 
	@${RM} ${OBJECTDIR}/src/graphics/GOLSchemeDefault.o.d 
	@${FIXDEPS} "${OBJECTDIR}/src/graphics/GOLSchemeDefault.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/src/graphics/GOLSchemeDefault.o.d" -o ${OBJECTDIR}/src/graphics/GOLSchemeDefault.o src/graphics/GOLSchemeDefault.c  
	
${OBJECTDIR}/src/graphics/Primitive.o: src/graphics/Primitive.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src/graphics 
	@${RM} ${OBJECTDIR}/src/graphics/Primitive.o.d 
	@${FIXDEPS} "${OBJECTDIR}/src/graphics/Primitive.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/src/graphics/Primitive.o.d" -o ${OBJECTDIR}/src/graphics/Primitive.o src/graphics/Primitive.c  
	
${OBJECTDIR}/src/graphics/Drivers/HX8347.o: src/graphics/Drivers/HX8347.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src/graphics/Drivers 
	@${RM} ${OBJECTDIR}/src/graphics/Drivers/HX8347.o.d 
	@${FIXDEPS} "${OBJECTDIR}/src/graphics/Drivers/HX8347.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/src/graphics/Drivers/HX8347.o.d" -o ${OBJECTDIR}/src/graphics/Drivers/HX8347.o src/graphics/Drivers/HX8347.c  
	
${OBJECTDIR}/configuration_bits.o: configuration_bits.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/configuration_bits.o.d 
	@${FIXDEPS} "${OBJECTDIR}/configuration_bits.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/configuration_bits.o.d" -o ${OBJECTDIR}/configuration_bits.o configuration_bits.c  
	
${OBJECTDIR}/exceptions.o: exceptions.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/exceptions.o.d 
	@${FIXDEPS} "${OBJECTDIR}/exceptions.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/exceptions.o.d" -o ${OBJECTDIR}/exceptions.o exceptions.c  
	
${OBJECTDIR}/interrupts.o: interrupts.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/interrupts.o.d 
	@${FIXDEPS} "${OBJECTDIR}/interrupts.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/interrupts.o.d" -o ${OBJECTDIR}/interrupts.o interrupts.c  
	
${OBJECTDIR}/main.o: main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${FIXDEPS} "${OBJECTDIR}/main.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/main.o.d" -o ${OBJECTDIR}/main.o main.c  
	
${OBJECTDIR}/system.o: system.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/system.o.d 
	@${FIXDEPS} "${OBJECTDIR}/system.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/system.o.d" -o ${OBJECTDIR}/system.o system.c  
	
${OBJECTDIR}/user.o: user.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/user.o.d 
	@${FIXDEPS} "${OBJECTDIR}/user.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/user.o.d" -o ${OBJECTDIR}/user.o user.c  
	
${OBJECTDIR}/resources.o: resources.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/resources.o.d 
	@${FIXDEPS} "${OBJECTDIR}/resources.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/resources.o.d" -o ${OBJECTDIR}/resources.o resources.c  
	
else
${OBJECTDIR}/src/graphics/GOL.o: src/graphics/GOL.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src/graphics 
	@${RM} ${OBJECTDIR}/src/graphics/GOL.o.d 
	@${FIXDEPS} "${OBJECTDIR}/src/graphics/GOL.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/src/graphics/GOL.o.d" -o ${OBJECTDIR}/src/graphics/GOL.o src/graphics/GOL.c  
	
${OBJECTDIR}/src/graphics/GOLFontDefault.o: src/graphics/GOLFontDefault.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src/graphics 
	@${RM} ${OBJECTDIR}/src/graphics/GOLFontDefault.o.d 
	@${FIXDEPS} "${OBJECTDIR}/src/graphics/GOLFontDefault.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/src/graphics/GOLFontDefault.o.d" -o ${OBJECTDIR}/src/graphics/GOLFontDefault.o src/graphics/GOLFontDefault.c  
	
${OBJECTDIR}/src/graphics/GOLSchemeDefault.o: src/graphics/GOLSchemeDefault.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src/graphics 
	@${RM} ${OBJECTDIR}/src/graphics/GOLSchemeDefault.o.d 
	@${FIXDEPS} "${OBJECTDIR}/src/graphics/GOLSchemeDefault.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/src/graphics/GOLSchemeDefault.o.d" -o ${OBJECTDIR}/src/graphics/GOLSchemeDefault.o src/graphics/GOLSchemeDefault.c  
	
${OBJECTDIR}/src/graphics/Primitive.o: src/graphics/Primitive.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src/graphics 
	@${RM} ${OBJECTDIR}/src/graphics/Primitive.o.d 
	@${FIXDEPS} "${OBJECTDIR}/src/graphics/Primitive.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/src/graphics/Primitive.o.d" -o ${OBJECTDIR}/src/graphics/Primitive.o src/graphics/Primitive.c  
	
${OBJECTDIR}/src/graphics/Drivers/HX8347.o: src/graphics/Drivers/HX8347.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src/graphics/Drivers 
	@${RM} ${OBJECTDIR}/src/graphics/Drivers/HX8347.o.d 
	@${FIXDEPS} "${OBJECTDIR}/src/graphics/Drivers/HX8347.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/src/graphics/Drivers/HX8347.o.d" -o ${OBJECTDIR}/src/graphics/Drivers/HX8347.o src/graphics/Drivers/HX8347.c  
	
${OBJECTDIR}/configuration_bits.o: configuration_bits.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/configuration_bits.o.d 
	@${FIXDEPS} "${OBJECTDIR}/configuration_bits.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/configuration_bits.o.d" -o ${OBJECTDIR}/configuration_bits.o configuration_bits.c  
	
${OBJECTDIR}/exceptions.o: exceptions.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/exceptions.o.d 
	@${FIXDEPS} "${OBJECTDIR}/exceptions.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/exceptions.o.d" -o ${OBJECTDIR}/exceptions.o exceptions.c  
	
${OBJECTDIR}/interrupts.o: interrupts.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/interrupts.o.d 
	@${FIXDEPS} "${OBJECTDIR}/interrupts.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/interrupts.o.d" -o ${OBJECTDIR}/interrupts.o interrupts.c  
	
${OBJECTDIR}/main.o: main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${FIXDEPS} "${OBJECTDIR}/main.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/main.o.d" -o ${OBJECTDIR}/main.o main.c  
	
${OBJECTDIR}/system.o: system.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/system.o.d 
	@${FIXDEPS} "${OBJECTDIR}/system.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/system.o.d" -o ${OBJECTDIR}/system.o system.c  
	
${OBJECTDIR}/user.o: user.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/user.o.d 
	@${FIXDEPS} "${OBJECTDIR}/user.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/user.o.d" -o ${OBJECTDIR}/user.o user.c  
	
${OBJECTDIR}/resources.o: resources.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/resources.o.d 
	@${FIXDEPS} "${OBJECTDIR}/resources.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -DCFG_INCLUDE_MPLAB_X -DCFG_INCLUDE_MIKROE_PIC32_GP_SK_16PMP -DUSE_PRIMITIVE_PUTIMAGE -I"C:/Documents and Settings/Bandi/MPLABXProjects/PIC32MTest.X/includes" -MMD -MF "${OBJECTDIR}/resources.o.d" -o ${OBJECTDIR}/resources.o resources.c  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/PIC32MTest.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)    -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/PIC32MTest.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}       -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__ICD2RAM=1,--defsym=__DEBUG=1,--defsym=_min_heap_size=3000 
else
dist/${CND_CONF}/${IMAGE_TYPE}/PIC32MTest.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/PIC32MTest.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}       -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=_min_heap_size=3000
	${MP_CC_DIR}\\pic32-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/PIC32MTest.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  
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

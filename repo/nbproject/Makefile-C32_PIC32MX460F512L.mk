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
ifeq "$(wildcard nbproject/Makefile-local-C32_PIC32MX460F512L.mk)" "nbproject/Makefile-local-C32_PIC32MX460F512L.mk"
include nbproject/Makefile-local-C32_PIC32MX460F512L.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=C32_PIC32MX460F512L
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Mikroe_Graphics_Test.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Mikroe_Graphics_Test.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=graphics/drivers/ILI9341.c graphics/AnalogClock.c graphics/Button.c graphics/Chart.c graphics/CheckBox.c graphics/DigitalMeter.c graphics/EditBox.c graphics/GOL.c graphics/GOLSchemeDefault.c graphics/Grid.c graphics/GroupBox.c graphics/ListBox.c graphics/Meter.c graphics/Palette.c graphics/Picture.c graphics/Primitive.c graphics/ProgressBar.c graphics/RadioButton.c graphics/RoundDial.c graphics/Slider.c graphics/StaticText.c graphics/Template.c graphics/TextEntry.c graphics/Transitions.c graphics/Transitions_weak.c graphics/Window.c configuration_bits.c exceptions.c interrupts.c system.c user.c TimeDelay.c Beep.c CustomControlDemo.c TouchScreen.c drv_spi.c rtcc.c InternalResourceXC32.c cpld.c TouchScreenResistive.c MainDemo.c SST25VF016.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/graphics/drivers/ILI9341.o ${OBJECTDIR}/graphics/AnalogClock.o ${OBJECTDIR}/graphics/Button.o ${OBJECTDIR}/graphics/Chart.o ${OBJECTDIR}/graphics/CheckBox.o ${OBJECTDIR}/graphics/DigitalMeter.o ${OBJECTDIR}/graphics/EditBox.o ${OBJECTDIR}/graphics/GOL.o ${OBJECTDIR}/graphics/GOLSchemeDefault.o ${OBJECTDIR}/graphics/Grid.o ${OBJECTDIR}/graphics/GroupBox.o ${OBJECTDIR}/graphics/ListBox.o ${OBJECTDIR}/graphics/Meter.o ${OBJECTDIR}/graphics/Palette.o ${OBJECTDIR}/graphics/Picture.o ${OBJECTDIR}/graphics/Primitive.o ${OBJECTDIR}/graphics/ProgressBar.o ${OBJECTDIR}/graphics/RadioButton.o ${OBJECTDIR}/graphics/RoundDial.o ${OBJECTDIR}/graphics/Slider.o ${OBJECTDIR}/graphics/StaticText.o ${OBJECTDIR}/graphics/Template.o ${OBJECTDIR}/graphics/TextEntry.o ${OBJECTDIR}/graphics/Transitions.o ${OBJECTDIR}/graphics/Transitions_weak.o ${OBJECTDIR}/graphics/Window.o ${OBJECTDIR}/configuration_bits.o ${OBJECTDIR}/exceptions.o ${OBJECTDIR}/interrupts.o ${OBJECTDIR}/system.o ${OBJECTDIR}/user.o ${OBJECTDIR}/TimeDelay.o ${OBJECTDIR}/Beep.o ${OBJECTDIR}/CustomControlDemo.o ${OBJECTDIR}/TouchScreen.o ${OBJECTDIR}/drv_spi.o ${OBJECTDIR}/rtcc.o ${OBJECTDIR}/InternalResourceXC32.o ${OBJECTDIR}/cpld.o ${OBJECTDIR}/TouchScreenResistive.o ${OBJECTDIR}/MainDemo.o ${OBJECTDIR}/SST25VF016.o
POSSIBLE_DEPFILES=${OBJECTDIR}/graphics/drivers/ILI9341.o.d ${OBJECTDIR}/graphics/AnalogClock.o.d ${OBJECTDIR}/graphics/Button.o.d ${OBJECTDIR}/graphics/Chart.o.d ${OBJECTDIR}/graphics/CheckBox.o.d ${OBJECTDIR}/graphics/DigitalMeter.o.d ${OBJECTDIR}/graphics/EditBox.o.d ${OBJECTDIR}/graphics/GOL.o.d ${OBJECTDIR}/graphics/GOLSchemeDefault.o.d ${OBJECTDIR}/graphics/Grid.o.d ${OBJECTDIR}/graphics/GroupBox.o.d ${OBJECTDIR}/graphics/ListBox.o.d ${OBJECTDIR}/graphics/Meter.o.d ${OBJECTDIR}/graphics/Palette.o.d ${OBJECTDIR}/graphics/Picture.o.d ${OBJECTDIR}/graphics/Primitive.o.d ${OBJECTDIR}/graphics/ProgressBar.o.d ${OBJECTDIR}/graphics/RadioButton.o.d ${OBJECTDIR}/graphics/RoundDial.o.d ${OBJECTDIR}/graphics/Slider.o.d ${OBJECTDIR}/graphics/StaticText.o.d ${OBJECTDIR}/graphics/Template.o.d ${OBJECTDIR}/graphics/TextEntry.o.d ${OBJECTDIR}/graphics/Transitions.o.d ${OBJECTDIR}/graphics/Transitions_weak.o.d ${OBJECTDIR}/graphics/Window.o.d ${OBJECTDIR}/configuration_bits.o.d ${OBJECTDIR}/exceptions.o.d ${OBJECTDIR}/interrupts.o.d ${OBJECTDIR}/system.o.d ${OBJECTDIR}/user.o.d ${OBJECTDIR}/TimeDelay.o.d ${OBJECTDIR}/Beep.o.d ${OBJECTDIR}/CustomControlDemo.o.d ${OBJECTDIR}/TouchScreen.o.d ${OBJECTDIR}/drv_spi.o.d ${OBJECTDIR}/rtcc.o.d ${OBJECTDIR}/InternalResourceXC32.o.d ${OBJECTDIR}/cpld.o.d ${OBJECTDIR}/TouchScreenResistive.o.d ${OBJECTDIR}/MainDemo.o.d ${OBJECTDIR}/SST25VF016.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/graphics/drivers/ILI9341.o ${OBJECTDIR}/graphics/AnalogClock.o ${OBJECTDIR}/graphics/Button.o ${OBJECTDIR}/graphics/Chart.o ${OBJECTDIR}/graphics/CheckBox.o ${OBJECTDIR}/graphics/DigitalMeter.o ${OBJECTDIR}/graphics/EditBox.o ${OBJECTDIR}/graphics/GOL.o ${OBJECTDIR}/graphics/GOLSchemeDefault.o ${OBJECTDIR}/graphics/Grid.o ${OBJECTDIR}/graphics/GroupBox.o ${OBJECTDIR}/graphics/ListBox.o ${OBJECTDIR}/graphics/Meter.o ${OBJECTDIR}/graphics/Palette.o ${OBJECTDIR}/graphics/Picture.o ${OBJECTDIR}/graphics/Primitive.o ${OBJECTDIR}/graphics/ProgressBar.o ${OBJECTDIR}/graphics/RadioButton.o ${OBJECTDIR}/graphics/RoundDial.o ${OBJECTDIR}/graphics/Slider.o ${OBJECTDIR}/graphics/StaticText.o ${OBJECTDIR}/graphics/Template.o ${OBJECTDIR}/graphics/TextEntry.o ${OBJECTDIR}/graphics/Transitions.o ${OBJECTDIR}/graphics/Transitions_weak.o ${OBJECTDIR}/graphics/Window.o ${OBJECTDIR}/configuration_bits.o ${OBJECTDIR}/exceptions.o ${OBJECTDIR}/interrupts.o ${OBJECTDIR}/system.o ${OBJECTDIR}/user.o ${OBJECTDIR}/TimeDelay.o ${OBJECTDIR}/Beep.o ${OBJECTDIR}/CustomControlDemo.o ${OBJECTDIR}/TouchScreen.o ${OBJECTDIR}/drv_spi.o ${OBJECTDIR}/rtcc.o ${OBJECTDIR}/InternalResourceXC32.o ${OBJECTDIR}/cpld.o ${OBJECTDIR}/TouchScreenResistive.o ${OBJECTDIR}/MainDemo.o ${OBJECTDIR}/SST25VF016.o

# Source Files
SOURCEFILES=graphics/drivers/ILI9341.c graphics/AnalogClock.c graphics/Button.c graphics/Chart.c graphics/CheckBox.c graphics/DigitalMeter.c graphics/EditBox.c graphics/GOL.c graphics/GOLSchemeDefault.c graphics/Grid.c graphics/GroupBox.c graphics/ListBox.c graphics/Meter.c graphics/Palette.c graphics/Picture.c graphics/Primitive.c graphics/ProgressBar.c graphics/RadioButton.c graphics/RoundDial.c graphics/Slider.c graphics/StaticText.c graphics/Template.c graphics/TextEntry.c graphics/Transitions.c graphics/Transitions_weak.c graphics/Window.c configuration_bits.c exceptions.c interrupts.c system.c user.c TimeDelay.c Beep.c CustomControlDemo.c TouchScreen.c drv_spi.c rtcc.c InternalResourceXC32.c cpld.c TouchScreenResistive.c MainDemo.c SST25VF016.c


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
	${MAKE} ${MAKE_OPTIONS} -f nbproject/Makefile-C32_PIC32MX460F512L.mk dist/${CND_CONF}/${IMAGE_TYPE}/Mikroe_Graphics_Test.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

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
${OBJECTDIR}/graphics/drivers/ILI9341.o: graphics/drivers/ILI9341.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics/drivers 
	@${RM} ${OBJECTDIR}/graphics/drivers/ILI9341.o.d 
	@${RM} ${OBJECTDIR}/graphics/drivers/ILI9341.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/drivers/ILI9341.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/drivers/ILI9341.o.d" -o ${OBJECTDIR}/graphics/drivers/ILI9341.o graphics/drivers/ILI9341.c   
	
${OBJECTDIR}/graphics/AnalogClock.o: graphics/AnalogClock.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/AnalogClock.o.d 
	@${RM} ${OBJECTDIR}/graphics/AnalogClock.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/AnalogClock.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/AnalogClock.o.d" -o ${OBJECTDIR}/graphics/AnalogClock.o graphics/AnalogClock.c   
	
${OBJECTDIR}/graphics/Button.o: graphics/Button.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Button.o.d 
	@${RM} ${OBJECTDIR}/graphics/Button.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Button.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Button.o.d" -o ${OBJECTDIR}/graphics/Button.o graphics/Button.c   
	
${OBJECTDIR}/graphics/Chart.o: graphics/Chart.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Chart.o.d 
	@${RM} ${OBJECTDIR}/graphics/Chart.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Chart.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Chart.o.d" -o ${OBJECTDIR}/graphics/Chart.o graphics/Chart.c   
	
${OBJECTDIR}/graphics/CheckBox.o: graphics/CheckBox.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/CheckBox.o.d 
	@${RM} ${OBJECTDIR}/graphics/CheckBox.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/CheckBox.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/CheckBox.o.d" -o ${OBJECTDIR}/graphics/CheckBox.o graphics/CheckBox.c   
	
${OBJECTDIR}/graphics/DigitalMeter.o: graphics/DigitalMeter.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/DigitalMeter.o.d 
	@${RM} ${OBJECTDIR}/graphics/DigitalMeter.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/DigitalMeter.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/DigitalMeter.o.d" -o ${OBJECTDIR}/graphics/DigitalMeter.o graphics/DigitalMeter.c   
	
${OBJECTDIR}/graphics/EditBox.o: graphics/EditBox.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/EditBox.o.d 
	@${RM} ${OBJECTDIR}/graphics/EditBox.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/EditBox.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/EditBox.o.d" -o ${OBJECTDIR}/graphics/EditBox.o graphics/EditBox.c   
	
${OBJECTDIR}/graphics/GOL.o: graphics/GOL.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/GOL.o.d 
	@${RM} ${OBJECTDIR}/graphics/GOL.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/GOL.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/GOL.o.d" -o ${OBJECTDIR}/graphics/GOL.o graphics/GOL.c   
	
${OBJECTDIR}/graphics/GOLSchemeDefault.o: graphics/GOLSchemeDefault.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/GOLSchemeDefault.o.d 
	@${RM} ${OBJECTDIR}/graphics/GOLSchemeDefault.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/GOLSchemeDefault.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/GOLSchemeDefault.o.d" -o ${OBJECTDIR}/graphics/GOLSchemeDefault.o graphics/GOLSchemeDefault.c   
	
${OBJECTDIR}/graphics/Grid.o: graphics/Grid.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Grid.o.d 
	@${RM} ${OBJECTDIR}/graphics/Grid.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Grid.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Grid.o.d" -o ${OBJECTDIR}/graphics/Grid.o graphics/Grid.c   
	
${OBJECTDIR}/graphics/GroupBox.o: graphics/GroupBox.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/GroupBox.o.d 
	@${RM} ${OBJECTDIR}/graphics/GroupBox.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/GroupBox.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/GroupBox.o.d" -o ${OBJECTDIR}/graphics/GroupBox.o graphics/GroupBox.c   
	
${OBJECTDIR}/graphics/ListBox.o: graphics/ListBox.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/ListBox.o.d 
	@${RM} ${OBJECTDIR}/graphics/ListBox.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/ListBox.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/ListBox.o.d" -o ${OBJECTDIR}/graphics/ListBox.o graphics/ListBox.c   
	
${OBJECTDIR}/graphics/Meter.o: graphics/Meter.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Meter.o.d 
	@${RM} ${OBJECTDIR}/graphics/Meter.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Meter.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Meter.o.d" -o ${OBJECTDIR}/graphics/Meter.o graphics/Meter.c   
	
${OBJECTDIR}/graphics/Palette.o: graphics/Palette.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Palette.o.d 
	@${RM} ${OBJECTDIR}/graphics/Palette.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Palette.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Palette.o.d" -o ${OBJECTDIR}/graphics/Palette.o graphics/Palette.c   
	
${OBJECTDIR}/graphics/Picture.o: graphics/Picture.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Picture.o.d 
	@${RM} ${OBJECTDIR}/graphics/Picture.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Picture.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Picture.o.d" -o ${OBJECTDIR}/graphics/Picture.o graphics/Picture.c   
	
${OBJECTDIR}/graphics/Primitive.o: graphics/Primitive.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Primitive.o.d 
	@${RM} ${OBJECTDIR}/graphics/Primitive.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Primitive.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Primitive.o.d" -o ${OBJECTDIR}/graphics/Primitive.o graphics/Primitive.c   
	
${OBJECTDIR}/graphics/ProgressBar.o: graphics/ProgressBar.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/ProgressBar.o.d 
	@${RM} ${OBJECTDIR}/graphics/ProgressBar.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/ProgressBar.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/ProgressBar.o.d" -o ${OBJECTDIR}/graphics/ProgressBar.o graphics/ProgressBar.c   
	
${OBJECTDIR}/graphics/RadioButton.o: graphics/RadioButton.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/RadioButton.o.d 
	@${RM} ${OBJECTDIR}/graphics/RadioButton.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/RadioButton.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/RadioButton.o.d" -o ${OBJECTDIR}/graphics/RadioButton.o graphics/RadioButton.c   
	
${OBJECTDIR}/graphics/RoundDial.o: graphics/RoundDial.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/RoundDial.o.d 
	@${RM} ${OBJECTDIR}/graphics/RoundDial.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/RoundDial.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/RoundDial.o.d" -o ${OBJECTDIR}/graphics/RoundDial.o graphics/RoundDial.c   
	
${OBJECTDIR}/graphics/Slider.o: graphics/Slider.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Slider.o.d 
	@${RM} ${OBJECTDIR}/graphics/Slider.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Slider.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Slider.o.d" -o ${OBJECTDIR}/graphics/Slider.o graphics/Slider.c   
	
${OBJECTDIR}/graphics/StaticText.o: graphics/StaticText.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/StaticText.o.d 
	@${RM} ${OBJECTDIR}/graphics/StaticText.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/StaticText.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/StaticText.o.d" -o ${OBJECTDIR}/graphics/StaticText.o graphics/StaticText.c   
	
${OBJECTDIR}/graphics/Template.o: graphics/Template.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Template.o.d 
	@${RM} ${OBJECTDIR}/graphics/Template.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Template.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Template.o.d" -o ${OBJECTDIR}/graphics/Template.o graphics/Template.c   
	
${OBJECTDIR}/graphics/TextEntry.o: graphics/TextEntry.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/TextEntry.o.d 
	@${RM} ${OBJECTDIR}/graphics/TextEntry.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/TextEntry.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/TextEntry.o.d" -o ${OBJECTDIR}/graphics/TextEntry.o graphics/TextEntry.c   
	
${OBJECTDIR}/graphics/Transitions.o: graphics/Transitions.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Transitions.o.d 
	@${RM} ${OBJECTDIR}/graphics/Transitions.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Transitions.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Transitions.o.d" -o ${OBJECTDIR}/graphics/Transitions.o graphics/Transitions.c   
	
${OBJECTDIR}/graphics/Transitions_weak.o: graphics/Transitions_weak.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Transitions_weak.o.d 
	@${RM} ${OBJECTDIR}/graphics/Transitions_weak.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Transitions_weak.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Transitions_weak.o.d" -o ${OBJECTDIR}/graphics/Transitions_weak.o graphics/Transitions_weak.c   
	
${OBJECTDIR}/graphics/Window.o: graphics/Window.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Window.o.d 
	@${RM} ${OBJECTDIR}/graphics/Window.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Window.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Window.o.d" -o ${OBJECTDIR}/graphics/Window.o graphics/Window.c   
	
${OBJECTDIR}/configuration_bits.o: configuration_bits.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/configuration_bits.o.d 
	@${RM} ${OBJECTDIR}/configuration_bits.o 
	@${FIXDEPS} "${OBJECTDIR}/configuration_bits.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/configuration_bits.o.d" -o ${OBJECTDIR}/configuration_bits.o configuration_bits.c   
	
${OBJECTDIR}/exceptions.o: exceptions.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/exceptions.o.d 
	@${RM} ${OBJECTDIR}/exceptions.o 
	@${FIXDEPS} "${OBJECTDIR}/exceptions.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/exceptions.o.d" -o ${OBJECTDIR}/exceptions.o exceptions.c   
	
${OBJECTDIR}/interrupts.o: interrupts.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/interrupts.o.d 
	@${RM} ${OBJECTDIR}/interrupts.o 
	@${FIXDEPS} "${OBJECTDIR}/interrupts.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/interrupts.o.d" -o ${OBJECTDIR}/interrupts.o interrupts.c   
	
${OBJECTDIR}/system.o: system.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/system.o.d 
	@${RM} ${OBJECTDIR}/system.o 
	@${FIXDEPS} "${OBJECTDIR}/system.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/system.o.d" -o ${OBJECTDIR}/system.o system.c   
	
${OBJECTDIR}/user.o: user.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/user.o.d 
	@${RM} ${OBJECTDIR}/user.o 
	@${FIXDEPS} "${OBJECTDIR}/user.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/user.o.d" -o ${OBJECTDIR}/user.o user.c   
	
${OBJECTDIR}/TimeDelay.o: TimeDelay.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/TimeDelay.o.d 
	@${RM} ${OBJECTDIR}/TimeDelay.o 
	@${FIXDEPS} "${OBJECTDIR}/TimeDelay.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/TimeDelay.o.d" -o ${OBJECTDIR}/TimeDelay.o TimeDelay.c   
	
${OBJECTDIR}/Beep.o: Beep.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/Beep.o.d 
	@${RM} ${OBJECTDIR}/Beep.o 
	@${FIXDEPS} "${OBJECTDIR}/Beep.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/Beep.o.d" -o ${OBJECTDIR}/Beep.o Beep.c   
	
${OBJECTDIR}/CustomControlDemo.o: CustomControlDemo.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/CustomControlDemo.o.d 
	@${RM} ${OBJECTDIR}/CustomControlDemo.o 
	@${FIXDEPS} "${OBJECTDIR}/CustomControlDemo.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/CustomControlDemo.o.d" -o ${OBJECTDIR}/CustomControlDemo.o CustomControlDemo.c   
	
${OBJECTDIR}/TouchScreen.o: TouchScreen.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/TouchScreen.o.d 
	@${RM} ${OBJECTDIR}/TouchScreen.o 
	@${FIXDEPS} "${OBJECTDIR}/TouchScreen.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/TouchScreen.o.d" -o ${OBJECTDIR}/TouchScreen.o TouchScreen.c   
	
${OBJECTDIR}/drv_spi.o: drv_spi.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/drv_spi.o.d 
	@${RM} ${OBJECTDIR}/drv_spi.o 
	@${FIXDEPS} "${OBJECTDIR}/drv_spi.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/drv_spi.o.d" -o ${OBJECTDIR}/drv_spi.o drv_spi.c   
	
${OBJECTDIR}/rtcc.o: rtcc.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/rtcc.o.d 
	@${RM} ${OBJECTDIR}/rtcc.o 
	@${FIXDEPS} "${OBJECTDIR}/rtcc.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/rtcc.o.d" -o ${OBJECTDIR}/rtcc.o rtcc.c   
	
${OBJECTDIR}/InternalResourceXC32.o: InternalResourceXC32.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/InternalResourceXC32.o.d 
	@${RM} ${OBJECTDIR}/InternalResourceXC32.o 
	@${FIXDEPS} "${OBJECTDIR}/InternalResourceXC32.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/InternalResourceXC32.o.d" -o ${OBJECTDIR}/InternalResourceXC32.o InternalResourceXC32.c   
	
${OBJECTDIR}/cpld.o: cpld.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/cpld.o.d 
	@${RM} ${OBJECTDIR}/cpld.o 
	@${FIXDEPS} "${OBJECTDIR}/cpld.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/cpld.o.d" -o ${OBJECTDIR}/cpld.o cpld.c   
	
${OBJECTDIR}/TouchScreenResistive.o: TouchScreenResistive.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/TouchScreenResistive.o.d 
	@${RM} ${OBJECTDIR}/TouchScreenResistive.o 
	@${FIXDEPS} "${OBJECTDIR}/TouchScreenResistive.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/TouchScreenResistive.o.d" -o ${OBJECTDIR}/TouchScreenResistive.o TouchScreenResistive.c   
	
${OBJECTDIR}/MainDemo.o: MainDemo.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/MainDemo.o.d 
	@${RM} ${OBJECTDIR}/MainDemo.o 
	@${FIXDEPS} "${OBJECTDIR}/MainDemo.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/MainDemo.o.d" -o ${OBJECTDIR}/MainDemo.o MainDemo.c   
	
${OBJECTDIR}/SST25VF016.o: SST25VF016.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/SST25VF016.o.d 
	@${RM} ${OBJECTDIR}/SST25VF016.o 
	@${FIXDEPS} "${OBJECTDIR}/SST25VF016.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/SST25VF016.o.d" -o ${OBJECTDIR}/SST25VF016.o SST25VF016.c   
	
else
${OBJECTDIR}/graphics/drivers/ILI9341.o: graphics/drivers/ILI9341.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics/drivers 
	@${RM} ${OBJECTDIR}/graphics/drivers/ILI9341.o.d 
	@${RM} ${OBJECTDIR}/graphics/drivers/ILI9341.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/drivers/ILI9341.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/drivers/ILI9341.o.d" -o ${OBJECTDIR}/graphics/drivers/ILI9341.o graphics/drivers/ILI9341.c   
	
${OBJECTDIR}/graphics/AnalogClock.o: graphics/AnalogClock.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/AnalogClock.o.d 
	@${RM} ${OBJECTDIR}/graphics/AnalogClock.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/AnalogClock.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/AnalogClock.o.d" -o ${OBJECTDIR}/graphics/AnalogClock.o graphics/AnalogClock.c   
	
${OBJECTDIR}/graphics/Button.o: graphics/Button.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Button.o.d 
	@${RM} ${OBJECTDIR}/graphics/Button.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Button.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Button.o.d" -o ${OBJECTDIR}/graphics/Button.o graphics/Button.c   
	
${OBJECTDIR}/graphics/Chart.o: graphics/Chart.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Chart.o.d 
	@${RM} ${OBJECTDIR}/graphics/Chart.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Chart.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Chart.o.d" -o ${OBJECTDIR}/graphics/Chart.o graphics/Chart.c   
	
${OBJECTDIR}/graphics/CheckBox.o: graphics/CheckBox.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/CheckBox.o.d 
	@${RM} ${OBJECTDIR}/graphics/CheckBox.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/CheckBox.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/CheckBox.o.d" -o ${OBJECTDIR}/graphics/CheckBox.o graphics/CheckBox.c   
	
${OBJECTDIR}/graphics/DigitalMeter.o: graphics/DigitalMeter.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/DigitalMeter.o.d 
	@${RM} ${OBJECTDIR}/graphics/DigitalMeter.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/DigitalMeter.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/DigitalMeter.o.d" -o ${OBJECTDIR}/graphics/DigitalMeter.o graphics/DigitalMeter.c   
	
${OBJECTDIR}/graphics/EditBox.o: graphics/EditBox.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/EditBox.o.d 
	@${RM} ${OBJECTDIR}/graphics/EditBox.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/EditBox.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/EditBox.o.d" -o ${OBJECTDIR}/graphics/EditBox.o graphics/EditBox.c   
	
${OBJECTDIR}/graphics/GOL.o: graphics/GOL.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/GOL.o.d 
	@${RM} ${OBJECTDIR}/graphics/GOL.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/GOL.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/GOL.o.d" -o ${OBJECTDIR}/graphics/GOL.o graphics/GOL.c   
	
${OBJECTDIR}/graphics/GOLSchemeDefault.o: graphics/GOLSchemeDefault.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/GOLSchemeDefault.o.d 
	@${RM} ${OBJECTDIR}/graphics/GOLSchemeDefault.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/GOLSchemeDefault.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/GOLSchemeDefault.o.d" -o ${OBJECTDIR}/graphics/GOLSchemeDefault.o graphics/GOLSchemeDefault.c   
	
${OBJECTDIR}/graphics/Grid.o: graphics/Grid.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Grid.o.d 
	@${RM} ${OBJECTDIR}/graphics/Grid.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Grid.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Grid.o.d" -o ${OBJECTDIR}/graphics/Grid.o graphics/Grid.c   
	
${OBJECTDIR}/graphics/GroupBox.o: graphics/GroupBox.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/GroupBox.o.d 
	@${RM} ${OBJECTDIR}/graphics/GroupBox.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/GroupBox.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/GroupBox.o.d" -o ${OBJECTDIR}/graphics/GroupBox.o graphics/GroupBox.c   
	
${OBJECTDIR}/graphics/ListBox.o: graphics/ListBox.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/ListBox.o.d 
	@${RM} ${OBJECTDIR}/graphics/ListBox.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/ListBox.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/ListBox.o.d" -o ${OBJECTDIR}/graphics/ListBox.o graphics/ListBox.c   
	
${OBJECTDIR}/graphics/Meter.o: graphics/Meter.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Meter.o.d 
	@${RM} ${OBJECTDIR}/graphics/Meter.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Meter.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Meter.o.d" -o ${OBJECTDIR}/graphics/Meter.o graphics/Meter.c   
	
${OBJECTDIR}/graphics/Palette.o: graphics/Palette.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Palette.o.d 
	@${RM} ${OBJECTDIR}/graphics/Palette.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Palette.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Palette.o.d" -o ${OBJECTDIR}/graphics/Palette.o graphics/Palette.c   
	
${OBJECTDIR}/graphics/Picture.o: graphics/Picture.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Picture.o.d 
	@${RM} ${OBJECTDIR}/graphics/Picture.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Picture.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Picture.o.d" -o ${OBJECTDIR}/graphics/Picture.o graphics/Picture.c   
	
${OBJECTDIR}/graphics/Primitive.o: graphics/Primitive.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Primitive.o.d 
	@${RM} ${OBJECTDIR}/graphics/Primitive.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Primitive.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Primitive.o.d" -o ${OBJECTDIR}/graphics/Primitive.o graphics/Primitive.c   
	
${OBJECTDIR}/graphics/ProgressBar.o: graphics/ProgressBar.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/ProgressBar.o.d 
	@${RM} ${OBJECTDIR}/graphics/ProgressBar.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/ProgressBar.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/ProgressBar.o.d" -o ${OBJECTDIR}/graphics/ProgressBar.o graphics/ProgressBar.c   
	
${OBJECTDIR}/graphics/RadioButton.o: graphics/RadioButton.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/RadioButton.o.d 
	@${RM} ${OBJECTDIR}/graphics/RadioButton.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/RadioButton.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/RadioButton.o.d" -o ${OBJECTDIR}/graphics/RadioButton.o graphics/RadioButton.c   
	
${OBJECTDIR}/graphics/RoundDial.o: graphics/RoundDial.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/RoundDial.o.d 
	@${RM} ${OBJECTDIR}/graphics/RoundDial.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/RoundDial.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/RoundDial.o.d" -o ${OBJECTDIR}/graphics/RoundDial.o graphics/RoundDial.c   
	
${OBJECTDIR}/graphics/Slider.o: graphics/Slider.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Slider.o.d 
	@${RM} ${OBJECTDIR}/graphics/Slider.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Slider.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Slider.o.d" -o ${OBJECTDIR}/graphics/Slider.o graphics/Slider.c   
	
${OBJECTDIR}/graphics/StaticText.o: graphics/StaticText.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/StaticText.o.d 
	@${RM} ${OBJECTDIR}/graphics/StaticText.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/StaticText.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/StaticText.o.d" -o ${OBJECTDIR}/graphics/StaticText.o graphics/StaticText.c   
	
${OBJECTDIR}/graphics/Template.o: graphics/Template.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Template.o.d 
	@${RM} ${OBJECTDIR}/graphics/Template.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Template.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Template.o.d" -o ${OBJECTDIR}/graphics/Template.o graphics/Template.c   
	
${OBJECTDIR}/graphics/TextEntry.o: graphics/TextEntry.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/TextEntry.o.d 
	@${RM} ${OBJECTDIR}/graphics/TextEntry.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/TextEntry.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/TextEntry.o.d" -o ${OBJECTDIR}/graphics/TextEntry.o graphics/TextEntry.c   
	
${OBJECTDIR}/graphics/Transitions.o: graphics/Transitions.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Transitions.o.d 
	@${RM} ${OBJECTDIR}/graphics/Transitions.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Transitions.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Transitions.o.d" -o ${OBJECTDIR}/graphics/Transitions.o graphics/Transitions.c   
	
${OBJECTDIR}/graphics/Transitions_weak.o: graphics/Transitions_weak.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Transitions_weak.o.d 
	@${RM} ${OBJECTDIR}/graphics/Transitions_weak.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Transitions_weak.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Transitions_weak.o.d" -o ${OBJECTDIR}/graphics/Transitions_weak.o graphics/Transitions_weak.c   
	
${OBJECTDIR}/graphics/Window.o: graphics/Window.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/graphics 
	@${RM} ${OBJECTDIR}/graphics/Window.o.d 
	@${RM} ${OBJECTDIR}/graphics/Window.o 
	@${FIXDEPS} "${OBJECTDIR}/graphics/Window.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/graphics/Window.o.d" -o ${OBJECTDIR}/graphics/Window.o graphics/Window.c   
	
${OBJECTDIR}/configuration_bits.o: configuration_bits.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/configuration_bits.o.d 
	@${RM} ${OBJECTDIR}/configuration_bits.o 
	@${FIXDEPS} "${OBJECTDIR}/configuration_bits.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/configuration_bits.o.d" -o ${OBJECTDIR}/configuration_bits.o configuration_bits.c   
	
${OBJECTDIR}/exceptions.o: exceptions.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/exceptions.o.d 
	@${RM} ${OBJECTDIR}/exceptions.o 
	@${FIXDEPS} "${OBJECTDIR}/exceptions.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/exceptions.o.d" -o ${OBJECTDIR}/exceptions.o exceptions.c   
	
${OBJECTDIR}/interrupts.o: interrupts.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/interrupts.o.d 
	@${RM} ${OBJECTDIR}/interrupts.o 
	@${FIXDEPS} "${OBJECTDIR}/interrupts.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/interrupts.o.d" -o ${OBJECTDIR}/interrupts.o interrupts.c   
	
${OBJECTDIR}/system.o: system.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/system.o.d 
	@${RM} ${OBJECTDIR}/system.o 
	@${FIXDEPS} "${OBJECTDIR}/system.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/system.o.d" -o ${OBJECTDIR}/system.o system.c   
	
${OBJECTDIR}/user.o: user.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/user.o.d 
	@${RM} ${OBJECTDIR}/user.o 
	@${FIXDEPS} "${OBJECTDIR}/user.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/user.o.d" -o ${OBJECTDIR}/user.o user.c   
	
${OBJECTDIR}/TimeDelay.o: TimeDelay.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/TimeDelay.o.d 
	@${RM} ${OBJECTDIR}/TimeDelay.o 
	@${FIXDEPS} "${OBJECTDIR}/TimeDelay.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/TimeDelay.o.d" -o ${OBJECTDIR}/TimeDelay.o TimeDelay.c   
	
${OBJECTDIR}/Beep.o: Beep.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/Beep.o.d 
	@${RM} ${OBJECTDIR}/Beep.o 
	@${FIXDEPS} "${OBJECTDIR}/Beep.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/Beep.o.d" -o ${OBJECTDIR}/Beep.o Beep.c   
	
${OBJECTDIR}/CustomControlDemo.o: CustomControlDemo.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/CustomControlDemo.o.d 
	@${RM} ${OBJECTDIR}/CustomControlDemo.o 
	@${FIXDEPS} "${OBJECTDIR}/CustomControlDemo.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/CustomControlDemo.o.d" -o ${OBJECTDIR}/CustomControlDemo.o CustomControlDemo.c   
	
${OBJECTDIR}/TouchScreen.o: TouchScreen.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/TouchScreen.o.d 
	@${RM} ${OBJECTDIR}/TouchScreen.o 
	@${FIXDEPS} "${OBJECTDIR}/TouchScreen.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/TouchScreen.o.d" -o ${OBJECTDIR}/TouchScreen.o TouchScreen.c   
	
${OBJECTDIR}/drv_spi.o: drv_spi.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/drv_spi.o.d 
	@${RM} ${OBJECTDIR}/drv_spi.o 
	@${FIXDEPS} "${OBJECTDIR}/drv_spi.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/drv_spi.o.d" -o ${OBJECTDIR}/drv_spi.o drv_spi.c   
	
${OBJECTDIR}/rtcc.o: rtcc.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/rtcc.o.d 
	@${RM} ${OBJECTDIR}/rtcc.o 
	@${FIXDEPS} "${OBJECTDIR}/rtcc.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/rtcc.o.d" -o ${OBJECTDIR}/rtcc.o rtcc.c   
	
${OBJECTDIR}/InternalResourceXC32.o: InternalResourceXC32.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/InternalResourceXC32.o.d 
	@${RM} ${OBJECTDIR}/InternalResourceXC32.o 
	@${FIXDEPS} "${OBJECTDIR}/InternalResourceXC32.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/InternalResourceXC32.o.d" -o ${OBJECTDIR}/InternalResourceXC32.o InternalResourceXC32.c   
	
${OBJECTDIR}/cpld.o: cpld.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/cpld.o.d 
	@${RM} ${OBJECTDIR}/cpld.o 
	@${FIXDEPS} "${OBJECTDIR}/cpld.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/cpld.o.d" -o ${OBJECTDIR}/cpld.o cpld.c   
	
${OBJECTDIR}/TouchScreenResistive.o: TouchScreenResistive.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/TouchScreenResistive.o.d 
	@${RM} ${OBJECTDIR}/TouchScreenResistive.o 
	@${FIXDEPS} "${OBJECTDIR}/TouchScreenResistive.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/TouchScreenResistive.o.d" -o ${OBJECTDIR}/TouchScreenResistive.o TouchScreenResistive.c   
	
${OBJECTDIR}/MainDemo.o: MainDemo.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/MainDemo.o.d 
	@${RM} ${OBJECTDIR}/MainDemo.o 
	@${FIXDEPS} "${OBJECTDIR}/MainDemo.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/MainDemo.o.d" -o ${OBJECTDIR}/MainDemo.o MainDemo.c   
	
${OBJECTDIR}/SST25VF016.o: SST25VF016.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/SST25VF016.o.d 
	@${RM} ${OBJECTDIR}/SST25VF016.o 
	@${FIXDEPS} "${OBJECTDIR}/SST25VF016.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/SST25VF016.o.d" -o ${OBJECTDIR}/SST25VF016.o SST25VF016.c   
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/Mikroe_Graphics_Test.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mdebugger -D__MPLAB_DEBUGGER_PK3=1 -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/Mikroe_Graphics_Test.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,--defsym=_min_heap_size=2000,--defsym=_min_stack_size=1024,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/Mikroe_Graphics_Test.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/Mikroe_Graphics_Test.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=_min_heap_size=2000,--defsym=_min_stack_size=1024,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"
	${MP_CC_DIR}\\xc32-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/Mikroe_Graphics_Test.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/C32_PIC32MX460F512L
	${RM} -r dist/C32_PIC32MX460F512L

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif

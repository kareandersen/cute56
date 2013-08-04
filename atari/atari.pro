QT	-= gui

TARGET	= atari
TEMPLATE= lib

DEFINES	+= \
    HOST \
    ATARI_LIBRARY

win32:QMAKE_CFLAGS += /TP
else:QMAKE_CFLAGS += -std=c99

SOURCES	+= \
	atari.c \
	dsp.c

HEADERS += \
	atari.h \
	dsp.h \
	graphics.h \
	atari_internal.h \
	dsp_internal.h \
    atari_global.h

DSP_SOURCES = \
	calc.asm

win32 {
	ASM56000 = C:\Users\miroslavk\bin\asm56000.exe
	LOD2P56	 = C:\Users\miroslavk\bin\lod2p56.exe
	CLDLOD	 = C:\Users\miroslavk\bin\cldlod.exe
}
else {
	ASM56000 = wine ~/bin-dos/asm56000.exe
	CLDLOD	 = wine ~/bin-dos/cldlod.exe
	LOD2P56	 = ~/bin/lod2p56
}

asm56000.output	= ${QMAKE_FILE_BASE}.p56
asm56000.commands = $${ASM56000} -a -l -b -i${QMAKE_FILE_IN_PATH} ${QMAKE_FILE_IN} && $${CLDLOD} ${QMAKE_FILE_BASE}.cld > ${QMAKE_FILE_BASE}.lod && "$${LOD2P56}" ${QMAKE_FILE_BASE}.lod
asm56000.input	= DSP_SOURCES
asm56000.clean	= ${QMAKE_FILE_BASE}.cld ${QMAKE_FILE_BASE}.lst ${QMAKE_FILE_BASE}.lod ${QMAKE_FILE_BASE}.p56
asm56000.CONFIG	= no_link target_predeps

QMAKE_EXTRA_COMPILERS += asm56000

OTHER_FILES += \
    calc.asm

# qmake project file for building the EmfEngine libraries

include( ../config.pri )


CONFIG(debug, debug|release): TARGET = EmfEngined
CONFIG(release, debug|release): TARGET = EmfEngine
TEMPLATE     = lib

MOC_DIR      = ../tmp
OBJECTS_DIR  = ../tmp
DESTDIR      = ../

QT += widgets

contains(CONFIG, EmfEngineDll) {
    CONFIG  += dll
    DEFINES += EMFENGINE_DLL EMFENGINE_DLL_BUILD
} else {
    CONFIG  += staticlib
}

HEADERS = EmfEngine.h

SOURCES += EmfEngine.cpp 
SOURCES += EmfPaintDevice.cpp

win32: LIBS += -lgdi32
unix:  LIBS += /usr/local/lib/libEMF.a
unix:  INCLUDEPATH += /usr/local/include/libEMF
unix:  INCLUDEPATH += /usr/local/include

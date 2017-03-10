set(SOURCES
    EmfEngine.cpp
    EmfPaintDevice.cpp
)
foreach(file ${SOURCES})
    set(EMFENGINE_SRCS
        ${EMFENGINE_SRCS}
        ${CMAKE_CURRENT_SOURCE_DIR}/${file}
        PARENT_SCOPE)
endforeach()

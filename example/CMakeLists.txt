set(SOURCES
    main.cpp
    renderarea.cpp)
foreach(file ${SOURCES})
    set(EXAMPLE_SRCS 
        ${EXAMPLE_SRCS} 
        ${CMAKE_CURRENT_SOURCE_DIR}/${file} 
        PARENT_SCOPE)
endforeach()

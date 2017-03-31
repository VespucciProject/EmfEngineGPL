cmake_minimum_required(VERSION 3.0.0)
project (emfengine CXX)
option(BUILD_EXAMPLE "Build the example program" OFF)
option(BUILD_SHARED_LIBS "Build shared libraries" ON)

set(SUBDIRS
    src
    example)
foreach(dir ${SUBDIRS})
    add_subdirectory(${dir})
endforeach()

#find libemf if this isn't a Windows system
if(NOT WIN32)
    find_path(LIBEMF_INCLUDE_DIR 
        NAMES emf.h
        PATHS /usr/local/include /usr/include
    )
    set(EMFENGINE_INCLUDE_DIRS ${LIBEMF_INCLUDE_DIR} ${LIBEMF_INCLUDE_DIR}/wine)
    find_library(LIBEMF_LIBRARY
        NAMES libEMF.a libEMF
        PATHS /usr/local/lib /usr/lib64 /usr/lib /usr/local/lib64 /usr/local/
    )
    set(EMFENGINE_LIBRARIES ${EMFENGINE_LIBRARIES} ${LIBEMF_LIBRARY})
else()
    set(EMFENGINE_LIBRARIES gdi32)
endif()

#find Qt
find_package(Qt5 
    COMPONENTS
     Core
     Gui
     Svg
     Widgets
     PrintSupport
     REQUIRED
)

set(EMFENGINE_INCLUDE_DIRS ${EMFENGINE_INCLUDE_DIRS} 
    ${Qt5Core_INCLUDE_DIRS}
    ${Qt5Gui_INCLUDE_DIRS}
    ${Qt5Svg_INCLUDE_DIRS}
    ${Qt5Widgets_INCLUDE_DIRS}
    ${Qt5PrintSupport_INCLUDE_DIRS})
set(EMFENGINE_LIBRARIES ${EMFENGINE_LIBRARIES} 
    ${Qt5Core_LIBRARIES}
    ${Qt5Gui_LIBRARIES}
    ${Qt5Svg_LIBRARES}
    ${Qt5Widgets_LIBRARIES}
    ${Qt5PrintSupport_LIBRARIES})
include_directories(${EMFENGINE_INCLUDE_DIRS})
   
if (WIN32)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
else ()
  # If not on Windows, put them under more standard UNIX-like places.  This is
  # necessary, otherwise they would all end up in
  # ${CMAKE_BINARY_DIR}/src/mlpack/methods/... or somewhere else random like
  # that.
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib/)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib/)
endif ()
add_library(EmfEngine ${EMFENGINE_SRCS})
if(BUILD_EXAMPLE)
    add_executable(example ${EXAMPLE_SRCS})
    target_link_libraries(example
        ${EMFENGINE_LIBRARIES}
        emfengine)
endif()
target_link_libraries(EmfEngine
    ${EMFENGINE_LIBRARIES})
install(FILES src/EmfEngine.h DESTINATION include)
install(TARGETS EmfEngine LIBRARY DESTINATION lib ARCHIVE DESTINATION lib)

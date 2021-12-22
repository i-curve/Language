cmake_minimum_required(VERSION 3.0)

project(cmake)

aux_source_directory(src SOURCE)
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
set(CMAKE_EXE_LINKER_FLAGS "-static -static-libstdc++")

if (MSVC)
    add_compile_options("/std:c++20")
    add_compile_options("/source-charset:utf-8")
    add_compile_options("/execution-charset:gbk")
elseif (MINGW)
    add_compile_options(-std=c++2a -finput-charset=utf-8 -fexec-charset=gbk)
elseif (UNIX)
    add_compile_options(-std=c++20)
endif()

add_executable(cmake ${source})

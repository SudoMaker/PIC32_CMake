cmake_minimum_required(VERSION 3.19)
project(PIC32_CMake C CXX ASM)

set(CMAKE_CXX_STANDARD 17)

set(PIC32_TOOLCHAIN_SEARCH_PATH /opt/pic32-toolchain/)
include(CMake/FindPIC32Toolchain.cmake)

add_compile_options(-march=m4k -EL -msoft-float -membedded-data)

function(pic32_use_processor PROC)
    message("-- PIC32: Using processor: ${PROC}")

    add_definitions(-D__${PROC}__)
    add_link_options(-march=m4k -EL -msoft-float -membedded-data
            -T${CMAKE_CURRENT_SOURCE_DIR}/libPIC32/proc/${PROC}/procdefs.ld
            -T${CMAKE_CURRENT_SOURCE_DIR}/libPIC32/linker/elf32pic32mx.ld
            )

    include_directories(libPIC32)

    set(libPIC32_SOURCES
            libPIC32/startup/crt0.S
            libPIC32/startup/general-exception.S
            libPIC32/support/interrupt/interrupt.S
            libPIC32/support/interrupt/interrupt.c
            libPIC32/proc/${PROC}/p${PROC}.S
            )

    add_library(PIC32 ${libPIC32_SOURCES})
endfunction()


pic32_use_processor(32MX795F512L)

add_executable(${PROJECT_NAME}.elf main.c)
target_link_libraries(${PROJECT_NAME}.elf PIC32)

add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND ${PIC32_TOOLCHAIN_SIZE} ${PROJECT_NAME}.elf)

set(HEX_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.hex)

add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND ${PIC32_TOOLCHAIN_BIN2HEX} ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.elf
        COMMENT "Building iHEX file: ${HEX_FILE}")



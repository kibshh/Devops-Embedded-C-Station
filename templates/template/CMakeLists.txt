cmake_minimum_required(VERSION 3.15)
project(embedded_project C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

option(TARGET_ARM "Build for ARM target" OFF)
option(DEBUG "Debug build" OFF)

if(TARGET_ARM)
    set(CMAKE_SYSTEM_NAME Generic)
    set(CMAKE_C_COMPILER arm-none-eabi-gcc)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16")
    if(NOT DEBUG)
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Os -ffunction-sections -fdata-sections")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
        if(EXISTS "${CMAKE_SOURCE_DIR}/linker_script.ld")
            set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T linker_script.ld")
        endif()
    endif()
    set(CMAKE_EXECUTABLE_SUFFIX ".elf")
else()
    if(DEBUG)
        set(CMAKE_BUILD_TYPE Debug)
    else()
        set(CMAKE_BUILD_TYPE Release)
    endif()
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra")

if(DEBUG)
    add_definitions(-DDEBUG)
else()
    add_definitions(-DNDEBUG)
endif()

# Customize your build here
file(GLOB SOURCES "src/*.c")
add_executable(${PROJECT_NAME} ${SOURCES})
target_include_directories(${PROJECT_NAME} PRIVATE include)

# Enable testing
enable_testing()

# Add tests - customize test directory/files as needed
# Example: file(GLOB_RECURSE TEST_SOURCES "tests/*.c" "unit_tests/*.c")
# Or specify directly: set(TEST_SOURCES "my_tests/test1.c" "my_tests/test2.c")
file(GLOB_RECURSE TEST_SOURCES "tests/*.c")
if(TEST_SOURCES)
    add_executable(test_runner ${TEST_SOURCES} ${SOURCES})
    target_include_directories(test_runner PRIVATE include src)
    if(TARGET_ARM)
        # For ARM, tests are built but may need simulator/hardware to run
        add_test(NAME unit_tests COMMAND test_runner)
    else()
        add_test(NAME unit_tests COMMAND test_runner)
    endif()
endif()

cmake_minimum_required(VERSION 3.16)
project(COS_Quotes ASM_NASM)

if(UNIX)
    set(CMAKE_ASM_NASM_FLAGS "-f elf64")
else()
    set(CMAKE_ASM_NASM_FLAGS "-f win64")
endif()

include(cmake/options.cmake)

if(SHARED_BUILD)
    include(cmake/shared.cmake)
else()
    include(cmake/static.cmake)
endif()

if(BUILD_TESTS)
    include(CheckLanguage)
    check_language(C)

    if(CMAKE_C_COMPILER)
        enable_language(C)
        include(cmake/tests.cmake)
    endif()
    
endif()

if(WIN32)
    target_link_libraries(cos_quotes PRIVATE kernel32)
endif()

target_include_directories(cos_quotes PUBLIC
    include
)
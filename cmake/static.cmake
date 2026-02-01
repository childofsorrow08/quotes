if(LINUX)
    add_library(cos_quotes STATIC
        src/print_random_quote_linux.asm
        src/quotes.asm
    )
elseif(WIN32)
    add_library(cos_quotes STATIC
        src/print_random_quote_windows.asm
        src/quotes.asm
    )
else()
    message(FATAL_ERROR "You can't compile this on non-Windows or non-Linux operating system")
endif()
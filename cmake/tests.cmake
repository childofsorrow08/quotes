add_executable(cosq_tests
    tests/main.c
)

target_link_libraries(cosq_tests
    cos_quotes
)
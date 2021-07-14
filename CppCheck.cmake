option(TOOLS_ENABLE_CPPCHECK
       "Enable static analysis with cppcheck"
       FALSE)

set(TOOLS_CPPCHECK_OPTIONS
    --enable=all
    --inconclusive
    --force
    --quiet
    --inline-suppr
    --suppressions-list=${CMAKE_SOURCE_DIR}/suppressions.txt
    CACHE STRING "Options passed to the cppcheck" FORCE)

if(TOOLS_ENABLE_CPPCHECK)
    find_program(CPPCHECK cppcheck)
    if(CPPCHECK)
        log_option_enabled("cppcheck")
        set(CMAKE_CXX_CPPCHECK ${CPPCHECK} ${TOOLS_CPPCHECK_OPTIONS})
    else()
        log_program_missing("cppcheck")
    endif()
else()
    log_option_disabled("cppcheck")
endif()

# === BUILD TYPE ===
set_property(CACHE CMAKE_BUILD_TYPE
             PROPERTY STRINGS "Debug"
                              "Release"
                              "RelWithDebInfo")
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    log_war("No build type specified, setting to RelWithDebInfo")
    set(CMAKE_BUILD_TYPE
        RelWithDebInfo
        CACHE STRING "Type of build" FORCE)
else()
    log_info("Build type: ${CMAKE_BUILD_TYPE}")
endif()

set(BUILD_SHARED_LIBS OFF)

# === CCACHE ===
option(OPTIONS_ENABLE_CCACHE
       "Enable ccache"
       FALSE)
if(OPTIONS_ENABLE_CCACHE)
    find_program(CCACHE ccache)
    if(CCACHE)
        log_option_enabled("ccache")
        set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE})
    else()
        log_option_disabled("ccache")
    endif()
endif()

macro(configure_doxygen_target)
    set(extra_args ${ARGN})
    list(LENGTH extra_args extra_args_count)
    if(${extra_args_count} EQUAL 0)
        set(doxygen_target_name "docs")
    elseif(${extra_args_count} EQUAL 1)
        list(GET extra_args 0 doxygen_target_name)
    else()
        message(FATAL_ERROR "Invalid usage of configure_doxygen_target")
    endif()

    option(TOOLS_ENABLE_DOXYGEN "Enable automatic documentation generation" FALSE)

    if(TOOLS_ENABLE_DOXYGEN)
        log_option_enabled("doxygen")
        add_custom_target(${doxygen_target_name} ALL
            COMMAND doxygen ${CMAKE_SOURCE_DIR}/Doxyfile
            COMMENT "Generating documentation...")
    else()
        log_option_disabled("doxygen")
    endif()
endmacro()

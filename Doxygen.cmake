option(TOOLS_ENABLE_DOXYGEN "Enable automatic documentation generation" FALSE)

if(TOOLS_ENABLE_DOXYGEN)
    log_option_enabled("doxygen")
    add_custom_target(docs ALL
        COMMAND doxygen ${CMAKE_SOURCE_DIR}/Doxyfile
        COMMENT "Generating documentation...")
else()
    log_option_disabled("doxygen")
    add_custom_target(docs
        COMMAND doxygen ${CMAKE_SOURCE_DIR}/Doxyfile
        COMMENT "Generating documentation...")
endif()


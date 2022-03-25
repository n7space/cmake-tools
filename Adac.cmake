find_program(ARM_ELF_ADAC "${CMAKE_SOURCE_DIR}/adac-hybrid-arm/build/bin/arm-elf-adac")

if(ARM_ELF_ADAC)
    log_option_enabled("adac")

    set(TOP_DIR "${CMAKE_SOURCE_DIR}/adac-hybrid-arm")
    set(UTILS_SRC_DIR ${CMAKE_SOURCE_DIR}/adac-hybrid-arm/test/utils)
    set(BSP_DIR ${CMAKE_SOURCE_DIR}/adac-hybrid-arm/test/bsp)
    set(ADAC ${CMAKE_SOURCE_DIR}/adac-hybrid-arm/build/bin/arm-elf-adac)

    set(COMMON_ADAC_CFLAGS 
            -ffunction-sections;
            -fdata-sections;
            -march=armv7e-m;
            -mcpu=cortex-m7;
            -mfloat-abi=hard;
            -mfpu=fpv5-d16; 
            -mlittle-endian;
            -mthumb )

    set(ADAC_CFLAGS
            ${COMMON_ADAC_CFLAGS};
            -Wall;
            -Wadac,keep_intermediates;
            -Wgnat,-gnatif;
            -Wgnat,-I${TOP_DIR}/build/include;
            -Wgnat,-I${TOP_DIR}/test/utils;
            -Wgnat,--function-sections;
            -I${BSP_DIR}/src;
            -g)
            
    function(adac_compiler sources)

        set(FLAGS ${ADAC_CFLAGS};
        -Wgnat,-I${CMAKE_CURRENT_SOURCE_DIR}/wrappers)

        foreach(source ${ARGV})
            set(OUT ${source}.o)
            set(IN ${source}.adb)
            set(TARGET_NAME ${source}_adac)
            
            add_custom_target(${TARGET_NAME} ALL 
                                ${ADAC} ${FLAGS} -o ${OUT} -c ${CMAKE_CURRENT_SOURCE_DIR}/${IN}
                                COMMENT "adac building ${source}")
        endforeach()

    endfunction()
else()
    log_option_disabled("adac")
endif()
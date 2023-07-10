#
# Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
# Copyright 2022, Capgemini Engineering
#
# SPDX-License-Identifier: GPL-2.0-only
#

cmake_minimum_required(VERSION 3.7.2)

declare_platform(pico-pi-imx8mm KernelPlatformPico-pi-imx8mm PLAT_PICO_PI_IMX8MM KernelArchARM)

if(KernelPlatformPico-pi-imx8mm)
    declare_seL4_arch(aarch64)
    set(KernelArmCortexA53 ON)
    set(KernelArchArmV8a ON)
    set(KernelArmGicV3 ON)
    config_set(KernelARMPlatform ARM_PLAT ${KernelPlatform})
    set(KernelArmMach "imx" CACHE INTERNAL "")
    list(APPEND KernelDTSList "tools/dts/${KernelPlatform}.dts")
    declare_default_headers(
        TIMER_FREQUENCY 8000000
        MAX_IRQ 160
        TIMER drivers/timer/arm_generic.h
        INTERRUPT_CONTROLLER arch/machine/gic_v3.h
        NUM_PPI 32
        CLK_MAGIC 1llu
        CLK_SHIFT 3u
        KERNEL_WCET 10u
    )
endif()

add_sources(
    DEP "KernelPlatformPico-pi-imx8mm"
    CFILES src/arch/arm/machine/gic_v3.c src/arch/arm/machine/l2c_nop.c
)

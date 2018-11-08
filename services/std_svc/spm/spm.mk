#
# Copyright (c) 2017-2018, ARM Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#

ifneq (${SPD},none)
        $(error "Error: SPD and SPM are incompatible build options.")
endif
ifneq (${ARCH},aarch64)
        $(error "Error: SPM is only supported on aarch64.")
endif

include lib/sprt/sprt_host.mk

SPM_SOURCES	:=	$(addprefix services/std_svc/spm/,	\
			${ARCH}/spm_helpers.S			\
			${ARCH}/spm_shim_exceptions.S		\
			sp_setup.c				\
			sp_xlat.c				\
			spci.c					\
			spm_main.c				\
			sprt.c)					\
			${SPRT_LIB_SOURCES}

INCLUDES	+=	${SPRT_LIB_INCLUDES}

# Force SMC Calling Convention 2 when using SPM
SMCCC_MAJOR_VERSION	:=	2

# Let the top-level Makefile know that we intend to include a BL32 image
NEED_BL32		:=	yes

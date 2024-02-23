#
# Copyright (C) 2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/nokia/NB1

# Inherit from common device tree
include device/nokia/msm8998-common/BoardConfigCommon.mk

# Kernel
TARGET_KERNEL_CONFIG := lineageos_NB1_defconfig

# SEPolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

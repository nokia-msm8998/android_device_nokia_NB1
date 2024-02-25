#
# Copyright (C) 2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/nokia/NB1

# Inherit from the common device configuration.
$(call inherit-product, device/nokia/msm8998-common/msm8998-common.mk)

# Keylayout
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/keylayout/goodix_fp.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/goodix_fp.kl

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# Shims
PRODUCT_PACKAGES += \
    libshim_binder \
    libshim_gui

# Ramdisk
PRODUCT_PACKAGES += \
    init.nb1.camera.rc \
    init.nb1.target.rc

# Inherit device specific vendor makefiles
$(call inherit-product, vendor/nokia/NB1/NB1-vendor.mk)

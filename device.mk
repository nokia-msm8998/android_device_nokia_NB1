#
# Copyright (C) 2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/nokia/NLA

# Inherit from the common device configuration.
TARGET_NOKIA_PLATFORM := msm8998
$(call inherit-product, device/nokia/msm8998-common/msm8998-common.mk)

# Audio
PRODUCT_PACKAGES += \
    tinymix.vendor \
    tinyplay.vendor

# Keylayout
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/keylayout/goodix_fp.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/goodix_fp.kl

# Camera
PRODUCT_PACKAGES += \
    libgui_vendor:32

# Hotword Enrollment
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-hotword.xml

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0.vendor \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# NFC
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nci.conf \
    $(DEVICE_PATH)/configs/nfc/libnfc-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay \
    $(DEVICE_PATH)/overlay-lineage

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# Shims
PRODUCT_PACKAGES += \
    libshim_binder \
    libshim_gui \
    libfakelogprint

# Ramdisk
PRODUCT_PACKAGES += \
    init.nb1.camera.rc \
    init.nb1.target.rc \
    init.fih.modemconfig.sh \
    init.fih.smartamp_init.sh \
    init.fih.poweroff_charging.rc \
    fstab.qcom

# Wi-Fi
PRODUCT_PACKAGES += \
    WifiOverlayNB1

# Inherit device specific vendor makefiles
$(call inherit-product, vendor/nokia/NLA/NLA-vendor.mk)

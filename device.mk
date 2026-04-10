#
# SPDX-FileCopyrightText: 2022-2025 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from the common device configuration.
$(call inherit-product, device/nokia/msm8998-common/common.mk)

# A/B
PRODUCT_PACKAGES += check_dynamic_partitions

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_product=true \
    POSTINSTALL_PATH_product=bin/check_dynamic_partitions \
    FILESYSTEM_TYPE_product=ext4 \
    POSTINSTALL_OPTIONAL_product=false

# Camera
PRODUCT_PACKAGES += \
    camera.msm8998 \
    libgui_vendor:32

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_RETROFIT_DYNAMIC_PARTITIONS := true

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/keylayout/goodix_fp.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/goodix_fp.kl

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    fstab.qcom.ramdisk \
    init.nb1.target.rc

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Touch
PRODUCT_PACKAGES += \
    vendor.lineage.touch-service.nb1

# Wi-Fi
PRODUCT_PACKAGES += \
    WifiOverlayNB1

# Inherit device specific vendor makefiles
$(call inherit-product, vendor/nokia/NB1/NB1-vendor.mk)

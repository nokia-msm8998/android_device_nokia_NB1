#
# SPDX-FileCopyrightText: 2022-2025 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/nokia/NB1

# Retrofit
PRODUCT_PACKAGES += check_dynamic_partitions

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_product=true \
    POSTINSTALL_PATH_product=bin/check_dynamic_partitions \
    FILESYSTEM_TYPE_product=ext4 \
    POSTINSTALL_OPTIONAL_product=false

# Inherit from the common device configuration.
$(call inherit-product, device/nokia/msm8998-common/msm8998-common.mk)

# Keylayout
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/keylayout/goodix_fp.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/goodix_fp.kl

# Camera
PRODUCT_PACKAGES += \
    camera.msm8998 \
    libgui_vendor:32

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_RETROFIT_DYNAMIC_PARTITIONS := true

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# Ramdisk
PRODUCT_PACKAGES += \
    init.nb1.camera.rc \
    init.nb1.target.rc

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom \
    $(DEVICE_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.qcom

# Touch
PRODUCT_PACKAGES += \
    vendor.lineage.touch-service.nb1

# Wi-Fi
PRODUCT_PACKAGES += \
    WifiOverlayNB1

# Inherit device specific vendor makefiles
$(call inherit-product, vendor/nokia/NB1/NB1-vendor.mk)

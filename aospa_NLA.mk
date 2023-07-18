# Copyright (C) 2023 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Indicate the first api level the device has been commercially launched on
PRODUCT_SHIPPING_API_LEVEL := 27

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Inherit from NLA device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_NAME := lineage_NLA
PRODUCT_DEVICE := NLA
PRODUCT_MANUFACTURER := HMD Global
PRODUCT_BRAND := Nokia
PRODUCT_MODEL := Nokia 8

PRODUCT_GMS_CLIENTID_BASE := android-hmd-rev2

# Boot animation resolution
TARGET_BOOT_ANIMATION_RES := 1080

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=TA-1004_00WW \
    PRIVATE_BUILD_DESC="TA-1004_00WW-user 8.1.0 OPR1.170623.026 00WW_4_88B release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Nokia/TA-1004_00WW/NB1:8.1.0/OPR1.170623.026/00WW_4_88B:user/release-keys

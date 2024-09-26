#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        # Load sensors.rangefinder.so from /vendor partition
        vendor/lib/libmmcamera2_stats_modules.so)
            [ "$2" = "" ] && return 0
            sed -i -e 's|system/lib64/sensors.rangefinder.so|vendor/lib64/sensors.rangefinder.so|g' "${2}"
            sed -i -e 's|system/lib/sensors.rangefinder.so|vendor/lib/sensors.rangefinder.so|g' "${2}"
            ;;
        # Patch gx_fpd for VNDK support
        vendor/bin/gx_fpd)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --remove-needed "libunwind.so" "${2}"
            "${PATCHELF}" --remove-needed "libbacktrace.so" "${2}"
            "${PATCHELF}" --add-needed "liblog.so" "${2}"
            "${PATCHELF}" --add-needed "libshim_binder.so" "${2}"
            "${PATCHELF_0_17_2}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
            if ! "${PATCHELF_0_17_2}" --print-needed "${2}" | grep "libfakelogprint.so" > /dev/null; then
                "${PATCHELF_0_17_2}" --add-needed "libfakelogprint.so" "${2}"
            fi
            ;;
        vendor/lib64/hw/fingerprint.msm8998.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF_0_17_2}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
            if ! "${PATCHELF_0_17_2}" --print-needed "${2}" | grep "libfakelogprint.so" > /dev/null; then
                "${PATCHELF_0_17_2}" --add-needed "libfakelogprint.so" "${2}"
            fi
            ;;
        vendor/lib64/libfp_client.so|vendor/lib64/libfpjni.so|vendor/lib64/libfpservice.so)
            [ "$2" = "" ] && return 0
	    "${PATCHELF_0_17_2}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
	    ;;
        # Hexedit gxfingerprint to load Goodix firmware from /vendor/firmware/
        vendor/lib64/hw/gxfingerprint.default.so)
            [ "$2" = "" ] && return 0
            sed -i -e 's|/system/etc/firmware|/vendor/firmware\x0\x0\x0\x0|g' "${2}"
            "${PATCHELF_0_17_2}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
            if ! "${PATCHELF_0_17_2}" --print-needed "${2}" | grep "libfakelogprint.so" > /dev/null; then
                "${PATCHELF_0_17_2}" --add-needed "libfakelogprint.so" "${2}"
            fi
	    ;;
        *)
            return 1
            ;;
    esac
    return 0
}

function blob_fixup_dry() {
    blob_fixup "$1" ""
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=NB1
export DEVICE_COMMON=msm8998-common
export VENDOR=nokia
export VENDOR_COMMON=${VENDOR}

"./../../${VENDOR_COMMON}/${DEVICE_COMMON}/extract-files.sh" "$@"

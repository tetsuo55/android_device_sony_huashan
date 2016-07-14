#
# Copyright (C) 2013-2016 The CyanogenMod Project
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
#

# Set the physical display size with PRODUCT_AAPT_CONFIG
# Options are small(~2"-3"), normal(~3"-4"), large(~4"-7"), xlarge(~7" and larger)
PRODUCT_AAPT_CONFIG := normal
# Set the preferred asset density with PRODUCT_AAPT_PREF_CONFIG
# See android CCD for valid options
PRODUCT_AAPT_PREF_CONFIG := xhdpi
# A list of dpis to select prebuilt apk, in precedence order.
# See android CCD for valid options
PRODUCT_AAPT_PREBUILT_DPI := xhdpi 280dpi hdpi tvdpi mdpi ldpi   


# Device specific overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Product common configurations
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Dalvik heap configurations
$(call inherit-product-if-exists, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

# Device product elements
include $(LOCAL_PATH)/product/*.mk

# Vendor product configurations
$(call inherit-product, vendor/sony/huashan/huashan-vendor.mk)

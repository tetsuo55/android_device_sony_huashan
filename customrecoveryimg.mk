LOCAL_PATH := $(call my-dir)

MKELF := device/sony/huashan/tools/mkelf.py
TARGET_PREBUILTS := device/sony/huashan/prebuilts

recovery_uncompressed_twrp_ramdisk := $(PRODUCT_OUT)/ramdisk-twrp.cpio
$(recovery_uncompressed_twrp_ramdisk): $(MKBOOTFS) \
		$(INTERNAL_RECOVERYIMAGE_FILES) \
		$(recovery_initrc) $(recovery_sepolicy) $(recovery_kernel) \
		$(INSTALLED_2NDBOOTLOADER_TARGET) \
		$(recovery_build_prop) $(recovery_resource_deps) $(recovery_root_deps) \
		$(recovery_fstab) \
		$(RECOVERY_INSTALL_OTA_KEYS) \
 		$(INTERNAL_BOOTIMAGE_FILES)
	@echo -e ${PRT_IMG}"----- Making uncompressed recovery ramdisk ------"${CL_RST}
	$(call build-recoveryramdisk)
	@echo -e ${PRT_IMG}"----- Making uncompressed recovery ramdisk ------"${CL_RST}
	$(hide) cp $(TARGET_PREBUILTS)/logo.rle $(TARGET_RECOVERY_ROOT_OUT)/
	$(hide) $(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) > $@

INSTALLED_RECOVERYIMAGE_TARGET := $(PRODUCT_OUT)/recovery.img
$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTFS) \
		$(recovery_uncompressed_twrp_ramdisk) \
		$(recovery_kernel)
	@echo ----- Making recovery image ------
	$(hide) rm -f $(PRODUCT_OUT)/ramdisk-recovery.cpio;
	$(hide) mv $(recovery_uncompressed_twrp_ramdisk) $(PRODUCT_OUT)/ramdisk-recovery.cpio;
	$(hide) $(MINIGZIP) < $(PRODUCT_OUT)/ramdisk-recovery.cpio > $(PRODUCT_OUT)/ramdisk-recovery.img
	$(hide) python $(MKELF) -o $@ $(PRODUCT_OUT)/kernel@0x80208000 $(PRODUCT_OUT)/ramdisk-recovery.img@0x81900000,ramdisk $(TARGET_PREBUILTS)/RPM.bin@0x00020000,rpm device/sony/huashan/rootdir/cmdline.txt@cmdline
	@echo ----- Made recovery image -------- $@

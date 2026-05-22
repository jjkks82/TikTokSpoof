TARGET := iphone:clang:latest:14.0
ARCHS = arm64
INSTALL_TARGET_PROCESSES = TikTok

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TikTokSpoof
TikTokSpoof_FILES = Tweak.x
TikTokSpoof_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

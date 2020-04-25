include $(THEOS)/makefiles/common.mk

export ARCHS = arm64 arm64e
export TARGET = iphone:clang:12.1.2:12.0

BUNDLE_NAME = Snapper2CC
$(BUNDLE_NAME)_BUNDLE_EXTENSION = bundle
$(BUNDLE_NAME)_CFLAGS =  -fobjc-arc
$(BUNDLE_NAME)_PRIVATE_FRAMEWORKS = ControlCenterUIKit Preferences
$(BUNDLE_NAME)_FILES = SnapperCC.xm PrefsRootListController.m
$(BUNDLE_NAME)_INSTALL_PATH = /Library/ControlCenter/Bundles/

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

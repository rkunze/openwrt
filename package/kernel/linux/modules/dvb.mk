#
# Copyright (C) 2018 Richard Kunze <richard.kunze@mailbox.org>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

DVB_MENU:=DVB Support

define KernelPackage/dvb-core
	SUBMENU:=$(DVB_MENU)
	TITLE:=DVB Support
	HIDDEN:=1
	KCONFIG:=CONFIG_DVB_CORE \
                 CONFIG_MEDIA_SUPPORT=m \
                 CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y \
                 CONFIG_DVB_NET=y \
                 CONFIG_DVB_MAX_ADAPTERS=8 \
                 CONFIG_MEDIA_SUBDRV_AUTOSELECT=y 
	FILES:=$(LINUX_DIR)/drivers/media/dvb-core/dvb-core.ko
	AUTOLOAD:=$(call AutoProbe,dvb-core)
endef

define KernelPackage/dvb-core/description
	Kernel module for DVB support.
endef

$(eval $(call KernelPackage,dvb-core))

define KernelPackage/dvb-usb-v2
	SUBMENU:=$(DVB_MENU)
	TITLE:=DVB USB Support
	HIDDEN:=1
	DEPENDS:=+kmod-dvb-core +kmod-usb-core
	KCONFIG:=CONFIG_DVB_USB_V2 \
                 CONFIG_MEDIA_USB_SUPPORT=y
	FILES:=$(LINUX_DIR)/drivers/media/usb/dvb-usb-v2/dvb_usb_v2.ko
	AUTOLOAD:=$(call AutoProbe,dvb-usb-v2)
endef

define KernelPackage/dvb-usb-v2/description
	Kernel module for DVB USB devices support.
endef

$(eval $(call KernelPackage,dvb-usb-v2))

define KernelPackage/dvb-usb-dvbsky
	SUBMENU:=$(DVB_MENU)
	TITLE:=Support for DVBSky USB devices
	DEPENDS:=+kmod-dvb-usb-v2 +kmod-i2c-mux +kmod-regmap
	KCONFIG:=CONFIG_DVB_USB_DVBSKY
	FILES:=$(LINUX_DIR)/drivers/media/usb/dvb-usb-v2/dvb-usb-dvbsky.ko \
               $(LINUX_DIR)/drivers/media/dvb-frontends/m88ds3103.ko \
               $(LINUX_DIR)/drivers/media/dvb-frontends/ts2020.ko \
               $(LINUX_DIR)/drivers/media/dvb-frontends/si2168.ko \
               $(LINUX_DIR)/drivers/media/dvb-frontends/sp2.ko \
               $(LINUX_DIR)/drivers/media/tuners/si2157.ko
	AUTOLOAD:=$(call AutoProbe,dvb-usb-dvbsky)
endef

define KernelPackage/dvb-usb-dvbsky/description
	Kernel module for DVBSky USB devices support.
endef

$(eval $(call KernelPackage,dvb-usb-dvbsky))


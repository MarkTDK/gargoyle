include $(TOPDIR)/rules.mk

PKG_NAME:=plugin_gargoyle_xeye_theme
PKG_VERSION:=$(GARGOYLE_VERSION)
ifeq ($(GARGOYLE_VERSION),)
     PKG_VERSION:=1.0.0
endif
PKG_RELEASE:=1


PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/plugin-gargoyle-xeye-theme
	SECTION:=admin
	CATEGORY:=Administration
	SUBMENU:=Gargoyle Web Interface
	TITLE:=Xeye Theme for Gargoyle
	MAINTAINER:=Eric Bishop <eric@gargoyle-router.com>
	PKGARCH:=all
endef

define Package/plugin-gargoyle-xeye-theme/description
	Xeye Theme for Gargoyle
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/plugin-gargoyle-xeye-theme/install
	$(INSTALL_DIR) $(1)
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,plugin-gargoyle-xeye-theme))
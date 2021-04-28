#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add feed sources
sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
sed -i '$a src-git diy https://github.com/CCnut/feed-netkeeper.git;LUCI-LUA-UCITRACK' feeds.conf.default

# Add luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
rm -rf ../lean/luci-theme-argon

# Svn checkout packages from immortalwrt's repository
pushd customfeeds
mkdir temp
git clone --depth=1 https://github.com/immortalwrt/packages -b openwrt-18.06 temp/packages
git clone --depth=1 https://github.com/immortalwrt/luci -b openwrt-18.06 temp/luci

# Add luci-app-adguardhome
cp -r temp/luci/applications/luci-app-adguardhome luci/applications/luci-app-adguardhome
cp -r temp/packages/net/adguardhome packages/net/adguardhome
cp -r temp/packages/lang/node-yarn packages/lang/node-yarn
cp -r temp/packages/devel/packr packages/devel/packr

# Add luci-app-gowebdav
cp -r temp/luci/applications/luci-app-gowebdav luci/applications/luci-app-gowebdav
cp -r temp/packages/net/gowebdav packages/net/gowebdav

# Add netdata
rm -rf packages/admin/netdata
rm -rf ../package/lean/luci-app-netdata
cp -r temp/luci/applications/luci-app-netdata luci/applications/luci-app-netdata
cp -r temp/packages/admin/netdata packages/admin/netdata

# Add luci-app-smartdns
cp -r temp/luci/applications/luci-app-smartdns luci/applications/luci-app-smartdns
cp -r temp/packages/net/smartdns packages/net/smartdns

# Add tmate
cp -r temp/packages/net/tmate packages/net/tmate
cp -r temp/packages/libs/msgpack-c packages/libs/msgpack-c

# Add gotop
cp -r temp/packages/admin/gotop packages/admin/gotop

# Add minieap
cp -r temp/packages/net/minieap packages/net/minieap
rm -rf temp
popd

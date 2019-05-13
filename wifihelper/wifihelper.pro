QT += core wifi
QT -= gui

CONFIG += c++11

TARGET = wifihelper
CONFIG += console
CONFIG -= app_bundle

TEMPLATE = app

SOURCES += main.cpp

DEFINES += QT_DEPRECATED_WARNINGS

linux-oe-g++ {
    message(Build $$TARGET for Linux on Cross Platform)
    DEFINES +=CONFIG_CROSS_PLATFORM

    target.path += /usr/bin
    INSTALLS += target


    conf.path = /etc
    conf.files = $$PWD/install/wifihelper.conf \
                 $$PWD/install/dnsmasq.conf \
                 $$PWD/install/wpa_supplicant.conf \
                 $$PWD/install/p2p_supplicant.conf
    INSTALLS += conf

    udhcpc.path = /etc/udhcpc.d
    udhcpc.files = $$PWD/install/50default
    INSTALLS += udhcpc

    action.path = /sbin
    action.files = $$PWD/install/dhcpd_action.sh \
                   $$PWD/install/dhcpc_action.sh
    INSTALLS += action

    service.path = /etc/systemd/system
    service.files = $$PWD/install/wifihelper.service \
                    $$PWD/install/wpa.service
    INSTALLS += service

    dbus_conf.path = /etc/dbus-1/system.d/
    dbus_conf.files = $$PWD/install/wifi.helper.service.conf
    INSTALLS += dbus_conf
}

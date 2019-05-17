import QtQuick 2.7
import QtQuick.Controls 2.1
import WiFi 1.0

PageWiFiConnectForm {

    WiFiManager {
        id: wifiManager
        isWiFiEnabled: switchWLAN.checked
        onIsWiFiEnabledChanged: {
            if(wifiManager.isWiFiEnabled) {
                wifiManager.isWiFiAutoScan = true;
            }
        }
    }

    Component.onCompleted: {
        if(wifiManager.isWiFiEnabled) {
            wifiManager.isWiFiAutoScan = true;
        }
    }

    WiFiScanResultModel {
        id: wifiAPModel
    }

    function getSignalLevel(level) {
        if(level == undefined)
            return 0;
        else
            return level
    }

    property var statuDisplays: ["", qsTr("正在连接"), qsTr("已认证"), qsTr("已连接"), qsTr("连接失败")]

    listWLAN.model: WiFiSortFilterModel {
        id: proxyModel
        source: wifiAPModel
        sortRole: "type,rssi"
        sortOrder: Qt.DescendingOrder
    }

    listWLAN.delegate: Rectangle {
        width: listWLAN.width
        height: 80
        color: "#88CCCCCC"
        Row {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20
            Image {
                id: icon
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/res/wifi_level_" + getSignalLevel(signalLevel) + ".png"
            }
            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5
                Text {
                    width: listWLAN.width - icon.width - 10
                    elide: Text.ElideRight
                    color: "#4CAF50"
                    font.pixelSize: 32
                    text: ssid
                }
                Text {
                    color: "#888888"
                    font.pixelSize: 32
                    visible: status != 0
                    text: statuDisplays[status]
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(type == 0) {
                    dialog.bssid = bssid
                    dialog.title = ssid
                    dialog.open()
                }else if(type == 1) {
                    wifiManager.selectNetwork(networkId)
                }
            }
        }
    }

    Dialog {
        id: dialog
        width: parent.width
        height: parent.height
        modal: true
        header: Item {
        }
        background: Item {
        }

        property string bssid

        DialogWifiInput {
            id: wifiInput
            anchors.centerIn: parent
            width: 800
            height: 500
            title: dialog.title
            bssid: dialog.bssid

            onSubmit: {
                dialog.close()
                wifiManager.addNetwork(ssid, password, bssid)
                console.log("Ok clicked", password)
            }
            onCancel: {
                dialog.close()

                console.log("Cancel clicked")
            }
        }
    }

}

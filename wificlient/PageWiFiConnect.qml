import QtQuick 2.7
import WiFi 1.0

PageWiFiConnectForm {

    WiFiManager {
        id: wifiManager
        isWiFiEnabled: switchWLAN.checked
        onIsWiFiEnabledChanged: {
            if(wifiManager.isWiFiEnabled)
                wifiManager.isWiFiAutoScan = true
        }
    }

    WiFiScanResultModel {
        id: wifiAPModel
    }

    listWLAN.model: WiFiSortFilterModel {
        id: proxyModel
        source: wifiAPModel
        sortRole: "type,rssi"
        sortOrder: Qt.DescendingOrder
    }

}

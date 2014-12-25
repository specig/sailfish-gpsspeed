import QtQuick 2.0
import Sailfish.Silica 1.0
import QtPositioning 5.0
import QtSensors 5.0
import gpsspeed 1.0

import "../LocationFormatter.js" as LocationFormater

Page {
    id: page
    property PositionSource positionSource
    property Compass compass
    property GPSDataSource gpsDataSource
    allowedOrientations: Orientation.All



    SatelliteInfoPage {
        id: satelliteInfoPage
        compass: page.compass
        gpsDataSource: page.gpsDataSource
    }

    Timer {
            interval: 100
            repeat: false
            running: true
            onTriggered: {
                pageStack.pushAttached(satelliteInfoPage);
                //gpsDataSource.onSatellitesChanged = satelliteInfoPage.repaintSatellites();
            }
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
            MenuItem {
                text: positionSource.active ? qsTr("Deactivate GPS") : qsTr("Activate GPS")
                onClicked: {
                    if (positionSource.active) {
                        console.log("deactivating GPS");
                        positionSource.stop();
                        gpsDataSource.active = false;
                        console.log("active: " + positionSource.active);
                    } else {
                        console.log("activating GPS");
                        positionSource.start();
                        gpsDataSource.active = true;
                        console.log("active: " + positionSource.active);
                    }
                }
            }
        }

        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("GPS Speed")
            }
            Label {
                text: positionSource.active ? "" : qsTr("GPS inactive")
                visible: settings.showGpsStateApp
                color: positionSource.active ? "" : "#FF0000"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeLarge
            }

            Label {
                text: qsTr("Speed")
                visible: settings.showSpeedApp
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeLarge
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 256
                fontSizeMode: Fit
                text: {
                    if (positionSource.position.speedValid) {
                        if (settings.units == "MET") {
                            if (settings.speedUnit == "SEC") {
                                return LocationFormater.roundToDecimal(positionSource.position.speed, 2)
                            } else {
                                return LocationFormater.roundToDecimal(positionSource.position.speed * 3.6, 2)
                            }
                        } else {
                            if (settings.speedUnit == "SEC") {
                                return LocationFormater.roundToDecimal(positionSource.position.speed * 3.2808399, 2)
                            } else {
                                return LocationFormater.roundToDecimal(positionSource.position.speed * 2.23693629, 2)
                            }
                        }
                    }
                    return "-"
                }
            }
            Label {
                visible: settings.showSpeedApp
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeLarge
                text: {
                    if (positionSource.position.speedValid) {
                        if (settings.units == "MET") {
                            if (settings.speedUnit == "SEC") {
                                return qsTr("m/s")
                            } else {
                                return qsTr("km/h")
                            }
                        } else {
                            if (settings.speedUnit == "SEC") {
                                return qsTr("ft/s")
                            } else {
                                return qsTr("mph")
                            }
                        }
                    }
                }

            }
            InfoField {
                label: qsTr("Movement direction")
                visible: settings.showMovementDirectionApp
                value: isNaN(gpsDataSource.movementDirection) ? "-" : LocationFormater.formatDirection(gpsDataSource.movementDirection)
            }
        }
    }
}



import QtQuick 2.0
import Sailfish.Silica 1.0
import QtPositioning 5.0
import QtSensors 5.0
import gpsspeed 1.0

import "../LocationFormatter.js" as LocationFormater

CoverBackground {
    property PositionSource positionSource
    property Compass compass
    property GPSDataSource gpsDataSource
    Image {
        id: bgimg
        source: "../../images/coverbg.png"
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: sourceSize.height * width / sourceSize.width
    }
    Column {
        id: column
        anchors.top: parent.top
        anchors.topMargin: Theme.paddingMedium
        width: parent.width
        spacing: Theme.paddingLarge
        Label {
            visible: settings.showGpsStateCover
            font.pixelSize: Theme.fontSizeMedium
            color: "#FF0000"
            text: positionSource.active ? "": qsTr("GPS")+" "+qsTr("inactive")
        }

        Label{
            visible: settings.showSpeedCover
            font.pixelSize: Theme.fontSizeHuge
            anchors.horizontalCenter: parent.horizontalCenter
            text: {
                if (positionSource.position.speedValid) {
                    if (settings.units == "MET") {
                        if (settings.speedUnit == "SEC") {
                            return LocationFormater.roundToDecimal(positionSource.position.speed, 2) + "\n" + qsTr("m/s")
                        } else {
                            return LocationFormater.roundToDecimal(positionSource.position.speed * 3.6, 2) + "\n" + qsTr("km/h")
                        }
                    } else {
                        if (settings.speedUnit == "SEC") {
                            return LocationFormater.roundToDecimal(positionSource.position.speed * 3.2808399, 2) + "\n" + qsTr("ft/s")
                        } else {
                            return LocationFormater.roundToDecimal(positionSource.position.speed * 2.23693629, 2) + "\n" + qsTr("mph")
                        }
                    }
                }
                return "-"
            }
        }
        InfoField {
            label: qsTr("Mov.")
            visible: settings.showMovementDirectionCover
            fontpixelSize: Theme.fontSizeMedium
            value: isNaN(gpsDataSource.movementDirection) ? "-" : LocationFormater.formatDirection(gpsDataSource.movementDirection)
        }
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: positionSource.active ? "image://theme/icon-cover-cancel" : "image://theme/icon-cover-play"
            onTriggered: {
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
}



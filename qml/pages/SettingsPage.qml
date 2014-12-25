import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: settingsPage
    function setSpeedUnitComboBoxIndex() {
        if (settings.units === "MET") {
            speedUnitComboBox.currentIndex = settings.speedUnit === "SEC" ? 0 : 1
        } else {
            speedUnitComboBox.currentIndex = settings.speedUnit === "SEC" ? 2 : 3
        }
    }
    SilicaListView {
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Settings")
        }
        model: VisualItemModel {
            ComboBox {
                label: qsTr("Coordinate format")
                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("degree")
                        onClicked: settings.coordinateFormat = "DEG"
                    }
                    MenuItem {
                        text: qsTr("decimal")
                        onClicked: settings.coordinateFormat = "DEC"
                    }
                }
                Component.onCompleted: currentIndex = settings.coordinateFormat === "DEG" ? 0 : 1
            }
            ComboBox {
                label: qsTr("Units")
                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("metric")
                        onClicked: {
                            settings.units = "MET";
                            setSpeedUnitComboBoxIndex();
                        }
                    }
                    MenuItem {
                        text: qsTr("imperial")
                        onClicked: {
                            settings.units = "IMP";
                            setSpeedUnitComboBoxIndex();
                        }
                    }
                }
                Component.onCompleted: currentIndex = settings.units === "MET" ? 0 : 1
            }
            ComboBox {
                id: speedUnitComboBox
                label: qsTr("Speed")
                menu: ContextMenu {
                    MenuItem {
                        visible: settings.units === "MET"
                        text: qsTr("m/s")
                        onClicked: settings.speedUnit = "SEC"
                    }
                    MenuItem {
                        visible: settings.units === "MET"
                        text: qsTr("km/h")
                        onClicked: settings.speedUnit = "HOUR"
                    }
                    MenuItem {
                        visible: settings.units === "IMP"
                        text: qsTr("ft/s")
                        onClicked: settings.speedUnit = "SEC"
                    }
                    MenuItem {
                        visible: settings.units === "IMP"
                        text: qsTr("mph")
                        onClicked: settings.speedUnit = "HOUR"
                    }
                }
                Component.onCompleted: setSpeedUnitComboBoxIndex()
            }
            ComboBox {
                label: qsTr("Language") + "*"
                menu: ContextMenu {
                    MenuItem {
                        text: "Deutsch"
                        onClicked: settings.locale = "de"
                    }
                    MenuItem {
                        text: "English"
                        onClicked: settings.locale = "en"
                    }
                }
                Component.onCompleted: currentIndex = settings.locale === "de" ? 0 : 1
            }

            Label {
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingMedium * 2
                text: qsTr("Update interval")
            }

            Slider {
                minimumValue: 1
                maximumValue: 120
                stepSize: 1
                value: settings.updateInterval
                valueText: value + "s"
                width: parent.width
                onReleased: settings.updateInterval = value
            }

            Rectangle {
                anchors.leftMargin: Theme.paddingMedium
                height: grid.height
                Grid {
                    id: grid
                    width: parent.width
                    columns: 3
                    columnSpacing: 20

                    Rectangle {
                        width: 220
                        height: label.height
                        color: "transparent"
                        Label {
                            id: label
                            anchors.left: parent.left
                            anchors.leftMargin: Theme.paddingLarge
                            text: qsTr("Show") + "..."
                        }
                    }
                    Label {
                        text: qsTr("Appview")
                    }
                    Label {
                        text: qsTr("Cover")
                    }

                    ShowGridRowLabel {
                        text: qsTr("GPS state")
                    }
                    Switch {
                        checked: settings.showGpsStateApp
                        onClicked: settings.showGpsStateApp = checked
                    }
                    Switch {
                        checked: settings.showGpsStateCover
                        onClicked: settings.showGpsStateCover = checked
                    }

                    ShowGridRowLabel {
                        text: qsTr("Speed")
                    }
                    Switch {
                        checked: settings.showSpeedApp
                        onClicked: settings.showSpeedApp = checked
                    }
                    Switch {
                        checked: settings.showSpeedCover
                        onClicked: settings.showSpeedCover = checked
                    }

                    ShowGridRowLabel {
                        text: qsTr("Movement Direction")
                    }
                    Switch {
                        checked: settings.showMovementDirectionApp
                        onClicked: settings.showMovementDirectionApp = checked
                    }
                    Switch {
                        checked: settings.showMovementDirectionCover
                        onClicked: settings.showMovementDirectionCover = checked
                    }
                }
            }

            Text {
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
                text: "*" + qsTr("requires app restart")
            }
        }
    }
}

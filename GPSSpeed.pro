# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-gpsspeed

CONFIG += sailfishapp

SOURCES += \
    src/gpsdatasource.cpp \
    src/qmlsettingswrapper.cpp \
    src/gpsspeedsettings.cpp \
    src/app.cpp \
    src/harbour-gpsspeed.cpp

OTHER_FILES += \
    qml/pages/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/InfoField.qml \
    qml/pages/SettingsPage.qml \
    qml/LocationFormatter.js \
    qml/providers/Providers.qml \
    qml/pages/ShowGridRowLabel.qml \
    qml/pages/AboutPage.qml \
    qml/pages/LicensePage.qml \
    qml/license.js \
    images/coverbg.png \
    locales/de.qm \
    locales/en.qm \
    rpm/harbour-gpsspeed.yaml \
    rpm/harbour-gpsspeed.spec \
    harbour-gpsspeed.desktop \
    qml/harbour-gpsspeed.qml \
    qml/pages/SatelliteInfoPage.qml \
    qml/CircleCalculator.js \
    qml/harbour-gpsspeed.qml

HEADERS += \
    src/gpsdatasource.h \
    src/qmlsettingswrapper.h \
    src/gpsspeedsettings.h \
    src/app.h

QT += positioning

locales.files = \
    locales/de.qm \
    locales/en.qm

locales.path = /usr/share/harbour-gpsspeed/locales

images.files = \
    images/coverbg.png

images.path = /usr/share/harbour-gpsspeed/images

INSTALLS += locales images

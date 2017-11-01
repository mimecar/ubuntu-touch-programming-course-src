TEMPLATE = aux
TARGET = WeatherRecorder

RESOURCES += \
        WeatherRecorder.qrc


QML_FILES += $$files(*.qml,true) \
             $$files(*.js,true)

CONF_FILES +=  WeatherRecorder.apparmor \
               WeatherRecorder.png

AP_TEST_FILES += tests/autopilot/run \
                 $$files(tests/*.py,true)               

OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES} \
               $${AP_TEST_FILES} \
               WeatherRecorder.desktop

#specify where the qml/js files are installed to
qml_files.path = /WeatherRecorder
qml_files.files += $${QML_FILES}

#specify where the config files are installed to
config_files.path = /WeatherRecorder
config_files.files += $${CONF_FILES}

#install the desktop file, a translated version is 
#automatically created in the build directory
desktop_file.path = /WeatherRecorder
desktop_file.files = $$OUT_PWD/WeatherRecorder.desktop
desktop_file.CONFIG += no_check_exist

INSTALLS+=config_files qml_files desktop_file

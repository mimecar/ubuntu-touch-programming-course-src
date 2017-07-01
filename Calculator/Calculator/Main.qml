import QtQuick 2.4
import Ubuntu.Components 1.3


/*!
    \brief MainView with a Label and Button elements.
    */
MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "calculator.mimecar"

    width: units.gu(100)
    height: units.gu(75)

    Page {
        header: PageHeader {
            id: pageHeader
            title: i18n.tr("Calculator")
            StyleHints {
                foregroundColor: UbuntuColors.orange
                backgroundColor: UbuntuColors.porcelain
                dividerColor: UbuntuColors.slate
            }
        }

        Column {
            anchors.top: pageHeader.bottom

            Label {
                text: "Hello World. Look at me, I'm programming in QML"
            }

            Label {
                text: "I am another label"
            }
        }
    }
}

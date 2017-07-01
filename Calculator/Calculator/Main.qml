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

    property real buttonWidth: units.gu(13)
    property real buttonHeight: units.gu(7)

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

        Grid {

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            spacing: 15
            columns: 5

            // First row
            Button {
                text: "7"

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "8"

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "9"

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "DEL"

                font.pointSize: 17
                color: UbuntuColors.red

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "AC"

                font.pointSize: 17
                color: UbuntuColors.red

                width: buttonWidth
                height: buttonHeight
            }

            // Second row
            Button {
                text: "4"

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "5"

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "6"

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "*"

                font.pointSize: 17
                color: UbuntuColors.warmGrey

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "/"

                font.pointSize: 17
                color: UbuntuColors.warmGrey

                width: buttonWidth
                height: buttonHeight
            }

            // Third row
            Button {
                text: "1"

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "2"

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "3"

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "+"

                font.pointSize: 17
                color: UbuntuColors.warmGrey

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "-"

                font.pointSize: 17
                color: UbuntuColors.warmGrey

                width: buttonWidth
                height: buttonHeight
            }

            // Fourth row
            Button {
                text: "0"

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "."

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "EXP"

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "ANS"

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }

            Button {
                text: "="

                font.pointSize: 17
                color: UbuntuColors.graphite

                width: buttonWidth
                height: buttonHeight
            }
        }
    }
}

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

        Grid {

            anchors.bottom: parent.bottom
            spacing: 10
            columns: 5

            // First row
            Button {
                text: "7"
                color: UbuntuColors.graphite
            }

            Button {
                text: "8"
                color: UbuntuColors.graphite
            }

            Button {
                text: "9"
                color: UbuntuColors.graphite
            }

            Button {
                text: "DEL"
                color: UbuntuColors.red
            }

            Button {
                text: "AC"
                color: UbuntuColors.red
            }

            // Second row
            Button {
                text: "4"
                color: UbuntuColors.graphite
            }

            Button {
                text: "5"
                color: UbuntuColors.graphite
            }

            Button {
                text: "6"
                color: UbuntuColors.graphite
            }

            Button {
                text: "*"
                color: UbuntuColors.warmGrey
            }

            Button {
                text: "/"
                color: UbuntuColors.warmGrey
            }

            // Third row
            Button {
                text: "1"
                color: UbuntuColors.graphite
            }

            Button {
                text: "2"
                color: UbuntuColors.graphite
            }

            Button {
                text: "3"
                color: UbuntuColors.graphite
            }

            Button {
                text: "+"
                color: UbuntuColors.warmGrey
            }

            Button {
                text: "-"
                color: UbuntuColors.warmGrey
            }

            // Fourth row
            Button {
                text: "0"
                color: UbuntuColors.graphite
            }

            Button {
                text: "."
                color: UbuntuColors.graphite
            }

            Button {
                text: "EXP"
                color: UbuntuColors.graphite
            }

            Button {
                text: "ANS"
                color: UbuntuColors.graphite
            }

            Button {
                text: "="
                color: UbuntuColors.graphite
            }
        }
    }
}

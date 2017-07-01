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
            }

            Button {
                text: "8"
            }

            Button {
                text: "9"
            }

            Button {
                text: "DEL"
            }

            Button {
                text: "AC"
            }

            // Second row
            Button {
                text: "4"
            }

            Button {
                text: "5"
            }

            Button {
                text: "6"
            }

            Button {
                text: "*"
            }

            Button {
                text: "/"
            }

            // Third row
            Button {
                text: "1"
            }

            Button {
                text: "2"
            }

            Button {
                text: "3"
            }

            Button {
                text: "+"
            }

            Button {
                text: "-"
            }

            // Fourth row
            Button {
                text: "0"
            }

            Button {
                text: "."
            }

            Button {
                text: "EXP"
            }

            Button {
                text: "ANS"
            }

            Button {
                text: "="
            }
        }
    }
}

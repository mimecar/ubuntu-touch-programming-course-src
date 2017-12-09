import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

/* to replace the 'incomplete' QML API U1db with the low-level QtQuick API */
import QtQuick.LocalStorage 2.0
import "Storage.js" as Storage


/* Show a Dialog where the user can choose to delete ALL the saved temperatures values */
Dialog {
    id: dataBaseEraserDialog
    text: "<b>"+i18n.tr("Remove ALL saved Temperatures ?")+ "<br/>"+ i18n.tr("(there is no restore)")+"</b>"

    Rectangle {
        width: 180;
        height: 50
        Item{

            Column{
                spacing: units.gu(1)

                Row{
                    spacing: units.gu(1)

                    /* placeholder */
                    Rectangle {
                        color: "transparent"
                        width: units.gu(3)
                        height: units.gu(3)
                    }

                    Button {
                        id: closeButton
                        text: i18n.tr("Close")
                        onClicked: PopupUtils.close(dataBaseEraserDialog)
                    }

                    Button {
                        id: importButton
                        text: "Delete"
                        color: UbuntuColors.orange
                        onClicked: {
                            var rowsDeleted = Storage.deleteAllTemperatureValues();

                            deleteOperationResult.text = i18n.tr("Done, succesfully removed "+rowsDeleted+" values")
                            deleteOperationResult.color = UbuntuColors.green
                        }
                    }
                }

                Row{
                    Label{
                        id: deleteOperationResult
                    }
                }
            }
        }
    }
}

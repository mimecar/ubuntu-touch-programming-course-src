import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

/* replace the 'incomplete' QML API for the database access */
import QtQuick.LocalStorage 2.0
import "DateUtils.js" as DateUtils
import "Storage.js" as Storage


/* Show a confirm Dialog before a temperatures value */
Dialog {
    id: temperatureDeleteDialog
    text: "<b>"+i18n.tr("Remove Temperature value ?")+ "<br/>"+ i18n.tr("(there is no restore)")+"</b>"

    /* Input parameter: the temperature date */
    property string temperatureDate;

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
                        onClicked: PopupUtils.close(temperatureDeleteDialog)
                    }

                    Button {
                        id: importButton
                        text: "Delete"
                        color: UbuntuColors.orange
                        onClicked: {
                            var rowsDeleted = Storage.deleteTemperatureByDate(temperatureDate);

                            deleteOperationResult.text = i18n.tr("Operation executed, removed "+rowsDeleted+" value")
                            deleteOperationResult.color = UbuntuColors.green

                            temperatureFoundField.text = "";
                            searchResultRow.enabled = false;
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

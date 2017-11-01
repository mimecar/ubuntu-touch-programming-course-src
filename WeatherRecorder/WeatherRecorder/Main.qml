import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Components.Pickers 1.3

/* replace the 'incomplete' QML API U1db for the database access */
import QtQuick.LocalStorage 2.0

/* Import necessary Javascript files */
import "Storage.js" as Storage
import "ValidationUtils.js" as ValidationUtils
import "DateUtils.js" as DateUtils


/*!
  MainView of the WeatherRecorder Application
*/

MainView {    

    id:root
    objectName: "mainView"

    /* Note: applicationName needs to match the "name" field of the click manifest */
    applicationName: "weatherrecorder"
    automaticOrientation: true
    anchorToKeyboard: true

    width: units.gu(100)
    height: units.gu(75)

    property string appLicationTitle : i18n.tr("WeatherRecorder");
    property string appVersion : "1.0"

    /* Settings file is saved in ~userHome/.config/<applicationName>/<applicationName>.conf  File */
    Settings {
        id:settings
        /* flag to show or not the App configuration popup */
        property bool isFirstUse : true;
    }

    /* Prepare dedicated Components with custom messages to be shown  */

    Component {
        id: databaseCreationErrorDialog
        OperationResultDialog{msg:i18n.tr("FATAL ERROR: Error creating the database"); labelColor:UbuntuColors.red}
    }

    Component {
        id: operationSuccessDialog
        OperationResultDialog{msg:i18n.tr("Operation executed successfully"); labelColor:UbuntuColors.green}
    }

    Component {
        id: invalidInputDialog
        OperationResultDialog{msg:i18n.tr("FATAL ERROR: Invalid input value"); labelColor:UbuntuColors.red}
    }

    Component {
        id: valueAlreadyInsertedDialog
        OperationResultDialog{msg:i18n.tr("Value already inserted for the day: edit it"); labelColor:UbuntuColors.red}
    }

    Component {
        id: appConfigurationDialog
        AppConfiguration{}
    }

    Component {
        id: productInfoDialoDialog
        ProductInfoDialogue{}
    }

    Component {
        id: dataBaseEraser
        DataBaseEraserDialog{}
    }

    Component {
        id: confirmDeleteDialog
        ConfirmDeleteDialog{temperatureDate:dateButton.text}
    }

    /* -------- The application home page -------  */
    Page {
        id: mainPage

        header: PageHeader {
            id: pageHeader
            title: i18n.tr("WeatherRecorder")

            /* Actions available in the leadingActionBar (the one on the left side) */
            leadingActionBar.actions: [

               Action {
                    id:aboutPopover
                    /* Note: 'iconName' are file names under: /usr/share/icons/suru/actions/scalable */
                    iconName: "info"
                    text: i18n.tr("About")
                    onTriggered:{
                        PopupUtils.open(productInfoDialoDialog)
                    }
                }
            ]

            /* Actions available in the trailingActionBar (the one on the right side) */
            trailingActionBar.actions: [

                Action {
                    iconName: "delete"
                    text: "Delete"
                    onTriggered:{
                        PopupUtils.open(dataBaseEraser)
                    }
                },

                Action {
                    iconName: "settings"
                    text: "Settings"
                    onTriggered:{
                        PopupUtils.open(appConfigurationDialog);
                    }
                }
            ]
        }

        /* code executed on application start-up */
        Component.onCompleted: {

           if(settings.isFirstUse)
           {
              Storage.createTables();
              Storage.insertDefaultConfigValues();

              PopupUtils.open(appConfigurationDialog);
              /* to skyp database creation next application start-up */
              settings.isFirstUse = false;

           }else{
              /* load saved configuration */
              pageHeader.title = appLicationTitle+" for city: "+Storage.getConfigParamValue('city');
              temperatureUnitLabel.text = Storage.getConfigParamValue('temperatureUnit');
           }
        }


        Column{
            id: mainColumn
            spacing: units.gu(2)
            anchors.fill: parent

            /* transparent placeholder */
            Rectangle {
                color: "transparent"
                width: parent.width
                height: units.gu(6)
            }

            Row{
                id:insertRowHeader
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id: insertHeaderText
                    text: i18n.tr("Insert temperature")
                    font.bold: true
                    color: UbuntuColors.graphite
                    font.pointSize: units.gu(1.5)
                }
            }

            /* ------------------ INSERT FORM --------------- */        
            Row{
                id:insertRow
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: units.gu(1)
                spacing: units.gu(2)

                Image{
                    id:temperatureImage
                    width: 60; height: 70
                    fillMode: Image.PreserveAspectFit
                    source: "temperature.png"
                }

                Label{
                    anchors.verticalCenter: temperatureField.verticalCenter
                    text: i18n.tr("Temperature:")
                }

                TextField{
                    id: temperatureField
                    width: units.gu(10)
                }

                Label{
                    id: temperatureUnitLabel
                    anchors.verticalCenter: temperatureField.verticalCenter
                    width: units.gu(10)
                    text: " "
                }

                /* Create a PopOver containing a DatePicker */
                Component {
                    id: popoverTemperatureDatePicker
                    Popover {
                        id: popoverDatePicker

                        DatePicker {
                            id: timePicker
                            mode: "Days|Months|Years"
                            minimum: {
                                var time = new Date()
                                /* set to 2000 the lowest year selectable */
                                time.setFullYear('2000')
                                return time
                            }
                            /* when Datepicker is closed ('onDestruction' event is raised), is updated the date shown in the button */
                            Component.onDestruction: {
                                temperatureDateButton.text = Qt.formatDateTime(timePicker.date, "dd MMMM yyyy")
                            }
                        }
                    }
                }

                /* when clicked open the popOver component with DatePicker */
                Button {
                     id: temperatureDateButton
                     width: units.gu(20)
                     text: Qt.formatDateTime(new Date(), "dd MMMM yyyy")
                     onClicked: {
                         PopupUtils.open(popoverTemperatureDatePicker, temperatureDateButton)
                     }
                }

                Button{
                    id:insertButton
                    text: i18n.tr("Insert")
                    width: units.gu(14)
                    onClicked: {
                       /* perform some basic validations to prevent wrong or empty values */
                       if(ValidationUtils.isEmptyValue(temperatureField.text) || ValidationUtils.hasInvalidChar(temperatureField.text) ){
                           PopupUtils.open(invalidInputDialog);

                       }else if(Storage.getTemperatureValueByDate(temperatureDateButton.text) === "N/A"){

                          Storage.insertTemperature(temperatureDateButton.text,temperatureField.text);
                          temperatureField.text = "";
                          PopupUtils.open(operationSuccessDialog);

                       }else{                          
                           PopupUtils.open(valueAlreadyInsertedDialog);
                       }
                    }
                }
            }

            /* draw a line separator */
            Rectangle {
                color: "grey"
                width: units.gu(100)
                anchors.horizontalCenter: parent.horizontalCenter
                height: units.gu(0.1)
            }

            /* ------------------ SEARCH FORM --------------- */
            Row{
                id:searchRowHeader
                /* to place the title in the center */
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id: searchHeaderText
                    text: i18n.tr("Search temperature")
                    font.bold: true
                    color: UbuntuColors.graphite
                    font.pointSize: units.gu(1.5)
                }
            }

            Row{
                id:searchRow
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: units.gu(2)

                /* Create a PopOver containing a DatePicker */
                Component {
                    id: popoverDatePickerComponent
                    Popover {
                        id: popoverDatePicker

                        DatePicker {
                            id: timePicker
                            mode: "Days|Months|Years"
                            minimum: {
                                var time = new Date()
                                /* set to year 2000 as minimum selectable date */
                                time.setFullYear('2000')
                                return time
                            }
                            /* when Datepicker is closed ('onDestruction' event is raised), is updated the date shown in the button */
                            Component.onDestruction: {                               
                                dateButton.text = Qt.formatDateTime(timePicker.date, "dd MMMM yyyy")
                            }
                        }
                    }
                }

                /* transparent placeholder */
                Rectangle {
                    color: "transparent"
                    width: units.gu(7)
                    height: units.gu(0.1)
                }

                Image{
                    id:searchImage
                    width: 60; height: 70
                    fillMode: Image.PreserveAspectFit
                    source: "search.png"
                }

                Label{
                    anchors.verticalCenter: dateButton.verticalCenter
                    text: i18n.tr("Date:")
                }

                /* open the popOver component with the DatePicker */
                Button {
                    id: dateButton
                    width: units.gu(20)
                    text: Qt.formatDateTime(new Date(), "dd MMMM yyyy")
                    onClicked: {
                        PopupUtils.open(popoverDatePickerComponent, dateButton)
                    }
                }

                /* transparent placeholder */
                Rectangle {
                    color: "transparent"
                    width: units.gu(7)
                    height: units.gu(0.1)
                }

                Button{
                    id:searchButton
                    text: i18n.tr("Search")
                    width: units.gu(14)                    
                    onClicked: {
                        /* when the button is clicked is performed a database search operation */
                        temperatureFoundField.text = Storage.getTemperatureValueByDate(dateButton.text);
                        searchResultRow.enabled = true
                    }
                }
            }

            /* draw line separator */
            Rectangle {
                color: "grey"
                width: units.gu(100)
                anchors.horizontalCenter: parent.horizontalCenter
                height: units.gu(0.1)
            }


            /* ------------------ SEARCH RESULT --------------- */
            Row{
                id:searchResultHeader               
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id: searchResultHeaderText
                    text: i18n.tr("Temperature found")
                    font.bold: true
                    color: UbuntuColors.graphite
                    font.pointSize: units.gu(1.5)
                }
            }

            Row{
                id:searchResultRow
                /* 'enabled' flag disable the row and draw it with a grey colour */
                enabled: false
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: units.gu(2)
                spacing: units.gu(3)

                Label {
                    anchors.verticalCenter: temperatureFoundField.verticalCenter
                    text: i18n.tr("Temperature:")
                }

                TextField{
                    id: temperatureFoundField
                    width: units.gu(10)
                }

                Label{
                    id:temperatureUnitFoundLabel
                    anchors.verticalCenter: temperatureFoundField.verticalCenter                   
                    width: units.gu(10)
                    /* when the component is drawn is raised 'onComplete' event */
                    Component.onCompleted: {
                        /* load from the database the value to assign at the label */
                        temperatureUnitFoundLabel.text = Storage.getConfigParamValue('temperatureUnit');
                    }
                }

                Button {
                    id:updateTemperatureButton
                    text: i18n.tr("Update")
                    width: units.gu(14)
                    onClicked: {
                        /* perform some validations to prevent wrong data insertion or empty ones */
                        if(ValidationUtils.isEmptyValue(temperatureFoundField.text) || ValidationUtils.hasInvalidChar(temperatureFoundField.text) )
                        {
                           PopupUtils.open(invalidInputDialog);
                        }else{
                            /* if no updated row, means that the temparature value is missing for that day: insert it */
                            var affectedRow = Storage.updateTemperature(dateButton.text,temperatureFoundField.text);

                            if(affectedRow === 0)
                               Storage.insertTemperature(dateButton.text,temperatureFoundField.text)

                            PopupUtils.open(operationSuccessDialog);
                            temperatureFoundField.text = "";
                            /* disable the search result form */
                            searchResultRow.enabled = false;
                        }
                    }
                }

                Button {
                    id:deleteTemperatureButton
                    text: i18n.tr("Delete")
                    width: units.gu(14)
                    onClicked: {
                        /* perform some validations to prevent wrong data insertion or empty ones */
                        if(ValidationUtils.isEmptyValue(temperatureFoundField.text) || ValidationUtils.hasInvalidChar(temperatureFoundField.text) )
                        {
                           PopupUtils.open(invalidInputDialog);
                        }else{
                           PopupUtils.open(confirmDeleteDialog);                          
                        }
                    }
                }
            }

        }
    }
}

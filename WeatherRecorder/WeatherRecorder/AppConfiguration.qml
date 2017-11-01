import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Components.Pickers 1.3
import Ubuntu.Layouts 1.0
import Ubuntu.Components.ListItems 1.3 as ListItem

/* replace the 'incomplete' QML API U1db to access at the database */
import QtQuick.LocalStorage 2.0

/* note: alias name must have first letter in upper Case */
import "ValidationUtils.js" as ValidationUtils
import "Storage.js" as Storage


Dialog {

    id:appConfigurationDialog
    title: i18n.tr("App Configuration")

    width: units.gu(100)
    height: units.gu(75)

    /*load from the Database the currently saved configuration values (default values or custom one) */
    Component.onCompleted: {

        var savedCity = Storage.getConfigParamValue('city');
        var savedTemperatureUnit = Storage.getConfigParamValue('temperatureUnit');

        /* set the selector element with the saved value */
        for(var i=0; i<temperatureUnitSelector.model.length; i++)
        {
            if(temperatureUnitSelector.model[i] === savedTemperatureUnit){
               temperatureUnitSelector.selectedIndex = i;
               break;
            }
        }
        cityField.text = savedCity;
    }


    Row {
        spacing: units.gu(2)

        Label {
            anchors.verticalCenter: cityField.verticalCenter
            text: i18n.tr("City:")
        }

        TextField{
            id: cityField
            width: units.gu(25)
        }
    }

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: units.gu(3)

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n.tr("Temperature Scale:")
        }

        ListItem.ItemSelector {
            id: temperatureUnitSelector          
            model: [i18n.tr("Fahrenheit"), i18n.tr("Celsius")]
            expanded: true
        }
    }

    Row {
        spacing: units.gu(2)

        Button {
            id: selectSubCategoryButton
            text: i18n.tr("Save")
            width: units.gu(14)
            onClicked: {
                /* get the chosen temparature unit of measure */
                var temperatureUnitName = temperatureUnitSelector.model[temperatureUnitSelector.selectedIndex];

                /* update the values in the configuration table */
                Storage.updateConfigParamValue('city',cityField.text);
                Storage.updateConfigParamValue('temperatureUnit',temperatureUnitName);

                operationResultLabel.text = i18n.tr("Done, operation executed successfully")
                operationResultLabel.color = UbuntuColors.green

                /* update the UI with the chosen values */
                temperatureUnitLabel.text = temperatureUnitName;
                temperatureUnitFoundLabel.text = temperatureUnitName;
                pageHeader.title = appLicationTitle +" for city: "+cityField.text;
            }
        }

        Button {
            text: i18n.tr("Close")
            width: units.gu(14)
            onClicked: {
                PopupUtils.close(appConfigurationDialog)
            }
        }
    }

    Row{
        Label{
            id: operationResultLabel
            text: " "
        }
    }
}



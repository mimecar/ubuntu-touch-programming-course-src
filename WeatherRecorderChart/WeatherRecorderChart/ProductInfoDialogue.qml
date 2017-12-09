import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3


/* General info about the application */
Dialog {
       id: aboutProductDialogue
       title: i18n.tr("Product Info")
       text: "WeatherRecorderChart: version "+root.appVersion+"<br/> A simple temperature weather recorder for your favourite city with chart feature"

       Button {
           text: "Close"
           onClicked: PopupUtils.close(aboutProductDialogue)
       }
}

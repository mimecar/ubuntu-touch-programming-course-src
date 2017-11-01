import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3


/* PopUP that display general info about the application */
Dialog {
       id: aboutProductDialogue
       title: i18n.tr("Product Info")
       text: "WeatherRecorder: version "+root.appVersion+"<br/> A simple temperature weather of your favourite city"

       Button {
           text: "Close"
           onClicked: PopupUtils.close(aboutProductDialogue)
       }
}

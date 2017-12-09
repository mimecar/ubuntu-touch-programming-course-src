import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3


/* Notify for an operation result using the input message and color */
Dialog {
    id: operationErrorDialog

    /* Input parameter: the message text to display and the color to user */
    property string msg;
    property color  labelColor;

    title: i18n.tr("Operation Result")

    Label{
        text: i18n.tr(msg)
        color: labelColor //UbuntuColors.red
    }

    Button {
        text: "Close"
        onClicked:
           PopupUtils.close(operationErrorDialog)
    }
}

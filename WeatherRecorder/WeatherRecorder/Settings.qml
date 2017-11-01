import QtQuick 2.0
import Qt.labs.settings 1.0

/* The setting flag to be persisted */
Settings {

    /*
       if 'true' means that is the first time that the user run the application: is necessary create the Database
       and init it
    */
    property bool isFirstUse:true;

}



/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs

Rectangle {
    property string selectedImagePath: "";
    id: backGround
    width: 1920
    height: 1080
    color: "#62507a"

    Image {
        id: superTitle
        x: 368
        y: -263
        width: 1169
        height: 875
        source: "Title.png"
    }

    Image {
        id: regularTitle
        x: 598
        y: 213
        width: 711
        height: 390
        source: "Inference.png"
    }

    FileDialog {
        id: fileUpload
        title: "Select an Image to upload"
        nameFilters: ["Text or Image Files (*.png *.txt *.csv)", "All Files (*)"]
        onAccepted: {
            selectedImagePath = fileUpload.selectedFile;
        }
    }

    Button {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Pick Input File"
        onClicked: fileUpload.open()
    }

    Item {
        id: __materialLibrary__
    }
}

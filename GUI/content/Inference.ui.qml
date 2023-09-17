

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3

Rectangle {
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
        id: fileDialog
        title: "Select an Image to Upload"
        nameFilters: ["Images (*.png *.jpg *.jpeg *.bmp *.gif)", "All Files (*)"] // Define allowed image file types
        onAccepted: {
            // Handle the selected image file here
            var selectedImagePath = fileDialog.fileUrl
            console.log("Selected image: " + selectedImagePath)
        }
        onRejected: {
            console.log("Dialog rejected")
        }
    }

    Item {
        id: __materialLibrary__
    }
}

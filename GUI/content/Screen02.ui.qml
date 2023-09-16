

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import GUI

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height

    Rectangle {
        id: rectangle1
        y: 0
        width: 24
        height: 1080
        color: "#ed333b"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    DatasetSelection {
        id: datasetSelection
        x: 1258
        width: 400
        anchors.left: rectangle1.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 300
        anchors.rightMargin: 250
        anchors.leftMargin: 250
        anchors.topMargin: 300
        scale: 2
    }

    ModelSelection {
        id: modelSelection
        anchors.left: parent.left
        anchors.right: rectangle1.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 250
        anchors.leftMargin: 250
        anchors.bottomMargin: 300
        anchors.topMargin: 300
        scale: 2
    }

    Button {
        id: button
        x: 1564
        y: 940
        width: 175
        height: 75
        text: qsTr("Next")
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        font.pixelSize: 25
        font.family: "Arial"
        checkable: false
        anchors.bottomMargin: 25
        anchors.rightMargin: 25
    }
    states: [
        State {
            name: "clicked"
        }
    ]
}

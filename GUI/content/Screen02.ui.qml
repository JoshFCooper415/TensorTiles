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


    ModelSelection {
        id: modelSelection
        width: 432
        height: 378
        anchors.left: parent.left
        anchors.top: parent.top
        scale: 2
        anchors.topMargin: 250
        anchors.leftMargin: 300
    }

    Rectangle {
        id: rectangle1
        y: 0
        width: 24
        height: 1080
        color: "#ed333b"
        anchors.horizontalCenter: parent.horizontalCenter
    }
    states: [
        State {
            name: "clicked"
        }
    ]
}

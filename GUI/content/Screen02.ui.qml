import QtQuick 6.2
import QtQuick.Controls 6.2
import GUI
import ModelDatasetSelectionBackend

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    property bool pressed: false
    property string model: "";
    property string dataset: "";

    ModelDatasetSelectionBackend {
        id: backend
    }

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

        Connections {
            target: button
            onClicked: {
                backend.doStuff(modelSelection.selected, datasetSelection.selected)
                model = modelSelection.selected
                dataset = datasetSelection.selected
            }
        }

    }
}

import QtQuick 6.2
import QtQuick.Controls 6.2
import GUI
import ModelDatasetSelectionBackend

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    property bool pressed: false
    property string model: ""
    property string dataset: ""

    ModelDatasetSelectionBackend {
        id: backend
    }

    Rectangle {
        id: rectangle1
        y: 0
        width: 24
        height: 1080
        color: "#79949f"
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
        anchors.bottomMargin: 297
        anchors.topMargin: 303
        scale: 2
    }

    Image {
        id: chameleon2
        x: 590
        y: 781
        width: 425
        height: 394
        source: "Themed_Chameleon.png"
    }

    Button {
        id: selectedModel
        x: 1726
        y: 955
        width: 157
        height: 88
        text: qsTr("NEXT")
        icon.color: "white"
        font.pixelSize: 45

        background: Rectangle {
            color: "#89ab9d"
            radius: 25
        }

        Connections {
            target: selectedModel
            onClicked: {
                backend.doStuff(modelSelection.selected,
                                datasetSelection.selected)
                model = modelSelection.selected
                dataset = datasetSelection.selected
            }
        }
    }

    Image {
        id: cnnLogo
        x: 228
        y: 194
        width: 256
        height: 316
        source: "CNNlogo.png"
    }
    Image {
        id: forestLogo
        x: 137
        y: 481
        width: 439
        height: 293
        source: "forestLogo.png"
    }
    Image {
        id: regLogo
        x: 208
        y: 795
        width: 271
        height: 251
        source: "linearLogo.png"
    }
}

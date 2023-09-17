import QtQuick 2.15
import QtQuick.Controls 2.15

Grid {
    id: grid
    width: 450
    height: 500

    property string selected: "MNIST";

    Label {
        id: modelSelectLabel
        width: 450
        height: 50
        text: qsTr("Select a Dataset")
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        font.styleName: "Bold"
        topPadding: 10
    }

    RadioButton {
        id: handwrittenNumbersSelected
        width: 450
        height: 50
        text: qsTr("Handwritten Numbers")
        anchors.top: modelSelectLabel.bottom
        autoRepeat: false
        checked: true
        anchors.horizontalCenter: modelSelectLabel.horizontalCenter
        anchors.topMargin: 10

        Connections {
            target: handwrittenNumbersSelected
            onClicked: selected = "MNIST"
        }
    }

    RadioButton {
        id: handwrittenShapesSelected
        width: 450
        height: 50
        text: qsTr("Handwritten Shapes")
        anchors.top: handwrittenNumbersSelected.bottom
        anchors.topMargin: 10

        Connections {
            target: handwrittenShapesSelected
            onClicked: selected = "handShapes"
        }
    }

    RadioButton {
        id: crayonColorsSelected
        width: 450
        height: 50
        text: qsTr("Crayon Colors")
        anchors.top: handwrittenShapesSelected.bottom
        anchors.topMargin: 10

        Connections {
            target: crayonColorsSelected
            onClicked: selected = "crayon"
        }
    }

    RadioButton {
        id: realEstateSelected
        width: 450
        height: 50
        text: qsTr("Real Estate")
        anchors.top: crayonColorsSelected.bottom
        anchors.topMargin: 10

        Connections {
            target: realEstateSelected
            onClicked: selected = "realEstate"
        }
    }

    RadioButton {
        id: financeSelected
        width: 450
        height: 50
        text: qsTr("Finance")
        anchors.top: realEstateSelected.bottom
        anchors.topMargin: 10

        Connections {
            target: financeSelected
            onClicked: selected = "finance"
        }
    }

    RadioButton {
        id: spectographSelected
        width: 450
        height: 50
        text: qsTr("Spectograph")
        anchors.top: financeSelected.bottom
        anchors.topMargin: 10

        Connections {
            target: spectographSelected
            onClicked: selected = "spectograph"
        }
    }

    RadioButton {
        id: uploadSelected
        width: 450
        height: 50
        text: qsTr("Upload Option")
        anchors.top: spectographSelected.bottom
        anchors.topMargin: 10

        Connections {
            target: uploadSelected
            onClicked: selected = "upload"
        }
    }
}

import QtQuick 2.15
import QtQuick.Controls 2.15

Grid {
    id: grid
    width: 450
    height: 500

    property string selected: "handNumbers";

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
            onClicked: selected = "handNumbers"
        }
    }

    RadioButton {
        id: handwrittenShapesSelected
        width: 450
        height: 50
        text: qsTr("Clothing Pictures")
        anchors.top: handwrittenNumbersSelected.bottom
        anchors.topMargin: 10

        Connections {
            target: handwrittenShapesSelected
            onClicked: selected = "clothing"
        }
    }

    RadioButton {
        id: crayonColorsSelected
        width: 450
        height: 50
        text: qsTr("Basic Images")
        anchors.top: handwrittenShapesSelected.bottom
        anchors.topMargin: 10

        Connections {
            target: crayonColorsSelected
            onClicked: selected = "basic"
        }
    }

    RadioButton {
        id: realEstateSelected
        width: 450
        height: 50
        text: qsTr("Boston Real Estate")
        anchors.top: crayonColorsSelected.bottom
        anchors.topMargin: 10

        Connections {
            target: realEstateSelected
            onClicked: selected = "brealEstate"
        }
    }

    RadioButton {
        id: financeSelected
        width: 450
        height: 50
        text: qsTr("Paris Real Estate")
        anchors.top: realEstateSelected.bottom
        anchors.topMargin: 10

        Connections {
            target: financeSelected
            onClicked: selected = "prealestate"
        }
    }

    RadioButton {
        id: spectographSelected
        width: 450
        height: 50
        text: qsTr("Insurance")
        anchors.top: financeSelected.bottom
        anchors.topMargin: 10

        Connections {
            target: spectographSelected
            onClicked: selected = "insurance"
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

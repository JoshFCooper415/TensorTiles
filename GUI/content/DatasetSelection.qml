import QtQuick 2.15
import QtQuick.Controls 2.15

Grid {
    id: grid
    width: 450
    height: 500

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
    }

    RadioButton {
        id: handwrittenShapesSelected
        width: 450
        height: 50
        text: qsTr("Handwritten Shapes")
        anchors.top: handwrittenNumbersSelected.bottom
        anchors.topMargin: 10
    }

    RadioButton {
        id: crayonColorsSelected
        width: 450
        height: 50
        text: qsTr("Crayon Colors")
        anchors.top: handwrittenShapesSelected.bottom
        anchors.topMargin: 10
    }

    RadioButton {
        id: realEstateSelected
        width: 450
        height: 50
        text: qsTr("Real Estate")
        anchors.top: crayonColorsSelected.bottom
        anchors.topMargin: 10
    }

    RadioButton {
        id: financeSelected
        width: 450
        height: 50
        text: qsTr("Finance")
        anchors.top: realEstateSelected.bottom
        anchors.topMargin: 10
    }

    RadioButton {
        id: spectographSelected
        width: 450
        height: 50
        text: qsTr("Spectograph")
        anchors.top: financeSelected.bottom
        anchors.topMargin: 10
    }

    RadioButton {
        id: uploadSelected
        width: 450
        height: 50
        text: qsTr("Upload Option")
        anchors.top: spectographSelected.bottom
        anchors.topMargin: 10
    }
}

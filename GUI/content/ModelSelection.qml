import QtQuick 2.15
import QtQuick.Controls 2.15

Grid {
    id: grid
    width: 450
    height: 400

    Label {
        id: modelSelectLabel
        width: 450
        height: 50
        text: qsTr("Select a Machine Learning Model")
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        font.styleName: "Bold"
        topPadding: 10
    }

    RadioButton {
        id: cnnSelected
        width: 450
        height: 50
        text: qsTr("Convolutional Neural Network (CNN)")
        anchors.top: modelSelectLabel.bottom
        autoRepeat: false
        checked: true
        anchors.horizontalCenter: modelSelectLabel.horizontalCenter
        anchors.topMargin: 10
    }

    RadioButton {
        id: randomForestSelected
        width: 450
        height: 50
        text: qsTr("Random Forest")
        anchors.top: cnnSelected.bottom
        anchors.topMargin: 10
    }

    RadioButton {
        id: transformerSelected
        width: 450
        height: 50
        text: qsTr("Transformer")
        anchors.top: randomForestSelected.bottom
        anchors.topMargin: 10
    }

    RadioButton {
        id: regressionSelected
        width: 450
        height: 50
        text: qsTr("Regression")
        anchors.top: transformerSelected.bottom
        anchors.topMargin: 10
    }

    RadioButton {
        id: ffnnSelected
        width: 450
        height: 50
        text: qsTr("Feed Forward Neural Network (FFNN)")
        anchors.top: regressionSelected.bottom
        anchors.topMargin: 10
    }
}

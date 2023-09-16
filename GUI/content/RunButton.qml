import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 160
    height: 80

    Button {
        id: runButton
        x: 8
        y: 8
        width: 143
        height: 66
        text: qsTr("RUN")
        font.pointSize: 30
        icon.color: "black"

        background: Rectangle {
            gradient: Gradient {
                GradientStop { position: 0; color: "white" }
                GradientStop { position: 1; color: "grey" }
            }
            border.color: "black"
            border.width: 5
            radius: 10
        }
    }
}

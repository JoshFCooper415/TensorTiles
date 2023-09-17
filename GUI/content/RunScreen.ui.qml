import QtQuick 2.15
import QtQuick.Controls 6.2

Item {
    property bool done: false
    BusyIndicator {
        id: busyIndicator
        x: 885
        y: 626
        width: 150
        height: 150
        visible: !done
    }

    Label {
        id: label
        x: 773
        y: 394
        width: 374
        height: 124
        text: qsTr("Training Model...")
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 35
    }

    Text {
        id: text1
        x: 856
        y: 626
        width: 208
        height: 78
        visible: done
        text: qsTr("Done Training!")
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
    }
}

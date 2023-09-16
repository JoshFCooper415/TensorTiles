

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
    property bool isDone: false

    id: rectangle
    width: Constants.width
    height: Constants.height

    color: Constants.backgroundColor

    Rectangle {
        id: backgroundRect
        color: "grey"
        opacity: 1.0
        width: 1059
        height: 389
        x: 488
        y: 338
    }

    Button {
        id: next
        x: 920
        y: 756
        width: 157
        height: 88
        text: qsTr("NEXT")
        icon.color: "white"
        font.pixelSize: 35

        background: Rectangle {
            color: "darkgreen"
            radius: 25
        }

        onClicked: isDone = true
    }

    Label {
        id: sizeTreesTitle
        x: 1259
        y: 651
        text: qsTr("Size of Trees")
        font.pointSize: 25
        font.family: "Verdana"
    }

    Slider {
        id: sizeTree
        x: 1339
        y: 441
        stepSize: 1
        to: 16
        from: 1
        snapMode: RangeSlider.SnapOnRelease
        orientation: Qt.Vertical
        value: 0.5
    }

    Slider {
        id: numTrees
        x: 853
        y: 441
        orientation: Qt.Vertical
        value: 100
        stepSize: 1
        snapMode: RangeSlider.SnapOnRelease
        to: 5000
        from: 1
    }

    Label {
        id: epochsVal
        x: 585
        y: 458
        height: 21
        color: "#121842"
        text: epochs.value
        font.pointSize: 14
        font.family: "Verdana"
    }

    Label {
        id: numTreesTitle
        x: 500
        y: 355
        text: qsTr("Number of Epochs")
        font.family: "Verdana"
        font.pointSize: 25
    }

    Slider {
        id: iterations
        x: 1105
        y: 411
        orientation: Qt.Vertical
        value: 10
        stepSize: 1
        snapMode: RangeSlider.SnapOnRelease
        to: 100
        from: 1
    }

    Slider {
        id: epochs
        x: 617
        y: 411
        orientation: Qt.Vertical
        value: 10
        stepSize: 1
        snapMode: RangeSlider.SnapOnRelease
        to: 100
        from: 1
    }

    Label {
        id: sizeTreesVal
        x: 1287
        y: 458
        width: 87
        height: 24
        color: "#121842"
        text: sizeTree.value
        font.pointSize: 14
        font.family: "Verdana"
    }

    Label {
        id: title
        x: 872
        y: 247
        color: "#273c30"
        text: qsTr("Regression")
        font.family: "Verdana"
        font.styleName: "Bold"
        font.pointSize: 35
    }

    Label {
        id: numTreesTitle1
        x: 702
        y: 651
        text: qsTr("Number of Trees")
        font.family: "Verdana"
        font.pointSize: 25
    }

    Label {
        id: numTreesVal
        x: 786
        y: 458
        height: 21
        color: "#121842"
        text: numTrees.value
        font.family: "Verdana"
        font.pointSize: 14
    }

    Label {
        id: numTreesTitle2
        x: 971
        y: 355
        text: qsTr("Number of Iterations")
        font.family: "Verdana"
        font.pointSize: 25
    }

    Label {
        id: iterationsVal
        x: 1036
        y: 458
        width: 63
        height: 24
        color: "#121842"
        text: iterations.value
        font.family: "Verdana"
        font.pointSize: 14
    }
}

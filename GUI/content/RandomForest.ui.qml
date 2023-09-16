

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

    color: Constants.backgroundColor

    Image {
        id: image
        x: 697
        y: 617
        width: 640
        height: 317
        anchors.bottom: parent.bottom
        source: "../../../../Pictures/Saved Pictures/TensorTiles/RandomForestBackground.jpg"
        anchors.bottomMargin: 146
        fillMode: Image.PreserveAspectFit
    }

    Slider {
        id: sizeTree
        x: 1161
        y: 391
        stepSize: 1
        to: 16
        from: 1
        snapMode: RangeSlider.SnapOnRelease
        orientation: Qt.Vertical
        value: 0.5
    }

    Slider {
        id: numTrees
        x: 781
        y: 391
        orientation: Qt.Vertical
        value: 100
        stepSize: 1
        snapMode: RangeSlider.SnapOnRelease
        to: 5000
        from: 1
    }

    Label {
        id: numTreesVal
        x: 702
        y: 442
        height: 21
        color: "#121842"
        text: numTrees.value
        font.pointSize: 14
        font.family: "Verdana"
    }

    Label {
        id: numTreesTitle
        x: 645
        y: 338
        text: qsTr("Number of Trees")
        font.family: "Verdana"
        font.pointSize: 25
    }

    Label {
        id: sizeTreesTitle
        x: 1074
        y: 338
        text: qsTr("Size of Trees")
        font.pointSize: 25
        font.family: "Verdana"
    }

    Label {
        id: sizeTreesVal
        x: 1119
        y: 440
        color: "#121842"
        text: sizeTree.value
        font.pointSize: 14
        font.family: "Verdana"
    }

    Label {
        id: title
        x: 806
        y: 225
        color: "#273c30"
        text: qsTr("Random Forest")
        font.family: "Verdana"
        font.styleName: "Bold"
        font.pointSize: 35
    }

    RunButton {
        id: runButton
        x: 1297
        y: 835
        width: 1434
        height: 844
    }
    states: [
        State {
            name: "clicked"
            when: runButtonRandomForest.clicked
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "clicked"
            reversible: true
        }
    ]
}

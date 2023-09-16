

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
        x: 357
        y: 52
        width: 1361
        height: 1028
        anchors.bottom: parent.bottom
        source: "../asset_imports/randomForestBackground.png"
        anchors.bottomMargin: 0
        opacity: 0.5
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: randomForestBackgroud
        width: 928
        height: 419
        x: 574
        y: 347
        color: "lightgrey"
        opacity: 0.8
        radius: 40
    }

    Slider {
        id: sizeTree
        x: 1194
        y: 485
        stepSize: 1
        to: 16
        from: 1
        snapMode: RangeSlider.SnapOnRelease
        orientation: Qt.Vertical
        value: 0.5
    }

    Slider {
        id: numTrees
        x: 810
        y: 485
        orientation: Qt.Vertical
        value: 100
        stepSize: 1
        snapMode: RangeSlider.SnapOnRelease
        to: 5000
        from: 1
    }

    Label {
        id: numTreesVal
        x: 728
        y: 530
        width: 30
        height: 21
        color: "black"
        text: numTrees.value
        font.pointSize: 14
        font.family: "Verdana"
    }

    Label {
        id: numTreesTitle
        x: 691
        y: 423
        text: qsTr("Number of Trees")
        font.family: "Verdana"
        font.pointSize: 25
    }

    Label {
        id: sizeTreesTitle
        x: 1094
        y: 423
        text: qsTr("Size of Trees")
        font.pointSize: 25
        font.family: "Verdana"
    }

    Label {
        id: sizeTreesVal
        x: 1138
        y: 520
        color: "#121842"
        text: sizeTree.value
        font.pointSize: 14
        font.family: "Verdana"
    }

    Label {
        id: title
        x: 772
        y: 221
        color: "#273c30"
        text: qsTr("Random Forest")
        font.family: "Verdana"
        font.styleName: "Bold"
        font.pointSize: 35
    }
}

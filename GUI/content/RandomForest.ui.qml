

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
        id: randForTitle
        x: 542
        y: -172
        width: 936
        height: 662
        source: "Title.png"
    }

    Rectangle {
        id: randomForestBackgroud
        width: 928
        height: 419
        x: 574
        y: 442
        color: "lightgrey"
        opacity: 0.8
        radius: 40
    }

    Image {
        id: forestPic1
        x: 744
        y: 166
        width: 574
        height: 337
        source: "randForestTitle.png"
    }

    Image {
        id: forestPic2
        x: 681
        y: 423
        width: 320
        height: 203
        source: "numTrees.png"
    }

    Image {
        id: forestPic3
        x: 1042
        y: 423
        width: 339
        height: 213
        source: "sizeTrees.png"
    }

    Image {
        id: chameleon1
        x: 316
        y: 705
        width: 425
        height: 394
        source: "Themed_Chameleon.png"
    }

    Button {
        id: nextForest
        x: 924
        y: 904
        width: 157
        height: 88
        text: qsTr("NEXT")
        icon.color: "white"
        font.pixelSize: 35

        background: Rectangle {
            color: "#89ab9d"
            radius: 25
        }

        onClicked: isDone = true
    }

    Slider {
        id: sizeTree
        x: 1182
        y: 587
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
        y: 587
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
        y: 622
        width: 30
        height: 21
        color: "black"
        text: numTrees.value
        font.pointSize: 14
        font.family: "Verdana"
    }

    Label {
        id: sizeTreesVal
        x: 1132
        y: 622
        width: 20
        height: 34
        color: "#121842"
        text: sizeTree.value
        font.pointSize: 14
        font.family: "Verdana"
    }
}

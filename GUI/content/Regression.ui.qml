

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
        color: "#d2716b"
        opacity: 1.0
        width: 1371
        height: 389
        radius: 40
        x: 322
        y: 479
    }

    Image {
        id: regressionMaintTitle
        x: 298
        y: -271
        width: 1382
        height: 936
        source: "Title.png"
    }

    Image {
        id: sizeTreePic
        x: 1355
        y: 456
        width: 260
        height: 165
        source: "Untitled_Artwork (1).png"
    }

    Image {
        id: numTreePic
        x: 670
        y: 435
        width: 337
        height: 196
        source: "Untitled_Artwork (2).png"
    }

    Image {
        id: reg3
        x: 1027
        y: 443
        width: 293
        height: 179
        source: "Untitled_Artwork (3).png"
    }

    Image {
        id: reg4
        x: 680
        y: 212
        width: 669
        height: 403
        source: "Untitled_Artwork (4).png"
    }

    Image {
        id: reg5
        x: 352
        y: 456
        width: 293
        height: 168
        source: "Untitled_Artwork.png"
    }

    Button {
        id: next
        x: 924
        y: 904
        width: 157
        height: 88
        text: qsTr("NEXT")
        icon.color: "white"
        font.pixelSize: 35

        background: Rectangle {
            color: "#d2716b"
            radius: 25
        }

        onClicked: isDone = true
    }

    Slider {
        id: sizeTree
        x: 1460
        y: 583
        stepSize: 1
        to: 16
        from: 1
        snapMode: RangeSlider.SnapOnRelease
        orientation: Qt.Vertical
        value: 0.5
    }

    Slider {
        id: numTrees
        x: 815
        y: 581
        orientation: Qt.Vertical
        value: 100
        stepSize: 1
        snapMode: RangeSlider.SnapOnRelease
        to: 5000
        from: 1
    }

    Label {
        id: epochsVal
        x: 396
        y: 644
        height: 21
        color: "#121842"
        text: epochs.value
        font.pointSize: 14
        font.family: "Verdana"
    }

    Slider {
        id: iterations
        x: 1146
        y: 589
        orientation: Qt.Vertical
        value: 10
        stepSize: 1
        snapMode: RangeSlider.SnapOnRelease
        to: 100
        from: 1
    }

    Slider {
        id: epochs
        x: 469
        y: 589
        orientation: Qt.Vertical
        value: 10
        stepSize: 1
        snapMode: RangeSlider.SnapOnRelease
        to: 100
        from: 1
    }

    Label {
        id: sizeTreesVal
        x: 1388
        y: 649
        width: 87
        height: 24
        color: "#121842"
        text: sizeTree.value
        font.pointSize: 14
        font.family: "Verdana"
    }

    Label {
        id: numTreesVal
        x: 754
        y: 649
        height: 21
        color: "#121842"
        text: numTrees.value
        font.family: "Verdana"
        font.pointSize: 14
    }

    Label {
        id: iterationsVal
        x: 1095
        y: 649
        width: 63
        height: 24
        color: "#121842"
        text: iterations.value
        font.family: "Verdana"
        font.pointSize: 14
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

// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.5
import QtQuick 2.15
import QtQuick.Controls 2.15
import GUI
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Window {
    width: 1920
    height: 1080
    visible: true
    title: qsTr("StackLayout Test")
    id: mainWindow

    TabBar {
        id: bar
        width: parent.width
        anchors {
            top: mainWindow.top
            left: mainWindow.left
            right: mainWindow.right
        }
    }

    TabButton {
        text: qsTr("Choose Model")
        id: thingText
        x: 0
        y: -4
        onClicked: stackView.currentIndex = 0
    }
    TabButton {
        x: 169
        y: -4
        text: qsTr("Build Model")
        onClicked: stackView.currentIndex = 1
    }
    TabButton {
        x: 331
        y: -4
        text: qsTr("Run Model")
        onClicked: stackView.currentIndex = 2
    }
    TabButton {
        x: 478
        y: -4
        text: qsTr("Run Inference")
        onClicked: stackView.currentIndex = 4
    }

    StackLayout {
        id: stackView
        x: 0
        y: 0
        width: parent.width
        height: parent.height - bar.height
        currentIndex: bar.currentIndex
        anchors {
            top: bar.bottom
            left: mainWindow.left
            right: mainWindow.right
        }

        Screen02 {
            id: chooseModelTab
        }

        DragNDropCNN {
            id: buildTab
            colorKey: "orange"
            modelData: 0
        }

        Rectangle {
            id: runRab
            color: "red"
            Button {
                id: doneButton1
                x: 487
                y: 337
                text: qsTr("Done")
                onClicked: stackView.currentIndex = 3
            }
        }
        Rectangle {
            id: inferenceTab
            color: "purple"
            Button {
                id: resetButton1
                x: 487
                y: 337
                text: qsTr("Restart")
                onClicked: stackView.currentIndex = 0
            }
        }
        Rectangle {
            id: randomForest
            width: parent.width
            height: parent.height

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

        }

    }
}


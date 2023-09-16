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

    property var screens: {"cnn":0, "rForest":1, "regression": 2, "ffnn": 3, "transformer":4}

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
            Connections {
                target: Screen02
                onModelChanged: stackView.currentIndex = screens[modelSelection.selected]
            }
        }
        Rectangle {
            id: builderTab
            color: "#87CEFA"
            Text {
                text: qsTr("Other thing")
                anchors.centerIn: parent
            }
            Button {
                id: runButton1
                x: 487
                y: 337
                text: qsTr("Run")
                icon.color: "#ffffff"
                onClicked: stackView.currentIndex = 2
            }
        }
        Rectangle {
            id: runTab
            color: "orange"
            Loader {
                id: chooseModelLoader
                source: "./Screen02.ui.qml"
                anchors.fill: parent
            }
        }
        // index 2 - Inference
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
        // index 3 - Random Forest
        Rectangle {
            id: randomForest
            color: "orange"
            Loader {
                id: randomForestLoader
                source: "./RandomForest.ui.qml"
                anchors.fill: parent
            }
        }
        //index 4 - CNN
        DragNDropCNN {
            id: convNet
            colorKey: "orange"
            modelData: 0
        }
        // index 5 - Regression
        Rectangle {
            id: regression
            color: "orange"
            Loader {
                id: regressionLoader
                source: "./Regression.ui.qml"
                anchors.fill: parent
            }
        }
    }
}


// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.5
import QtQuick 2.15
import QtQuick.Controls 2.15
import GUI
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import AppBackend

Window {
    width: 1920
    height: 1080
    visible: true
    title: qsTr("StackLayout Test")
    id: mainWindow

    property var screens: {"cnn":2, "rForest":1, "regression": 3, "ffnn": -1, "transformer":-1}
    property string model: ""
    property string dataset: ""

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
                target: chooseModelTab
                onModelChanged: {
                    stackView.currentIndex = screens[chooseModelTab.model]
                    model = chooseModelTab.model
                    dataset = chooseModelTab.dataset
                }
            }
        }

        // index 1 - Random Forest
        RandomForest {
            id: randomForest
        }
        //index 2 - CNN
        DragNDropCNN {
            id: convNet
            colorKey: "orange"
            modelData: 0

            Connections {
                target: convNet
                onIsDoneChanged: {
                    backend.doStuff(convNet.array.join(";"), chooseModelTab.model, chooseModelTab.dataset, convNet.epochs, convNet.learningRate)
//                    console.log(convNet.array.join(";"))
                    stackView.currentIndex = 4
                }
            }
        }
        // index 3 - Regression
        Regression {
            id: regression
        }

        Rectangle {
            id: runTab
            color: "orange"
        }
        // index 5 - Inference
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

        AppBackend {
            id: backend
        }
    }
}


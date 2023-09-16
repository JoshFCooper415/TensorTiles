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
    width: 640
    height: 480
    visible: true
    title: qsTr("StackLayout Test")
    id: mainWindow

    Rectangle {
            color: "#212126"
            anchors.fill: parent
        }

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
        onClicked: stackView.currentIndex = 3
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

        Rectangle {
            id: chooseModelTab
            color: "orange"
            Text {
                width: 111
                height: 68
                text: qsTr("Thing")
                color: "white"
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: builderTab
            color: "blue"
            Text {
                text: qsTr("Other thing")
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: runRab
            color: "red"
        }
        Rectangle {
            id: inferenceTab
            color: "purple"
        }

    }
}


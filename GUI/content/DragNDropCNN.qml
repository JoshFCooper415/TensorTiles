import QtQuick 2.15
import QtQuick.Controls

Item {
    id: root

    required property string colorKey
    required property int modelData
    property bool isDone: false;
    property var array: [];
    property int epochs: 5;
    property int learningRate;

    width: 1920
    height: 1080

    Label {
        id: noEpochsLabel
        anchors.left: parent.left
        anchors.bottom: dropContainer.top
        anchors.bottomMargin: 15
        anchors.leftMargin: 15
        color: "#273c30"
        text: qsTr("Number of Epochs: ")
        font.family: "Verdana"
        font.pointSize: 12
        anchors.topMargin: 10

        SpinBox {
            id: noEpochs
            value: 5
            from: 1
            to: 100
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: 15

            Connections {
                target: noEpochs
                onValueModified: epochs = noEpochs.value
            }
        }
    }

    Label {
        id: learningRateLabel
        anchors.left: parent.left
        anchors.bottom: noEpochsLabel.top
        anchors.bottomMargin: 15
        anchors.leftMargin: 15
        color: "#273c30"
        text: qsTr("Learning Rate: ")
        font.family: "Verdana"
        font.pointSize: 12
        anchors.topMargin: 10

        SpinBox {
            id: learningRateSelector
            value: 5
            from: 0.002
            to: 0.01
            stepSize: 0.0001
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: 15

            Connections {
                target: learningRateSelector
                onValueModified: learningRate = learningRateSelector.value
            }
        }
    }

    Rectangle {
        id: dropContainer
        color: "blue"
        width: 350
        height: 300
        x: 0
        y: 400

        DropArea {
            id: dragTarget

            width: 200
            height: 300
            keys: [ colorKey ]

            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: undefined

            Rectangle {
                id: dropRectangle

                anchors.fill: parent

                color: dragTarget.containsDrag ? "grey" : colorKey
            }
        }
    }

    Rectangle {
        id: startBlockContainer
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: root.width/3
        height: root.height/5
        color: "green"

        MouseArea {
            id: startBlockMouseArea

            width: 200
            height: 150
            anchors.centerIn: parent

            drag.target: startBlock

            onReleased: parent = startBlock.Drag.target !== null ? startBlock.Drag.target : root

            Rectangle {
                id: startBlock

                width: 200
                height: 150
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: startBlockMouseArea.drag.active
                Drag.hotSpot.x: 100
                Drag.hotSpot.y: 75
                states: State {
                    when: startBlockMouseArea.drag.active
                    AnchorChanges {
                        target: startBlock
                        anchors {
                            verticalCenter: undefined
                            horizontalCenter: undefined
                        }
                    }
                }

                Label {
                    id: startBlockOutSizeLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Output Channels")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: startBlockOutSize
                    value: 16
                    from: 4
                    to: 256
                    anchors.top: startBlockOutSizeLabel.bottom
                    anchors.horizontalCenter: startBlockOutSizeLabel.horizontalCenter
                }

                Label {
                    id: startBlockDropoutLabel
                    anchors.left: parent.left
                    anchors.top: startBlockOutSize.bottom
                    color: "#273c30"
                    text: qsTr("Dropout")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10

                    Slider {
                        width: 100
                        id: startBlockDropoutSlider
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        to: 0.99
                        stepSize: 0.01
                        value: 0.1

                        Label {
                            id: startBlockDropoutSliderLabel
                            anchors.left: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#273c30"
                            text: parent.value
                            font.family: "Verdana"
                            font.pointSize: 12
                            anchors.topMargin: 10
                        }
                    }
                }

                Label {
                    id: startBlockKernelSizeLabel
                    anchors.top: startBlockDropoutLabel.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Kernel Size")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: startBlockKernelSize
                    value: 3
                    from: 1
                    to: 10
                    anchors.top: startBlockKernelSizeLabel.bottom
                    anchors.horizontalCenter: startBlockKernelSizeLabel.horizontalCenter
                }

                DropArea {
                    id: startBlockDropArea

                    width: 200
                    height: 100
                    keys: [ colorKey ]

                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: undefined

                    Rectangle {
                        id: startBlockDropRectangle

                        anchors.fill: parent

                        color: dragTarget.containsDrag ? "grey" : "yellow"
                    }
                }
            }
        }
    }

    Rectangle {
        id: middleBlockContainer
        anchors.left: startBlockContainer.right
        anchors.bottom: parent.bottom
        width: root.width/3
        height: root.height/5
        color: "red"

        DropArea {
            id: homeForLeftPiece

            width: root.width/3
            height: root.height/5
            keys: [ colorKey ]

            anchors.left: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: undefined
        }

        MouseArea {
            id: middleBlockArea1

            width: 200
            height: 150
            anchors.centerIn: parent

            drag.target: middleBlock1

            onReleased: parent = middleBlock1.Drag.target !== null ? middleBlock1.Drag.target : root

            Rectangle {
                id: middleBlock1

                width: 200
                height: 150
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: middleBlockArea1.drag.active
                Drag.hotSpot.x: 100
                Drag.hotSpot.y: 75
                states: State {
                    when: middleBlockArea1.drag.active
                    AnchorChanges {
                        target: middleBlock1
                        anchors {
                            verticalCenter: undefined
                            horizontalCenter: undefined
                        }
                    }
                }

                Label {
                    id: middleBlock1OutSizeLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Output Channels")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: middleBlock1OutSize
                    value: 16
                    from: 4
                    to: 256
                    anchors.top: middleBlock1OutSizeLabel.bottom
                    anchors.horizontalCenter: middleBlock1OutSizeLabel.horizontalCenter
                }

                Label {
                    id: middleBlock1DropoutLabel
                    anchors.left: parent.left
                    anchors.top: middleBlock1OutSize.bottom
                    color: "#273c30"
                    text: qsTr("Dropout")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10

                    Slider {
                        width: 100
                        id: middleBlock1DropoutSlider
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        to: 0.99
                        stepSize: 0.01
                        value: 0.1

                        Label {
                            id: middleBlock1DropoutSliderLabel
                            anchors.left: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#273c30"
                            text: parent.value
                            font.family: "Verdana"
                            font.pointSize: 12
                            anchors.topMargin: 10
                        }
                    }
                }

                Label {
                    id: middleBlock1KernelSizeLabel
                    anchors.top: middleBlock1DropoutLabel.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Kernel Size")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: middleBlock1KernelSize
                    value: 3
                    from: 1
                    to: 10
                    anchors.top: middleBlock1KernelSizeLabel.bottom
                    anchors.horizontalCenter: middleBlock1KernelSizeLabel.horizontalCenter
                }

                DropArea {
                    id: middleBlockDropArea1

                    width: 200
                    height: 100
                    keys: [ colorKey ]

                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: undefined

                    Rectangle {
                        id: middleBlock1Connector

                        anchors.fill: parent

                        color: dragTarget.containsDrag ? "grey" : "yellow"
                    }
                }
            }
        }

        MouseArea {
            id: middleBlockArea2

            width: 200
            height: 150
            anchors.centerIn: parent

            drag.target: middleBlock2

            onReleased: parent = middleBlock2.Drag.target !== null ? middleBlock2.Drag.target : root

            Rectangle {
                id: middleBlock2

                width: 200
                height: 150
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: middleBlockArea2.drag.active
                Drag.hotSpot.x: 100
                Drag.hotSpot.y: 75
                states: State {
                    when: middleBlockArea2.drag.active
                    AnchorChanges {
                        target: middleBlock2
                        anchors {
                            verticalCenter: undefined
                            horizontalCenter: undefined
                        }
                    }
                }

                Label {
                    id: middleBlock2OutSizeLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Output Channels")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: middleBlock2OutSize
                    value: 16
                    from: 4
                    to: 256
                    anchors.top: middleBlock2OutSizeLabel.bottom
                    anchors.horizontalCenter: middleBlock2OutSizeLabel.horizontalCenter
                }

                Label {
                    id: middleBlock2DropoutLabel
                    anchors.left: parent.left
                    anchors.top: middleBlock2OutSize.bottom
                    color: "#273c30"
                    text: qsTr("Dropout")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10

                    Slider {
                        width: 100
                        id: middleBlock2DropoutSlider
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        to: 0.99
                        stepSize: 0.01
                        value: 0.1

                        Label {
                            id: middleBlock2DropoutSliderLabel
                            anchors.left: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#273c30"
                            text: parent.value
                            font.family: "Verdana"
                            font.pointSize: 12
                            anchors.topMargin: 10
                        }
                    }
                }

                Label {
                    id: middleBlock2KernelSizeLabel
                    anchors.top: middleBlock2DropoutLabel.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Kernel Size")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: middleBlock2KernelSize
                    value: 3
                    from: 1
                    to: 10
                    anchors.top: middleBlock2KernelSizeLabel.bottom
                    anchors.horizontalCenter: middleBlock2KernelSizeLabel.horizontalCenter
                }

                DropArea {
                    id: middleBlockDropArea2

                    width: 200
                    height: 100
                    keys: [ colorKey ]

                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: undefined

                    Rectangle {
                        id: middleBlock2Connector

                        anchors.fill: parent

                        color: dragTarget.containsDrag ? "grey" : "yellow"
                    }
                }
            }
        }

        MouseArea {
            id: middleBlockArea3

            width: 200
            height: 150
            anchors.centerIn: parent

            drag.target: middleBlock3

            onReleased: parent = middleBlock3.Drag.target !== null ? middleBlock3.Drag.target : root

            Rectangle {
                id: middleBlock3

                width: 200
                height: 150
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: middleBlockArea3.drag.active
                Drag.hotSpot.x: 100
                Drag.hotSpot.y: 75
                states: State {
                    when: middleBlockArea3.drag.active
                    AnchorChanges {
                        target: middleBlock3
                        anchors {
                            verticalCenter: undefined
                            horizontalCenter: undefined
                        }
                    }
                }

                Label {
                    id: middleBlock3OutSizeLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Output Channels")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: middleBlock3OutSize
                    value: 16
                    from: 4
                    to: 256
                    anchors.top: middleBlock3OutSizeLabel.bottom
                    anchors.horizontalCenter: middleBlock3OutSizeLabel.horizontalCenter
                }

                Label {
                    id: middleBlock3DropoutLabel
                    anchors.left: parent.left
                    anchors.top: middleBlock3OutSize.bottom
                    color: "#273c30"
                    text: qsTr("Dropout")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10

                    Slider {
                        width: 100
                        id: middleBlock3DropoutSlider
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        to: 0.99
                        stepSize: 0.01
                        value: 0.1

                        Label {
                            id: middleBlock3DropoutSliderLabel
                            anchors.left: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#273c30"
                            text: parent.value
                            font.family: "Verdana"
                            font.pointSize: 12
                            anchors.topMargin: 10
                        }
                    }
                }

                Label {
                    id: middleBlock3KernelSizeLabel
                    anchors.top: middleBlock3DropoutLabel.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Kernel Size")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: middleBlock3KernelSize
                    value: 3
                    from: 1
                    to: 10
                    anchors.top: middleBlock3KernelSizeLabel.bottom
                    anchors.horizontalCenter: middleBlock3KernelSizeLabel.horizontalCenter
                }

                DropArea {
                    id: middleBlockDropArea3

                    width: 200
                    height: 100
                    keys: [ colorKey ]

                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: undefined

                    Rectangle {
                        id: middleBlock3Connector

                        anchors.fill: parent

                        color: dragTarget.containsDrag ? "grey" : "yellow"
                    }
                }
            }
        }

        MouseArea {
            id: middleBlockArea4

            width: 200
            height: 150
            anchors.centerIn: parent

            drag.target: middleBlock4

            onReleased: parent = middleBlock4.Drag.target !== null ? middleBlock4.Drag.target : root

            Rectangle {
                id: middleBlock4

                width: 200
                height: 150
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: middleBlockArea4.drag.active
                Drag.hotSpot.x: 100
                Drag.hotSpot.y: 75
                states: State {
                    when: middleBlockArea4.drag.active
                    AnchorChanges {
                        target: middleBlock4
                        anchors {
                            verticalCenter: undefined
                            horizontalCenter: undefined
                        }
                    }
                }

                Label {
                    id: middleBlock4OutSizeLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Output Channels")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: middleBlock4OutSize
                    value: 16
                    from: 4
                    to: 256
                    anchors.top: middleBlock4OutSizeLabel.bottom
                    anchors.horizontalCenter: middleBlock4OutSizeLabel.horizontalCenter
                }

                Label {
                    id: middleBlock4DropoutLabel
                    anchors.left: parent.left
                    anchors.top: middleBlock4OutSize.bottom
                    color: "#273c30"
                    text: qsTr("Dropout")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10

                    Slider {
                        width: 100
                        id: middleBlock4DropoutSlider
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        to: 0.99
                        stepSize: 0.01
                        value: 0.1

                        Label {
                            id: middleBlock4DropoutSliderLabel
                            anchors.left: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#273c30"
                            text: parent.value
                            font.family: "Verdana"
                            font.pointSize: 12
                            anchors.topMargin: 10
                        }
                    }
                }

                Label {
                    id: middleBlock4KernelSizeLabel
                    anchors.top: middleBlock4DropoutLabel.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Kernel Size")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: middleBlock4KernelSize
                    value: 3
                    from: 1
                    to: 10
                    anchors.top: middleBlock4KernelSizeLabel.bottom
                    anchors.horizontalCenter: middleBlock4KernelSizeLabel.horizontalCenter
                }

                DropArea {
                    id: middleBlockDropArea4

                    width: 200
                    height: 100
                    keys: [ colorKey ]

                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: undefined

                    Rectangle {
                        id: middleBlock4Connector

                        anchors.fill: parent

                        color: dragTarget.containsDrag ? "grey" : "yellow"
                    }
                }
            }
        }

        MouseArea {
            id: middleBlockArea5

            width: 200
            height: 150
            anchors.centerIn: parent

            drag.target: middleBlock5

            onReleased: parent = middleBlock5.Drag.target !== null ? middleBlock5.Drag.target : root

            Rectangle {
                id: middleBlock5

                width: 200
                height: 150
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: middleBlockArea5.drag.active
                Drag.hotSpot.x: 100
                Drag.hotSpot.y: 75
                states: State {
                    when: middleBlockArea5.drag.active
                    AnchorChanges {
                        target: middleBlock5
                        anchors {
                            verticalCenter: undefined
                            horizontalCenter: undefined
                        }
                    }
                }

                Label {
                    id: middleBlock5OutSizeLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Output Channels")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: middleBlock5OutSize
                    value: 16
                    from: 4
                    to: 256
                    anchors.top: middleBlock5OutSizeLabel.bottom
                    anchors.horizontalCenter: middleBlock5OutSizeLabel.horizontalCenter
                }

                Label {
                    id: middleBlock5DropoutLabel
                    anchors.left: parent.left
                    anchors.top: middleBlock5OutSize.bottom
                    color: "#273c30"
                    text: qsTr("Dropout")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10

                    Slider {
                        width: 100
                        id: middleBlock5DropoutSlider
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        to: 0.99
                        stepSize: 0.01
                        value: 0.1

                        Label {
                            id: middleBlock5DropoutSliderLabel
                            anchors.left: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#273c30"
                            text: parent.value
                            font.family: "Verdana"
                            font.pointSize: 12
                            anchors.topMargin: 10
                        }
                    }
                }

                Label {
                    id: middleBlock5KernelSizeLabel
                    anchors.top: middleBlock5DropoutLabel.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Kernel Size")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: middleBlock5KernelSize
                    value: 3
                    from: 1
                    to: 10
                    anchors.top: middleBlock5KernelSizeLabel.bottom
                    anchors.horizontalCenter: middleBlock5KernelSizeLabel.horizontalCenter
                }

                DropArea {
                    id: middleBlockDropArea5

                    width: 200
                    height: 100
                    keys: [ colorKey ]

                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: undefined

                    Rectangle {
                        id: middleBlock5Connector

                        anchors.fill: parent

                        color: dragTarget.containsDrag ? "grey" : "yellow"
                    }
                }
            }
        }
    }

    Rectangle {
        id: mouseArea3Container
        anchors.left: middleBlockContainer.right
        anchors.bottom: parent.bottom
        width: root.width/3
        height: root.height/5
        color: "blue"

        DropArea {
            id: homeForRightPiece

            width: root.width/3
            height: root.height/5
            keys: [ colorKey ]

            anchors.left: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: undefined
        }

        MouseArea {
            id: mouseArea3

            width: 200
            height: 150
            anchors.centerIn: parent

            drag.target: tile3

            onReleased: parent = tile3.Drag.target !== null ? tile3.Drag.target : root

            Rectangle {
                id: tile3
                width: 200
                height: 150
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: mouseArea3.drag.active
                Drag.hotSpot.x: 200
                Drag.hotSpot.y: 100
                states: State {
                    when: mouseArea3.drag.active
                    AnchorChanges {
                        target: tile3
                        anchors {
                            verticalCenter: undefined
                            horizontalCenter: undefined
                        }
                    }
                }

                Label {
                    id: endBlockDropoutLabel
                    anchors.left: parent.left
                    anchors.top: parent.top
                    color: "#273c30"
                    text: qsTr("Dropout")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10

                    Slider {
                        width: 100
                        id: endBlockDropoutSlider
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        to: 0.99
                        stepSize: 0.01
                        value: 0.1

                        Label {
                            id: endBlockDropoutSliderLabel
                            anchors.left: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#273c30"
                            text: parent.value
                            font.family: "Verdana"
                            font.pointSize: 12
                            anchors.topMargin: 10
                        }
                    }
                }

                Label {
                    id: endBlockKernelSizeLabel
                    anchors.top: endBlockDropoutLabel.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#273c30"
                    text: qsTr("Kernel Size")
                    font.family: "Verdana"
                    font.pointSize: 12
                    anchors.topMargin: 10
                }

                SpinBox {
                    id: endBlockKernelSize
                    value: 3
                    from: 1
                    to: 10
                    anchors.top: endBlockKernelSizeLabel.bottom
                    anchors.horizontalCenter: endBlockKernelSizeLabel.horizontalCenter
                }
            }
        }
    }

    Button {
        id: finish
        width: 128
        height: 64
        text: qsTr("Finish")
        font.pixelSize: 35
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.bottom: mouseArea3Container.top
        anchors.bottomMargin: 15

        background: Rectangle {
            color: "darkgreen"
            radius: 25
        }

        onClicked: {
            getAllData()
            root.isDone = true
        }
    }

    function getAllData() {
        array = [[startBlockOutSize.value, startBlockKernelSize.value, startBlockDropoutSlider.value]]
        if (middleBlockArea5.parent != middleBlockContainer) {
            array.push([middleBlock5OutSize.value, middleBlock5KernelSize.value, middleBlock5DropoutSlider.value]);
        }
        if (middleBlockArea4.parent != middleBlockContainer) {
            array.push([middleBlock4OutSize.value, middleBlock4KernelSize.value, middleBlock4DropoutSlider.value]);
        }
        if (middleBlockArea3.parent != middleBlockContainer) {
            array.push([middleBlock3OutSize.value, middleBlock3KernelSize.value, middleBlock3DropoutSlider.value]);
        }
        if (middleBlockArea2.parent != middleBlockContainer) {
            array.push([middleBlock2OutSize.value, middleBlock2KernelSize.value, middleBlock2DropoutSlider.value]);
        }
        if (middleBlockArea1.parent != middleBlockContainer) {
            array.push([middleBlock1OutSize.value, middleBlock1KernelSize.value, middleBlock1DropoutSlider.value]);
        }
        array.push([[-1, endBlockKernelSize.value, endBlockDropoutSlider.value]])
    }
}

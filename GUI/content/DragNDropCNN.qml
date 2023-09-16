import QtQuick 2.15

Item {
    id: root

    required property string colorKey
    required property int modelData

    width: 1920
    height: 1080

    Rectangle {
        id: dropContainer
        color: "blue"
        width: 300
        height: 256
        x: 0
        y: 400

        DropArea {
            id: dragTarget

            width: 128
            height: 256
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

            width: 128
            height: 128
            anchors.centerIn: parent

            drag.target: startBlock

            onReleased: parent = startBlock.Drag.target !== null ? startBlock.Drag.target : root

            Rectangle {
                id: startBlock

                width: 128
                height: 128
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: startBlockMouseArea.drag.active
                Drag.hotSpot.x: 64
                Drag.hotSpot.y: 64
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
                DropArea {
                    id: startBlockDropArea

                    width: 64
                    height: 64
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

            width: 128
            height: 128
            anchors.centerIn: parent

            drag.target: middleBlock1

            onReleased: parent = middleBlock1.Drag.target !== null ? middleBlock1.Drag.target : root

            Rectangle {
                id: middleBlock1

                width: 128
                height: 128
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: middleBlockArea1.drag.active
                Drag.hotSpot.x: 64
                Drag.hotSpot.y: 64
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
                DropArea {
                    id: middleBlockDropArea1

                    width: 64
                    height: 64
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

            width: 128
            height: 128
            anchors.centerIn: parent

            drag.target: middleBlock2

            onReleased: parent = middleBlock2.Drag.target !== null ? middleBlock2.Drag.target : root

            Rectangle {
                id: middleBlock2

                width: 128
                height: 128
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: middleBlockArea2.drag.active
                Drag.hotSpot.x: 64
                Drag.hotSpot.y: 64
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
                DropArea {
                    id: middleBlockDropArea2

                    width: 64
                    height: 64
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

            width: 128
            height: 128
            anchors.centerIn: parent

            drag.target: middleBlock3

            onReleased: parent = middleBlock3.Drag.target !== null ? middleBlock3.Drag.target : root

            Rectangle {
                id: middleBlock3

                width: 128
                height: 128
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: middleBlockArea3.drag.active
                Drag.hotSpot.x: 64
                Drag.hotSpot.y: 64
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
                DropArea {
                    id: middleBlockDropArea3

                    width: 64
                    height: 64
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

            width: 128
            height: 128
            anchors.centerIn: parent

            drag.target: middleBlock4

            onReleased: parent = middleBlock4.Drag.target !== null ? middleBlock4.Drag.target : root

            Rectangle {
                id: middleBlock4

                width: 128
                height: 128
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: middleBlockArea4.drag.active
                Drag.hotSpot.x: 64
                Drag.hotSpot.y: 64
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
                DropArea {
                    id: middleBlockDropArea4

                    width: 64
                    height: 64
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

            width: 128
            height: 128
            anchors.centerIn: parent

            drag.target: middleBlock5

            onReleased: parent = middleBlock5.Drag.target !== null ? middleBlock5.Drag.target : root

            Rectangle {
                id: middleBlock5

                width: 128
                height: 128
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: middleBlockArea5.drag.active
                Drag.hotSpot.x: 64
                Drag.hotSpot.y: 64
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
                DropArea {
                    id: middleBlockDropArea5

                    width: 64
                    height: 64
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

            width: 128
            height: 128
            anchors.centerIn: parent

            drag.target: tile3

            onReleased: parent = tile3.Drag.target !== null ? tile3.Drag.target : root

            Rectangle {
                id: tile3

                width: 128
                height: 128
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: root.colorKey

                Drag.keys: [ root.colorKey ]
                Drag.active: mouseArea3.drag.active
                Drag.hotSpot.x: 64
                Drag.hotSpot.y: 64
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
            }
        }
    }
}

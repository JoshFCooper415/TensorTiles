

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import FlowView 1.0

FlowView {
    width: 800
    height: 600

    defaultTransition: FlowTransition {
        id: defaultTransition
    }

    TestFlow {
        id: testFlow1
        x: 4869
        y: 4769
        width: 553
        height: 368
    }

    FlowItem {
        id: flowItem
    }
}

/*##^##
Designer {
    D{i:0}D{i:2;flowX:3902.4428688959442;flowY:3213.0055925478787}D{i:3;flowX:4292.02806375968;flowY:4109.16680693203}
}
##^##*/


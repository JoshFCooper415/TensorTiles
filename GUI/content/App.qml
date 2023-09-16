// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.2
import GUI

Window {
    width: mainScreen.width
    height: mainScreen.height

    visible: true
    title: "GUI"

    Screen02 {
        id: mainScreen
    }


    Screen01 {
        id: screen01
        x: 0
        y: 0
        visible: false
    }

}


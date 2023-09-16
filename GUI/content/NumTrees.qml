import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 1920
    height: 1080

    Slider {
        id: slider
        x: 711
        y: 408
        live: true
        orientation: Qt.Vertical
        snapMode: RangeSlider.SnapOnRelease
        value: 0.5
    }
}

import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Wayland
import "components" as Components

ShellRoot {
    id: shellRoot

    property var ctp: Components.CavaService.catppuccin
    property var gradientColors: Components.CavaService.gradientColors

    Component.onCompleted: {
        // Sử dụng timer để tránh truy cập quá sớm
        startupTimer.start()
    }

    Timer {
        id: startupTimer
        interval: 500
        onTriggered: {
            Components.CavaService.open()
        }
    }

    // Hiển thị Cava visualizer
    PanelWindow {
        id: cavaWindow
        width: 1920
        height: 400
        color: "transparent"

        WlrLayershell.layer: WlrLayer.Bottom
        WlrLayershell.anchors: WlrAnchor.Bottom | WlrAnchor.Left | WlrAnchor.Right
        WlrLayershell.exclusiveZone: 0   // không chiếm không gian ứng dụng

        anchors {
          bottom: true
          right: true
          left: true
        }

        Rectangle {
            id: cavaVisualizer
            color: "transparent"
            anchors.fill: parent
            anchors.margins: 0
            Row {
                id: cavaBars
                anchors.fill: parent
                anchors.topMargin: 30 // Để tránh debug text
                spacing: 2
                
                Repeater {
                    model: Components.CavaService.barCount
                    delegate: Rectangle {
                        width: (cavaVisualizer.width - (cavaBars.spacing * (Components.CavaService.barCount - 1))) / Components.CavaService.barCount
                        height: Components.CavaService.values[index] ? 
                               Math.max(3, Components.CavaService.values[index] * (cavaVisualizer.height / 100)) : 3
                        radius: Math.max(1, width * 0.3)
                        anchors.bottom: parent.bottom
                        
                        color: getBarColor(index)
                        
                        Behavior on height {
                            NumberAnimation { duration: 100; easing.type: Easing.OutCubic }
                        }
                    }
                }
            }
        }
    }
    
    // Hàm lấy màu đơn giản
    function getBarColor(index) {
        if (!gradientColors || gradientColors.length === 0) return ctp.blue
        
        var colorIndex = Math.floor((index / Components.CavaService.barCount) * gradientColors.length)
        return gradientColors[colorIndex % gradientColors.length]
    }
}

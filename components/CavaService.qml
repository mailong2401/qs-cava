pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int barCount: 64
    property var values: []
    property bool isRunning: false
    
    // Catppuccin Macchiato Color Palette
    property var catppuccin: ({
      "c1": "#8E51FF",
      "c2" : "#615FFF",
      "c3" : "#2B7FFF",
      "c4" : "#34A6F4",
      "c5" : "#3BB8DB",
      "c6" : "#34A6F4",
      "c7" : "#37BC7D",
      "c8" : "#31C950",
      "c9" : "#7CCF35",
      "c10": "#F0B13B",
      "c11" : "#FE9A37",
      "c12" : "#FF692A",
      "c13" : "#FB2C36"
    })


    property var gradientColors: [
        catppuccin.c1,
        catppuccin.c1,
        catppuccin.c2,
        catppuccin.c2,
        catppuccin.c3,
        catppuccin.c3,
        catppuccin.c4,
        catppuccin.c5,
        catppuccin.c6,
        catppuccin.c7,
        catppuccin.c8,
        catppuccin.c9,
        catppuccin.c10,
        catppuccin.c11,
        catppuccin.c12,
        catppuccin.c13,
        catppuccin.c13,
        catppuccin.c12,
        catppuccin.c11,
        catppuccin.c10,
        catppuccin.c9,
        catppuccin.c8,
        catppuccin.c7,
        catppuccin.c6,
        catppuccin.c5,
        catppuccin.c4,
        catppuccin.c3,
        catppuccin.c3,
        catppuccin.c2,
        catppuccin.c2,
        catppuccin.c1,
        catppuccin.c1,
    ]

    Component.onCompleted: {
        console.log("🎵 CavaService initialized")
        initializeValues()
    }

    function initializeValues() {
        let arr = []
        for (let i = 0; i < barCount; i++) {
            arr.push(2)
        }
        values = arr
    }

    Process {
        id: cavaProc
        running: false

        command: [
            "sh", "-c",
            `printf '[general]
framerate=25
bars=${root.barCount}
autosens=1
[smoothing]
noise_reduction=50
[output]
method=raw
raw_target=/dev/stdout
data_format=ascii
ascii_max_range=100
bit_format=8bit' | cava -p /dev/stdin`
        ]

        stdout: SplitParser {
            onRead: function(data) {
                let lines = data.split("\n")
                for (let i = 0; i < lines.length; i++) {
                    let line = lines[i].trim()
                    if (line === "") continue
                    
                    try {
                        let newValues = line.split(";")
                            .filter(val => val.trim() !== "")
                            .map(val => {
                                let num = parseInt(val, 10)
                                return isNaN(num) ? 2 : Math.max(2, Math.min(num, 200))
                            })
                        
                        if (newValues.length >= root.barCount) {
                            root.values = newValues.slice(0, root.barCount)
                        }
                    } catch (error) {
                        console.error("Error parsing CAVA data:", error)
                    }
                }
            }
        }

        onRunningChanged: {
            if (running) {
                console.log("🎵 CAVA process started")
            } else {
                console.log("🔇 CAVA process stopped")
                initializeValues()
            }
        }
    }

    function open() {
        console.log("🎵 Opening CAVA visualizer...")
        initializeValues()
        cavaProc.running = true
    }

    function close() {
        console.log("🔇 Closing CAVA visualizer...")
        cavaProc.running = false
        initializeValues()
    }
}

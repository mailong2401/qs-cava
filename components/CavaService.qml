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
    "rosewater": "#ffd1dc",  // sáng hơn, hồng kem
    "flamingo": "#f9a5ac",   // đỏ cam sáng
    "pink": "#ffb3f4",       // hồng sáng
    "mauve": "#caa9ff",      // tím hoa cà đậm
    "red": "#ff6b6b",        // đỏ neon
    "maroon": "#f08484",     // đỏ đất hồng
    "peach": "#ffb380",      // cam đào sáng
    "yellow": "#ffe97f",     // vàng pastel
    "green": "#9fffa9",      // xanh lá sáng
    "teal": "#7fffe0",       // xanh ngọc sáng
    "sky": "#7fd9ff",        // xanh da trời
    "sapphire": "#67b7ff",   // xanh lam đậm hơn
    "blue": "#6b8fff",       // xanh dương rực
    "lavender": "#a99fff",   // tím nhạt
    "text": "#dce3ff",       // chữ sáng
    "subtext1": "#bfc6e8",
    "subtext0": "#9fa6c0",
    "overlay2": "#8a91b0",
    "overlay1": "#757ca0",
    "overlay0": "#62678a",
    "surface2": "#4e526e",
    "surface1": "#3e4157",
    "surface0": "#2c2e42",
    "base": "#1f2130",       // nền hơi xanh xám
    "mantle": "#1a1b28",
    "crust": "#141520"
})


    property var gradientColors: [
        catppuccin.sapphire,    // Xanh lạnh
        catppuccin.blue,        // Xanh dương
        catppuccin.sky,         // Xanh da trời
        catppuccin.teal,        // Xanh ngọc
        catppuccin.lavender,    // Tím oải hương
        catppuccin.mauve,       // Tím hoa cà
        catppuccin.green,       // Xanh lá (trung tính)
        catppuccin.yellow,      // Vàng (bắt đầu ấm)
        catppuccin.peach,       // Cam đào
        catppuccin.maroon,      // Hồng đất
        catppuccin.red,         // Đỏ
        catppuccin.pink,        // Hồng
        catppuccin.flamingo,    // Hồng flamingo
        catppuccin.rosewater    // Hồng nhạt ấm
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

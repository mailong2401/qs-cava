
# 🎵 Cava Visualizer for Quickshell

Hiển thị sóng nhạc động ngay trên desktop (ở lớp `Bottom`) sử dụng **CAVA** kết hợp **Quickshell (QML)** — nhẹ, đẹp và mượt mà.

---

## ⚙️ Cài đặt

### 🐧 Arch Linux / Manjaro
```bash
sudo pacman -S cava
yay -S quickshell-git
# hoặc
paru -S quickshell-git
```

### 🧱 Ubuntu / Debian
```bash
sudo apt install cava
```

> ⚠️ Quickshell hiện chưa có gói chính thức trên Ubuntu — bạn có thể tự build từ mã nguồn.

---

## 🧠 Cấu hình CAVA

Không cần tạo file `~/.config/cava/config`.  
Toàn bộ cấu hình được truyền trực tiếp qua `stdin` trong mã:

```ini
[general]
framerate=25
bars=64
autosens=1

[smoothing]
noise_reduction=50

[output]
method=raw
raw_target=/dev/stdout
data_format=ascii
ascii_max_range=100
bit_format=8bit
```

Nếu muốn tùy chỉnh hoặc thử nghiệm, bạn vẫn có thể tạo thủ công file cấu hình này trong thư mục `~/.config/cava/`.

---

## 🚀 Khởi chạy Visualizer

Chạy shell của bạn bằng lệnh:
```bash
quickshell shell.qml
```

Visualizer sẽ tự động khởi động sau khi shell load, hiển thị hiệu ứng sóng nhạc ở dưới cùng màn hình (phía sau ứng dụng và cửa sổ).

---

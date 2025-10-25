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

### Cách 1 — Chạy trực tiếp bằng `quickshell`

```bash
quickshell shell.qml
```

### Cách 2 — Sử dụng lệnh `qs -p`

Nếu bạn đã cài `qs` (trình quản lý profile của Quickshell), bạn có thể chạy trực tiếp từ thư mục dự án:

```bash
qs -p đường-dẫn/qs-cava
```

Ví dụ:

```bash
qs -p ~/Projects/qs-cava
```

Lệnh này sẽ tự động mở shell `shell.qml` trong thư mục đó.

Visualizer sẽ hiển thị sóng nhạc ở dưới cùng màn hình, phía sau các ứng dụng và cửa sổ khác.

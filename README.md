# Flutter Labs

## Lab 1 — I Am Rich

Đây là ứng dụng Flutter Lab 1 với giao diện **I Am Rich**, hỗ trợ Android,
iOS và Web. Ứng dụng minh họa các thành phần Flutter cơ bản:

- `MaterialApp` quản lý cấu hình và giao diện chung của ứng dụng.
- `Scaffold` tạo bố cục màn hình.
- `AppBar` hiển thị tiêu đề **I Am Rich**.
- `Image.asset` tải ảnh kim cương từ `images/diamond.png`.

## Chạy trên trình duyệt

Không cần điện thoại hoặc máy ảo. Sau khi cài Flutter, chạy các lệnh sau để
mở ứng dụng bằng Chrome:

```bash
flutter pub get
flutter run -d chrome
```

Để sử dụng Microsoft Edge, thay lệnh cuối bằng `flutter run -d edge`. Trong
khi ứng dụng đang chạy, nhấn `r` để hot reload và `q` để dừng.

## Kiểm thử

Chạy widget test bằng lệnh:

```bash
flutter test
```

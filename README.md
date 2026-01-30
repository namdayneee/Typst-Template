# Hướng dẫn sử dụng Typst qua giao diện dòng lệnh (CLI)

## Giới thiệu

Tài liệu này hướng dẫn cách khởi tạo và biên dịch dự án Typst thông qua giao diện dòng lệnh (CLI).

## Yêu cầu

- Đã cài đặt [Typst](https://typst.app/) trên máy tính

## Khởi tạo dự án mới

### Cú pháp chung

```bash
typst init @preview/template-name
```

### Ví dụ thực tế

Để bắt đầu một dự án báo cáo cơ bản:

```bash
typst init @preview/basic-report my-report
cd my-report
typst compile main.typ
```

**Giải thích:**
- `typst init` - Tạo một thư mục mới và tải các tệp mẫu
- `typst compile` - Biên dịch dự án thành file PDF

## Các mẫu báo cáo phổ biến trên Typst Universe

| Tên mẫu | Mô tả |
|---------|-------|
| `basic-report` | Mẫu đơn giản, phù hợp cho tài liệu phi hư cấu, sách hướng dẫn hoặc bài tập sinh viên |
| `charged-ieee` | Mẫu theo chuẩn IEEE, phù hợp cho các bài báo khoa học và nghiên cứu |
| `modern-cv` | Mẫu CV/Resume hiện đại, chuyên nghiệp |
| `ilm` | Mẫu sách/tài liệu dài với mục lục, chú thích bên lề |
| `codly` | Mẫu hỗ trợ hiển thị code đẹp với syntax highlighting |

## Mẫu dành cho các trường đại học Việt Nam

### Đại học Bách khoa TP.HCM (HCMUT)

Hiện tại Typst Universe chưa có mẫu chính thức cho HCMUT. Bạn có thể:

1. **Tự tạo mẫu** dựa trên `basic-report` và tùy chỉnh theo quy định của trường
2. **Sử dụng mẫu cộng đồng** (nếu có) trên GitHub với từ khóa "typst hcmut" hoặc "typst bku"

**Gợi ý cấu trúc báo cáo HCMUT:**
- Trang bìa với logo trường Bách khoa
- Thông tin: Khoa, Bộ môn, Tên môn học
- Họ tên sinh viên, MSSV, Lớp
- Giảng viên hướng dẫn
- Năm học

### Mẫu quốc tế tham khảo

- `haw-hamburg-report` - Đại học Khoa học Ứng dụng Hamburg
- `simple-ntnu-report` - Đại học Khoa học và Công nghệ Na Uy (NTNU)
- `modern-sjtu-report` - Đại học Giao thông Thượng Hải (phong cách châu Á)

## Tài nguyên

- [Typst Universe](https://typst.app/universe) - Kho mẫu và gói mở rộng
- [Tài liệu Typst](https://typst.app/docs) - Hướng dẫn chính thức

## Giấy phép

Dự án này được phân phối theo giấy phép MIT.

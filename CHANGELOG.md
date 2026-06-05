# CHANGELOG

## 2026-06-05 - DCorp Brand Redesign

### Added
- Tạo lại nhận diện website DCorp theo phong cách B2B cao cấp cho lĩnh vực xăng dầu, hóa dầu, hạt nhựa công nghiệp và logistics năng lượng.
- Thêm trang `career.html` cho mục "Gia nhập DCorp".
- Thêm trang `gallery.html` cho thư viện ảnh doanh nghiệp.
- Thêm favicon `favicon.ico` từ logo DCorp.
- Thêm ảnh Open Graph `og_image.png` kích thước 1200x630.
- Bổ sung metadata SEO, Open Graph và mô tả trang.

### Changed
- Thiết kế lại Header:
  - Bố cục mới: Logo + DCORP + tagline "Thương mại và Dầu khí".
  - Header cao 85px trên desktop.
  - Logo cao 60px, `max-width: 60px`, `object-fit: contain`, giữ đúng tỷ lệ vuông.
  - Màu thương hiệu: `#003A99`.
  - Tagline màu `#666666`.
- Thiết kế lại Footer:
  - 4 cột: thương hiệu, sản phẩm, dịch vụ, liên hệ/mạng xã hội.
  - Logo footer cao 70px, `max-width: 70px`, giữ đúng tỷ lệ.
- Chuẩn hóa hệ màu:
  - Primary: `#003A99`
  - Secondary: `#0B6DDB`
  - Accent: `#FF9900`
  - Accent Dark: `#F57C00`
  - Background: `#FFFFFF`
  - Section Background: `#F5F7FA`
  - Text: `#1A1A1A`
- Typography chuyển sang `Plus Jakarta Sans`.
- Thiết kế lại Hero section với thông điệp B2B chuyên nghiệp.
- Thiết kế lại Product Cards gồm: Dầu DO, Dầu FO, Dầu nhờn, PP, PE, ABS.
- Hover card dùng border cam và shadow nhẹ.
- Responsive menu tối ưu cho tablet/mobile.

### Fixed
- Sửa lỗi logo bị kéo dài ngang bằng cách thêm `max-width` cho `.logo-img`.
- Sửa lỗi logo có nguy cơ bị ép méo bằng `height`, `width:auto`, `object-fit:contain`.
- Sửa nhận diện cũ không đồng bộ với DCorp.
- Sửa thiếu favicon và Open Graph image.
- Sửa thiếu meta description cho trang chính.
- Cải thiện độ tương phản màu chữ, CTA, section label.

### Notes
- Deploy production chưa thực hiện vì chưa tìm thấy cấu hình hoặc lệnh deploy trong workspace hiện tại.

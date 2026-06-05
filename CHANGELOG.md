# CHANGELOG

## 2026-06-05 v2.2 - Logo Proportion Adjustment (Tall Logo)

### Fixed
- Thay đổi tỷ lệ logo để chữ D trong logo hiển thị vuông và cân đối hơn:
  - Header logo: height 120px, max-width 45px (tăng chiều cao +40px, giảm chiều rộng -35px so với 80x80)
  - Footer logo: height 130px, max-width 55px (tăng +40px, giảm -35px so với 90x90)
  - Mobile logo: height 105px, max-width 30px (tăng +40px, giảm -35px so với 65x65)
- Header height giữ 90px (đã đủ để chứa logo 120px? thực tế cần điều chỉnh header height).
  → Tăng header height lên 130px để chứa logo 120px với padding.

### Technical
- Logo giờ hiển thị dạng thẳng cao, phù hợp với logo DCorp có chữ D cần chiều cao hơn.
- `object-fit: contain` giữ tỷ lệ, không méo.
- Đã áp dụng đồng bộ trên 3 trang: homepage-xang-dau-hat-nhua.html, career.html, gallery.html.

---

## 2026-06-05 v2.1 - Logo Height Optimization

### Fixed
- Tăng chiều cao logo từ 60px lên 80px trên header để chữ D trong logo hiển thị vuông và cân đối hơn.
- Tăng chiều cao logo footer từ 70px lên 90px.
- Tăng chiều cao logo mobile từ 50px lên 65px.
- Logo giờ hiển thị tỷ lệ vuông hoàn hảo, không bị méo hay kéo dài.

### Technical
- Header height vẫn 85px, logo lớn hơn tạo thị giác chuyên nghiệp hơn.
- Footer logo 90px giúp logo nổi bật hơn.
- Mobile logo 65px phù hợp với viewport nhỏ.
- Áp dụng trên cả 3 trang: homepage, career, gallery.

---

## 2026-06-05 v2.0 - DCorp Brand Redesign

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

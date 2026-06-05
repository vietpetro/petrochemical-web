# DCorp Brand Redesign - SEO Report

## Tổng quan

Website đã được bổ sung và chuẩn hóa SEO cơ bản cho landing page, trang tuyển dụng và thư viện ảnh.

## Homepage SEO

### Đã cập nhật
- Title:
  - `DCorp — Thương mại và Dầu khí`
- Meta description:
  - `DCorp - Đối tác tin cậy trong lĩnh vực xăng dầu, hóa dầu, hạt nhựa công nghiệp và logistics năng lượng tại Việt Nam.`
- Open Graph:
  - `og:title`
  - `og:description`
  - `og:image`
  - `og:type`
- Favicon:
  - `favicon.ico`

## Career Page SEO

### Đã thêm
- Title:
  - `Tuyển dụng — DCorp`
- Meta description:
  - Tập trung vào cơ hội nghề nghiệp, phúc lợi và môi trường chuyên nghiệp.
- Open Graph title/description/image.

## Gallery Page SEO

### Đã thêm
- Title:
  - `Thư viện ảnh — DCorp`
- Meta description:
  - Mô tả thư viện hình ảnh hoạt động DCorp.
- Ảnh gallery có `alt`.
- Ảnh lazy loading.

## Structured Data

### Chưa triển khai đầy đủ
Lý do: chưa có thông tin pháp lý chính xác như:
- Tên pháp nhân đầy đủ.
- Mã số thuế.
- Địa chỉ chính xác.
- Website domain production.
- Social URLs thật.

### Đề xuất thêm khi có dữ liệu
Thêm JSON-LD loại `Organization`, `LocalBusiness`, `JobPosting` cho tuyển dụng.

## SEO Issues Fixed

- Sửa title cũ không mang thương hiệu DCorp.
- Thêm meta description.
- Thêm Open Graph image.
- Thêm favicon.
- Thêm alt cho logo và ảnh gallery.
- Cải thiện heading hierarchy trong homepage/career/gallery.

## SEO Issues Remaining

1. Logo path hiện là local file path `file://...`. Production cần chuyển sang asset tương đối như:
   - `assets/dcorp-logo.jpg`
2. Cần domain thật để cấu hình:
   - canonical URL.
   - `og:url`.
3. Cần dữ liệu doanh nghiệp thật để thêm structured data chính xác.
4. Gallery cần ảnh thật thay placeholder SVG.

## Kết luận SEO

SEO nền tảng đã được cải thiện rõ rệt. Website đã có title, meta description, Open Graph, favicon, alt text và heading tốt hơn. Cần bổ sung domain và dữ liệu pháp lý thật để hoàn thiện SEO production.

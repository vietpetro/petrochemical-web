# 📋 TRÀ VÀ NGƯỜI — Content Index

> **Khởi tạo:** 13/05/2026
> **Ngày bắt đầu đăng:** 14/05/2026 (Thứ Năm)
> **Trạng thái:** ✅ ĐANG HOẠT ĐỘNG
> **Page ID:** 1158980210638306
> **Token:** ✅ Active (pages_manage_posts, pages_read_engagement, pages_show_list)

## Cấu trúc thư mục

```
TraVaNguoi/
├── INDEX.md                     ← File này
├── 90Day_Strategy.md            ← Kế hoạch tổng thể
├── CONFIG.ps1                   ← Cấu hình token
├── post_travanguoi.ps1          ← Script đăng bài tự động
├── content/                     ← Nội dung đã viết
│   ├── Ngay1/                   ← 14/05 (Thứ Năm)
│   ├── Ngay2/
│   ├── ...
│   └── Ngay7/
├── reports/                     ← Báo cáo hàng tuần
│   └── BaoCaoTuan1.md
└── media/                       ← (Tạo sau) Ảnh/video hoàn chỉnh
```

## Tiến độ

| Tuần | Ngày | Content | Video | Status |
|------|------|---------|-------|--------|
| 1 | Day 1-7 (14/05-20/05) | ✅ 28/28 bài | ✅ 7 kịch bản | Sẵn sàng |
| 2 | Day 8-14 | ⏳ Cron 21h mỗi tối | ⏳ | Tự động |
| ... | ... | ... | ... | ... |

## Cron jobs

| Job | Lịch | Mô tả |
|-----|------|-------|
| Sinh content ngày mới | 21:00 mỗi ngày | Tạo 3 bài + 1 video cho ngày mai |
| Draft 06:20 | 06:20 mỗi ngày | Gửi draft bài 06:30 để duyệt |
| Draft 11:20 | 11:20 mỗi ngày | Gửi draft bài 11:30 để duyệt |
| Draft 20:20 | 20:20 mỗi ngày | Gửi draft bài 20:30 để duyệt |
| Báo cáo Chủ nhật | 20:00 CN hàng tuần | Phân tích KPI + đề xuất |

## Kết quả test

- ✅ 13/05 Test đăng bài API → thành công (Post ID: 1158980210638306_122097790815318532)
- ✅ Page Token có đủ quyền: CREATE_CONTENT, MANAGE, MODERATE, ANALYZE, ADVERTISE
- ✅ User Token có scopes: pages_show_list, pages_manage_posts, pages_read_engagement, business_management

## Fanpage đã setup

- [x] Tạo Facebook Page "Trà và Người" → https://www.facebook.com/profile.php?id=61589555976603
- [x] Cấp quyền API (pages_manage_posts, pages_read_engagement)
- [x] Cấu hình App Dashboard → Use case "Quản lý Trang"
- [x] OAuth hoàn tất → Token đầy đủ quyền
- [ ] Kết nối TikTok (giai đoạn 2)
- [ ] Google Drive backup content

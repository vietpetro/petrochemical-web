# Crystal Token Scout - Hướng Dẫn Vận Hành

## Tổng Quan

Hệ thống tự động truy tìm, đánh giá và báo cáo các token cryptocurrency thuộc hệ sinh thái "crystal" (crystal token, crystal coin, các token liên quan).

## Thời Gian Hoạt Động

- **Tìm kiếm định kỳ:** 00:00 – 05:00 (giờ Asia/Saigon), mỗi 20 phút
- **Báo cáo cuối ngày:** 05:15
- **Chu kỳ này chạy:** 15 vòng tìm kiếm + 1 vòng báo cáo

## Cấu Trúc Thư Mục

```
/workspace/
├── crystal_scout_instructions.md   ← Tập tin này
├── reports/crystal/
│   ├── database_checked_tokens.json   ← CSDL token đã kiểm tra
│   ├── checked_contracts.txt          ← Danh sách contract address đã check
│   ├── search_results/                ← Thư mục lưu kết quả tạm
│   │   └── session_YYYYMMDD_HHMM.json
│   ├── crystal_report_YYYYMMDD.md     ← Báo cáo cuối ngày (Markdown)
│   └── crystal_report_YYYYMMDD.json   ← Báo cáo cuối ngày (JSON)
```

## Quy Trình Mỗi Chu Kỳ Tìm Kiếm

### Bước 1: Load CSDL
- Đọc `database_checked_tokens.json` để biết token nào đã kiểm tra
- Đọc `checked_contracts.txt` để biết contract nào đã check

### Bước 2: Tìm Kiếm Token Mới

Tìm kiếm trên các nguồn sau:

#### a) Web Search
Dùng `web_search` với các từ khóa:
- "crystal token crypto"
- "crystal coin new launch"
- "crystal defi token"
- "new crystal token blockchain"
- "crystal ecosystem token"
- "crystal meme coin"
- "crystal token presale"
- "crystal token launchpad"
- "crystal token airdrop"
- "crystal token BSC"
- "crystal token Ethereum"
- "crystal token Solana"

#### b) DexScreener (qua web_fetch)
- `https://dexscreener.com/search?q=crystal` — tìm token mới
- `https://dexscreener.com/solana` — check Solana trending
- `https://dexscreener.com/bsc` — check BSC trending
- Ghi nhận contract address, price, liquidity, volume, holders

#### c) CoinGecko
- `https://www.coingecko.com/en/search?query=crystal` — tìm token
- Xem "newly added" và "trending" coins

#### d) CoinMarketCap
- `https://coinmarketcap.com/search/?q=crystal`
- Check "new tokens" section

#### e) Twitter/X (qua web_search / web_fetch)
- Tìm tweets về "#crystaltoken" "#crystalcoin" "new crystal token launch"
- Tìm tài khoản dự án crystal token

#### f) Reddit
- `https://www.reddit.com/r/CryptoCurrency/search/?q=crystal+token`
- `https://www.reddit.com/search/?q=crystal+crypto+new`

#### g) DEXTools (web_fetch)
- `https://www.dextools.io/app/en/search?q=crystal`
- Xem token pairs, liquidity, age

#### h) Binance Alpha (web_search)
- Tìm "binance alpha new listings crystal"
- Kiểm tra danh sách token mới niêm yết

#### i) Launchpads
- Tìm "crystal token" trên: PinkSale, DXSale, GemPad, etc.

### Bước 3: Lọc Token Mới

Với mỗi token tìm thấy:

1. **Kiểm tra trùng lặp:**
   - Contract address đã có trong `database_checked_tokens.json.tokens[].contract_address`?
   - Contract address đã có trong `checked_contracts.txt`?
   - Symbol/name đã có trong database?
   - Nếu CÓ → BỎ QUA (ghi log bỏ qua)

2. **Trích xuất thông tin tối thiểu:**
   - Tên token
   - Symbol
   - Contract address
   - Blockchain
   - Giá hiện tại
   - Market cap (nếu có)
   - Volume 24h
   - Liquidity

### Bước 4: Đánh Giá Token Mới

#### a) Kiểm tra token còn hoạt động không (DEAD TOKEN check):
- Website: dùng `web_fetch` kiểm tra còn truy cập được không
- Twitter/X: dùng `web_search` kiểm tra còn hoạt động không
- Telegram: dùng `web_search` tìm link Telegram, kiểm tra
- Volume: nếu volume = 0 → dead
- Liquidity: nếu liquidity = 0 → dead
- Giao dịch gần đây: nếu không có → dead
- Nếu dead → đánh dấu "DEAD_TOKEN", vẫn lưu vào database với flag

#### b) Đánh giá rủi ro (bằng phân tích dữ liệu thu thập được + web_search):
- Rug pull risk: kiểm tra community feedback, lịch sử dự án
- Honeypot risk: tìm kiếm "honeypot [contract_address]"
- Liquidity lock: tìm thông tin locked liquidity
- Holder concentration: phân bố holder (nếu có dữ liệu)
- Contract ownership: tìm thông tin ownership
- Mint function: tìm kiếm audit, báo cáo về contract

#### c) Đánh giá cộng đồng:
- Twitter followers (tìm qua web_search)
- Telegram members (tìm qua web_search)
- Discord hoạt động
- Reddit mentions
- Google search volume / trend

### Bước 5: Chấm Điểm (0-100)

| Tiêu chí | Điểm tối đa | Cách tính |
|----------|-------------|-----------|
| Thanh khoản | 20 | >= $50k = 20, $10-50k = 15, $1-10k = 10, <$1k = 5, 0 = 0 |
| Cộng đồng | 20 | Twitter+Telegram+Discord active = 20, 2/3 active = 15, 1/3 = 8, none = 0 |
| Website & Social | 15 | Website live + social active = 15, chỉ website = 8, không = 0 |
| Hoạt động on-chain | 20 | Volume cao + holders nhiều = 20, trung bình = 12, thấp = 5 |
| Holder distribution | 15 | Phân bố đều = 15, top 10 nắm >50% = 8, >80% = 3 |
| Độ an toàn contract | 10 | Audit có = 10, không rug flag = 7, có dấu hiệu honeypot = 0 |

**Xếp loại:**
- STRONG (80-100)
- GOOD (60-79)
- WATCHLIST (40-59)
- HIGH RISK (<40)
- DEAD TOKEN (volume=0, liquidity=0, website/social dead)

### Bước 6: Lưu Database

```json
{
  "name": "Crystal Token Name",
  "symbol": "CRYSTAL",
  "contract_address": "0x...",
  "blockchain": "Ethereum/BSC/Solana",
  "price": 0.001,
  "market_cap": 100000,
  "volume_24h": 50000,
  "liquidity": 25000,
  "holders": 1500,
  "website": "https://...",
  "twitter": "https://twitter.com/...",
  "telegram": "https://t.me/...",
  "score": 75,
  "rating": "GOOD",
  "dead_token": false,
  "risks": ["none identified"],
  "community_score": 15,
  "security_score": 8,
  "discovered_at": "2026-05-15T00:20:00+07:00",
  "sources": ["dexscreener", "twitter"],
  "notes": "New launch, growing community"
}
```

- Thêm vào `database_checked_tokens.json.tokens[]`
- Thêm contract address vào `checked_contracts.txt`
- Lưu kết quả chu kỳ vào `reports/crystal/search_results/session_YYYYMMDD_HHMM.json`

### Bước 7: Ghi Chú & Xử Lý Đặc Biệt

**Token ưu tiên:**
- Launch dưới 30 ngày
- Market cap thấp (< $1M)
- Holder tăng nhanh
- Volume tăng đột biến
- Được nhắc nhiều trên social

**Cảnh báo an toàn:**
- TUYỆT ĐỐI không mua token
- Không kết nối ví
- Không ký giao dịch
- Chỉ thu thập dữ liệu và báo cáo

## Quy Trình Báo Cáo (05:15)

### Bước 1: Tổng hợp dữ liệu
- Đọc toàn bộ database
- Đọc tất cả session results trong ngày
- Tính toán thống kê

### Bước 2: Tạo báo cáo Markdown
Lưu tại: `reports/crystal/crystal_report_YYYYMMDD.md`

Nội dung:
```markdown
# Crystal Token Scout Report - YYYY-MM-DD

## Tổng Quan
- Tổng số token tìm được: X
- Token mới phát hiện: X
- Token đã bỏ qua (trùng): X
- DEAD TOKEN: X
- Token STRONG: X
- Token HIGH RISK: X

## Top Token Đáng Chú Ý
(3-5 token có điểm cao nhất)

## Token Volume Tăng Mạnh
(3-5 token có volume tăng đột biến)

## Token Rủi Ro Cao
(3-5 token có điểm thấp nhất, kèm lý do)

## Danh Sách DEAD TOKEN
(các token không còn hoạt động)

## Phân Tích Xu Hướng Crystal Ecosystem
- Nhận xét về số lượng token mới
- Xu hướng blockchain (nhiều trên chain nào?)
- Tâm lý thị trường
- Cảnh báo đặc biệt (nếu có)

## Chi Tiết Từng Token
(Từng token với đầy đủ thông tin)
```

### Bước 3: Tạo báo cáo JSON
Lưu tại: `reports/crystal/crystal_report_YYYYMMDD.json`

### Bước 4: Dọn dẹp
- Xóa thư mục `search_results/` cũ (giữ lại database)

## Xử Lý Lỗi

Nếu gặp lỗi khi tìm kiếm/đánh giá:
- Ghi log lỗi vào `reports/crystal/error.log`
- Tiếp tục với nguồn khác
- Không dừng toàn bộ tiến trình
- Tự động retry 1-2 lần nếu lỗi mạng

## Maintain Database

Khi database quá lớn (>1000 tokens):
- Archive token cũ (trên 90 ngày) vào file riêng
- Giữ lại token có điểm > 40
- Giữ lại token STRONG/GOOD bất kể tuổi

---

*Generated by Crystal Token Scout System*
*Last instruction update: 2026-05-14*

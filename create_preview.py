"""
Tạo ảnh preview so sánh Before/After cho DCorp Brand Redesign
"""
from PIL import Image, ImageDraw, ImageFont

# Tạo ảnh so sánh Before/After
width = 1600
height = 900
img = Image.new('RGB', (width, height), 'white')
draw = ImageDraw.Draw(img)

# Tiêu đề
try:
    title_font = ImageFont.truetype("arial.ttf", 48)
    subtitle_font = ImageFont.truetype("arial.ttf", 28)
    text_font = ImageFont.truetype("arial.ttf", 20)
except:
    title_font = ImageFont.load_default()
    subtitle_font = ImageFont.load_default()
    text_font = ImageFont.load_default()

# Title
draw.text((800, 40), "DCorp Brand Redesign", fill="#003A99", font=title_font, anchor="mt")
draw.text((800, 100), "Before vs After Comparison", fill="#666666", font=subtitle_font, anchor="mt")

# Divider
draw.line([(50, 160), (1550, 160)], fill="#003A99", width=3)

# Before Section (Left)
draw.rectangle([(50, 200), (770, 850)], outline="#E0E0E0", width=2)
draw.text((410, 220), "BEFORE", fill="#666666", font=subtitle_font, anchor="mt")

before_items = [
    "Logo: Emoji icon ⚡",
    "Brand: NĂNG LƯỢNG & NGUYÊN LIỆU",
    "Tagline: Không có",
    "Header: Tối màu, gradient",
    "Colors: #1a3a5c, #e8842a",
    "Typography: Inter",
    "Products: 5 sản phẩm",
    "SEO: Thiếu OG, favicon",
    "Style: Generic landing page"
]

y = 280
for item in before_items:
    draw.text((70, y), "• " + item, fill="#1A1A1A", font=text_font)
    y += 50

# After Section (Right)
draw.rectangle([(830, 200), (1550, 850)], outline="#FF9900", width=3)
draw.text((1190, 220), "AFTER", fill="#003A99", font=subtitle_font, anchor="mt")

after_items = [
    "Logo: DCorp thật (60px)",
    "Brand: DCORP (#003A99)",
    "Tagline: Thương mại và Dầu khí",
    "Header: Trắng, shadow nhẹ, B2B",
    "Colors: #003A99, #FF9900",
    "Typography: Plus Jakarta Sans",
    "Products: 6 sản phẩm (+ Dầu nhờn)",
    "SEO: OG image, favicon, meta đầy đủ",
    "Style: Doanh nghiệp cao cấp B2B",
    "+ Career page",
    "+ Gallery page"
]

y = 280
for item in after_items:
    draw.text((850, y), "✓ " + item, fill="#1A1A1A", font=text_font)
    y += 50

# Save
img.save('dcorp_before_after_preview.png')
print('Preview image saved: dcorp_before_after_preview.png')

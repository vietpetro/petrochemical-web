from PIL import Image, ImageDraw, ImageFont
import textwrap

# Setup
logo_path = r'C:\Users\DidierChan\.openclaw\media\inbound\5b5dd30a-658d-496c-9731-a29cbf28d056.jpg'
output_path = 'og_image.png'
width, height = 1200, 630

# Base image (white)
img = Image.new('RGB', (width, height), color='white')
draw = ImageDraw.Draw(img)

# Logo
logo = Image.open(logo_path).convert('RGBA')
logo.thumbnail((300, 300))
img.paste(logo, (50, 165), logo)

# Text
try:
    font_main = ImageFont.truetype("arial.ttf", 80)
    font_sub = ImageFont.truetype("arial.ttf", 40)
except:
    font_main = ImageFont.load_default()
    font_sub = ImageFont.load_default()

draw.text((400, 150), "DCorp", fill="black", font=font_main)
draw.text((400, 240), "Thương mại và Dầu khí", fill="gray", font=font_sub)
draw.text((400, 350), "Nhà cung cấp xăng dầu và hạt nhựa.", fill="black", font=font_sub)

img.save(output_path)
print('OG image created at', output_path)

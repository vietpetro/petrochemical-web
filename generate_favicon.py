from pathlib import Path
from PIL import Image
logo_path = Path(r'C:\Users\DidierChan\.openclaw\media\inbound\5b5dd30a-658d-496c-9731-a29cbf28d056.jpg')
output_path = Path('favicon.ico')
if not logo_path.is_file():
    raise FileNotFoundError(f'Logo not found: {logo_path}')
im = Image.open(logo_path)
# ensure RGBA for transparency
if im.mode != 'RGBA':
    im = im.convert('RGBA')
# generate favicon with multiple sizes
sizes = [(16,16),(32,32),(48,48),(64,64)]
im.save(output_path, format='ICO', sizes=sizes)
print('Favicon created at', output_path.resolve())

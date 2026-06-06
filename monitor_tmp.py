import re, json, csv
from pathlib import Path
from datetime import datetime, timedelta, timezone
DATA_DIR=Path.home()/'.openclaw'/'data'; DATA_DIR.mkdir(parents=True,exist_ok=True)
seen_path=DATA_DIR/'real_estate_seen.json'
seen=set(json.loads(seen_path.read_text(encoding='utf-8')) if seen_path.exists() else [])
text=Path('alon.txt').read_text(encoding='utf-8') if Path('alon.txt').exists() else ''
# placeholder

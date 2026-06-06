import json,csv
from pathlib import Path
url='https://alonhadat.com.vn/cuc-hiem-can-nha-2-tang-dep-long-lanh-tai-co-nhue-gia-2-5-ty-17876665.html'
item={
 'title':'Cực hiếm căn nhà 2 tầng đẹp long lanh tại cổ nhuế giá 2.5 tỷ',
 'price':2500000000,
 'area':51.0,
 'location':'Đường Cổ Nhuế, Phường Đông Ngạc, Hà Nội',
 'phone':'0936755486',
 'posted_time':'2026-05-14',
 'url':url,
 'score':66.87,
 'hot_reason':['chính chủ/cần bán','tin đăng hôm nay','giá 2,5 tỷ','diện tích 51m²','có số điện thoại hiển thị']
}
data=Path.home()/'.openclaw'/'data'; data.mkdir(parents=True,exist_ok=True)
seen_path=data/'real_estate_seen.json'
try:
    seen=json.loads(seen_path.read_text(encoding='utf-8'))
    if isinstance(seen,dict): seen=seen.get('urls',[])
except Exception: seen=[]
if url not in seen: seen.append(url)
seen_path.write_text(json.dumps(sorted(set(seen)),ensure_ascii=False,indent=2),encoding='utf-8')
found=[item]
(data/'real_estate_latest.json').write_text(json.dumps(found,ensure_ascii=False,indent=2),encoding='utf-8')
with (data/'real_estate_latest.csv').open('w',newline='',encoding='utf-8-sig') as f:
    w=csv.DictWriter(f,fieldnames=['title','price','area','location','phone','posted_time','url','score','hot_reason'])
    w.writeheader()
    r=dict(item); r['hot_reason']=json.dumps(r['hot_reason'],ensure_ascii=False)
    w.writerow(r)
print(data/'real_estate_latest.json')
print(data/'real_estate_latest.csv')

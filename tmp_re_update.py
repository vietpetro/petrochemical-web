import json,csv
from pathlib import Path
DATA=Path.home()/'.openclaw'/'data'; DATA.mkdir(parents=True,exist_ok=True)
seen_path=DATA/'real_estate_seen.json'; outj=DATA/'real_estate_latest.json'; outc=DATA/'real_estate_latest.csv'
url='https://alonhadat.com.vn/-gia-re-tot-nhat-khu-vuc-k-con-can-thu-2-cach-5m-ra-o-to-chi-loanh-qoanh-2-t-y--18628523.html'
try:
    seen=json.loads(seen_path.read_text(encoding='utf-8')) if seen_path.exists() else []
    if isinstance(seen,dict): seen=seen.get('urls',[])
except Exception: seen=[]
item={
 'title':'💥Giá rẻ tốt nhất khu vực-K còn căn thứ 2- Cách 5M ra Ô tô- Chỉ loanh qoanh 2 T/ỷ💥',
 'price':2800000000,
 'area':25.0,
 'location':'Phố Vũ Lăng, Xã Ngọc Hồi, Hà Nội',
 'phone':'0987572192',
 'posted_time':'Hôm qua',
 'url':url,
 'score':83.33,
 'hot_reason':['tin mới trong 24h (Hôm qua)','nhà mặt tiền','giá 2,8 tỷ','có số điện thoại hiển thị','cần bán']
}
found=[item]
outj.write_text(json.dumps(found,ensure_ascii=False,indent=2),encoding='utf-8')
with outc.open('w',newline='',encoding='utf-8-sig') as f:
    w=csv.DictWriter(f,fieldnames=['title','price','area','location','phone','posted_time','url','score','hot_reason']); w.writeheader()
    for r in found:
        rr=dict(r); rr['hot_reason']=json.dumps(rr['hot_reason'],ensure_ascii=False); w.writerow(rr)
seen=sorted(set(seen)|{url}); seen_path.write_text(json.dumps(seen,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps(found,ensure_ascii=False,indent=2))
print(outc)

import json, pathlib
base=pathlib.Path(r'C:\Users\DidierChan\.openclaw\workspace\reports\crystal')
for p in [base/'database_checked_tokens.json']+list((base/'search_results').glob('session_20260518_*.json')):
 print('\nFILE',p.name)
 data=json.load(open(p,encoding='utf-8'))
 print(type(data), data.keys() if isinstance(data,dict) else len(data))
 print(json.dumps(data,ensure_ascii=False,indent=2)[:2000])

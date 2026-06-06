import urllib.request, json
models=['cerebras/gpt-oss-120b','gemini/gemini-3.1-flash-lite-preview','groq/openai/gpt-oss-120b','openrouter/nvidia/nemotron-3-nano-30b-a3b:free','groq/qwen/qwen3-32b']
for m in models:
    body=json.dumps({'model':m,'messages':[{'role':'user','content':'Reply one word: OK'}],'max_tokens':20,'temperature':0}).encode()
    req=urllib.request.Request('http://127.0.0.1:20128/v1/chat/completions',data=body,headers={'Authorization':'Bearer sk-870d605ac0651d69-qbst2k-486976a8','Content-Type':'application/json'},method='POST')
    try:
        with urllib.request.urlopen(req,timeout=45) as r:
            txt=r.read().decode('utf-8','replace').replace('data: [DONE]','').strip()
            data=json.loads(txt); msg=data['choices'][0]['message']
            print(f'{m}\tOK\t{(msg.get("content") or msg.get("reasoning") or "")[:80]}')
    except Exception as e:
        print(f'{m}\tERR\t{type(e).__name__}: {e}')

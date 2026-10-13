import json,sys,urllib.request,time
UA={"User-Agent":"scholar-auto-research/1.0 (mailto:research@example.org)"}
for d in sys.argv[1:]:
    try:
        m=json.loads(urllib.request.urlopen(urllib.request.Request("https://api.crossref.org/works/"+d,headers=UA),timeout=40).read())["message"]
        au="; ".join(f"{a.get('family','')}, {a.get('given','')}" for a in m.get("author",[])[:5])
        yr=(m.get("published-print") or m.get("issued") or {}).get("date-parts",[[None]])[0][0]
        ab=(m.get("abstract") or "")[:400].replace("\n"," ")
        print(f"{d} | {au} | {yr} | {(m.get('title') or [''])[0]} | {(m.get('container-title') or [''])[0]} | v{m.get('volume')} p{m.get('page')}\n   ABS: {ab}")
    except Exception as e: print(d,"ERROR",e)
    time.sleep(0.3)

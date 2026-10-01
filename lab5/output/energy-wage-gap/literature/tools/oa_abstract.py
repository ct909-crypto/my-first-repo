import json,sys,urllib.request,urllib.parse,time
UA={"User-Agent":"scholar-auto-research/1.0 (mailto:research@example.org)"}
def get(u): return json.loads(urllib.request.urlopen(urllib.request.Request(u,headers=UA),timeout=40).read())
for arg in sys.argv[1:]:
    try:
        if arg.startswith("10."): w=get("https://api.openalex.org/works/https://doi.org/"+arg)
        else: w=get("https://api.openalex.org/works?per-page=1&search="+urllib.parse.quote(arg))["results"][0]
        inv=w.get("abstract_inverted_index") or {}
        pos=sorted((p,t) for t,ps in inv.items() for p in ps)
        print("==",arg,"|",w.get("title"),"|",w.get("publication_year")); print(" ".join(t for _,t in pos)[:1500] or "NO ABSTRACT")
    except Exception as e: print("==",arg,"ERR",e)
    time.sleep(0.3)

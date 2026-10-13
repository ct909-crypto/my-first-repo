"""Match free-text references to CrossRef; fetch BibTeX by DOI. Usage: crossref_match.py in.json out.jsonl"""
import json, sys, urllib.parse, urllib.request, difflib, re, time
UA={"User-Agent":"scholar-auto-research/1.0 (mailto:research@example.org)"}
def get(url, accept=None):
    h=dict(UA); 
    if accept: h["Accept"]=accept
    with urllib.request.urlopen(urllib.request.Request(url,headers=h),timeout=40) as r: return r.read().decode()
def title_guess(ref):
    m=re.search(r'[“"](.+?)[”"]',ref); 
    return m.group(1) if m else ref
refs=json.load(open(sys.argv[1])); out=open(sys.argv[2],"w")
for ref in refs:
    t=title_guess(ref)
    try:
        items=json.loads(get("https://api.crossref.org/works?rows=3&query.bibliographic="+urllib.parse.quote(ref)))["message"]["items"]
    except Exception as e:
        items=[]
    best=None;score=0
    for it in items:
        ct=(it.get("title") or [""])[0]
        s=difflib.SequenceMatcher(None,t.lower()[:120],ct.lower()[:120]).ratio()
        if s>score: best,score=it,s
    rec={"ref":ref,"score":round(score,2)}
    if best:
        rec.update(doi=best.get("DOI"),title=(best.get("title") or [""])[0],year=(best.get("issued",{}).get("date-parts") or [[None]])[0][0],venue=(best.get("container-title") or [""])[0],type=best.get("type"))
    out.write(json.dumps(rec)+"\n"); out.flush(); time.sleep(0.2)

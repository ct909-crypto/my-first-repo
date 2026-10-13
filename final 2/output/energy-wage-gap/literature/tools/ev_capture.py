"""Python port of evidence-ledger ev_capture (claim-anchor/v1). Reads JSON list of specs from argv[1]; appends to evidence/claim-anchors.ndjson."""
import json, sys, hashlib, re, datetime, os, urllib.request, html, time
UA={"User-Agent":"scholar-auto-research/1.0 (mailto:research@example.org)"}
def norm(s): return re.sub(r"\s+"," ",(s or "").lower()).strip()
def sha256(s): return hashlib.sha256(s.encode()).hexdigest()
def aid(ck,q,loc):
    ckn=norm(ck); h=hashlib.sha1(f"{ckn}|{sha256(norm(q))}|{norm(loc)}".encode()).hexdigest()
    return re.sub(r"[^a-z0-9_-]","",ckn)+"-"+h[:8]
def abstract(doi):
    try:
        m=json.loads(urllib.request.urlopen(urllib.request.Request("https://api.crossref.org/works/"+doi,headers=UA),timeout=40).read())["message"]
        a=m.get("abstract") or ""; a=html.unescape(re.sub(r"<[^>]+>"," ",a)); return re.sub(r"\s+"," ",a).strip()
    except Exception: return ""
os.makedirs("evidence",exist_ok=True); led="evidence/claim-anchors.ndjson"
seen=set(json.loads(l)["anchor_id"] for l in open(led)) if os.path.exists(led) else set()
out={}
for s in json.load(open(sys.argv[1])):
    q=s.get("quote"); form=s.get("form"); tier=s.get("tier")
    if q=="__ABSTRACT__":
        a=abstract(s["doi"]); time.sleep(0.3)
        if a:
            w=a.split(); q=" ".join(w[:60]); form="abstract_verbatim"; tier="T3_abstract"; ctx=" ".join(w[:150])
        else: q=None; form="metadata_only"; tier="T4_none"
    loc=s.get("source_loc","")
    i=aid(s["key"],q or "",loc); out[s["row"]]=out.get(s["row"],[])+[i]
    if i in seen: continue
    rec={"schema":"claim-anchor/v1","anchor_id":i,"cite_key":s["key"],"doi":s.get("doi"),"source_title":s.get("title"),"claim_kind":s.get("kind","map_cell"),"stance":s.get("stance","supports"),"claim_text":s["claim"],"claim_loc":"literature/lit-theory.md","hypothesis_id":s.get("hyp"),"evidence_quote":q,"evidence_context":None,"evidence_form":form,"quote_sha256":sha256(norm(q or "")),"source_loc":loc or None,"locator_type":s.get("loctype","none"),"access_tier":tier,"retrieval":{"tool":s.get("tool","websearch") if q else None,"doc_id":None,"chunk_id":None,"text_sha256":None},"produced_by":"scholar-lit-review-hypothesis","phase":"2","ts":datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ"),"supersedes":None}
    open(led,"a").write(json.dumps(rec,ensure_ascii=False)+"\n"); seen.add(i)
json.dump(out,open(sys.argv[2],"w"),indent=1)
print(len(seen),"anchors in ledger")

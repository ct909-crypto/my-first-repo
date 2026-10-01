"""Tier-2 literature search: OpenAlex + CrossRef keyword search. Prints compact records."""
import json, sys, urllib.parse, urllib.request
UA = {"User-Agent": "scholar-auto-research/1.0 (mailto:research@example.org)"}
def get(url):
    req = urllib.request.Request(url, headers=UA)
    with urllib.request.urlopen(req, timeout=30) as r:
        return json.loads(r.read().decode())
def openalex(q, n=10):
    u = "https://api.openalex.org/works?per-page=%d&search=%s" % (n, urllib.parse.quote(q))
    out = []
    for w in get(u).get("results", []):
        au = [a["author"]["display_name"] for a in w.get("authorships", [])][:3]
        src = ((w.get("primary_location") or {}).get("source") or {}).get("display_name")
        out.append(dict(src="openalex", year=w.get("publication_year"), title=w.get("title"), authors=au, venue=src, doi=(w.get("doi") or "").replace("https://doi.org/",""), cites=w.get("cited_by_count")))
    return out
def crossref(q, n=10):
    u = "https://api.crossref.org/works?rows=%d&query.bibliographic=%s" % (n, urllib.parse.quote(q))
    out = []
    for w in get(u)["message"]["items"]:
        au = ["%s %s" % (a.get("given",""), a.get("family","")) for a in w.get("author", [])][:3]
        yr = (w.get("issued", {}).get("date-parts") or [[None]])[0][0]
        out.append(dict(src="crossref", year=yr, title=(w.get("title") or [""])[0], authors=au, venue=(w.get("container-title") or [""])[0], doi=w.get("DOI"), cites=w.get("is-referenced-by-count")))
    return out
if __name__ == "__main__":
    n = int(sys.argv[1]); 
    for q in sys.argv[2:]:
        print("=== QUERY:", q)
        for fn in (openalex, crossref):
            try:
                for r in fn(q, n):
                    print(f"  [{r['src']}] {r['year']} | {', '.join(r['authors'])} | {r['title']} | {r['venue']} | doi:{r['doi']} | cites:{r['cites']}")
            except Exception as e:
                print("  ERROR", fn.__name__, e)

"""Fetch BibTeX for DOIs via doi.org content negotiation and rewrite keys. Usage: doi2bib.py key=doi ... >> out.bib"""
import sys, urllib.request, re, time
for arg in sys.argv[1:]:
    key, doi = arg.split("=",1)
    req=urllib.request.Request("https://doi.org/"+doi, headers={"Accept":"application/x-bibtex; charset=utf-8","User-Agent":"scholar-auto-research/1.0"})
    try:
        b=urllib.request.urlopen(req,timeout=40).read().decode("utf-8")
        b=re.sub(r"^\s*@(\w+)\{[^,]*,", lambda m:"@%s{%s,"%(m.group(1),key), b.strip(), count=1)
        print(b+"\n")
    except Exception as e:
        print("%% FAILED %s %s %s"%(key,doi,e), file=sys.stderr)
    time.sleep(0.2)

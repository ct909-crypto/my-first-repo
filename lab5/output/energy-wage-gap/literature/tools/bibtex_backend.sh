scholar_search_bibtex_keyword() {
  local KEYWORD="$1" LIMIT="${2:-100}"
  python3 << PYEOF
import re, sys

keyword = "${KEYWORD}".lower()
limit = int("${LIMIT}")

with open("${BIB_PATH}", "r", encoding="utf-8", errors="replace") as f:
    content = f.read()

entries = re.findall(r'@(\w+)\{([^,]*),([^@]*)', content, re.DOTALL)
count = 0
for entry_type, cite_key, body in entries:
    if entry_type.lower() in ('comment', 'string', 'preamble'):
        continue
    fields = {}
    for m in re.finditer(r'(\w+)\s*=\s*[\{"]([^}"]*?)[\}"]', body):
        fields[m.group(1).lower()] = m.group(2).strip()

    title = fields.get('title', '')
    abstract = fields.get('abstract', '')
    if keyword not in title.lower() and keyword not in abstract.lower():
        continue

    author_raw = fields.get('author', '')
    authors = [a.strip() for a in re.split(r'\s+and\s+', author_raw)]
    first_author = authors[0] if authors else ''
    if ',' in first_author:
        parts = first_author.split(',', 1)
        last_name = parts[0].strip()
        first_name = parts[1].strip() if len(parts) > 1 else ''
    else:
        name_parts = first_author.split()
        last_name = name_parts[-1] if name_parts else ''
        first_name = ' '.join(name_parts[:-1]) if len(name_parts) > 1 else ''

    year = fields.get('year', '')
    journal = fields.get('journal', fields.get('booktitle', ''))
    doi = fields.get('doi', '')
    volume = fields.get('volume', '')
    issue = fields.get('number', '')
    pages = fields.get('pages', '')

    all_authors = '; '.join(
        f"{a.split(',')[0].strip()}, {a.split(',')[1].strip()}" if ',' in a
        else f"{a.split()[-1]}, {' '.join(a.split()[:-1])}" if a.strip()
        else ''
        for a in authors if a.strip()
    )
    print(f"{all_authors}|{year}|{title}|{journal}|{doi}|{volume}|{issue}|{pages}|{entry_type}||bibtex")
    count += 1
    if count >= limit:
        break
PYEOF
}
scholar_search_bibtex_author() {
  local AUTHOR="$1" LIMIT="${2:-100}"
  python3 << PYEOF
import re

author_q = "${AUTHOR}".lower()
limit = int("${LIMIT}")

with open("${BIB_PATH}", "r", encoding="utf-8", errors="replace") as f:
    content = f.read()

entries = re.findall(r'@(\w+)\{([^,]*),([^@]*)', content, re.DOTALL)
count = 0
for entry_type, cite_key, body in entries:
    if entry_type.lower() in ('comment', 'string', 'preamble'):
        continue
    fields = {}
    for m in re.finditer(r'(\w+)\s*=\s*[\{"]([^}"]*?)[\}"]', body):
        fields[m.group(1).lower()] = m.group(2).strip()

    author_raw = fields.get('author', '')
    if author_q not in author_raw.lower():
        continue

    authors = [a.strip() for a in re.split(r'\s+and\s+', author_raw)]

    title = fields.get('title', '')
    year = fields.get('year', '')
    journal = fields.get('journal', fields.get('booktitle', ''))
    doi = fields.get('doi', '')
    volume = fields.get('volume', '')
    issue = fields.get('number', '')
    pages = fields.get('pages', '')

    all_authors = '; '.join(
        f"{a.split(',')[0].strip()}, {a.split(',')[1].strip()}" if ',' in a
        else f"{a.split()[-1]}, {' '.join(a.split()[:-1])}" if a.strip()
        else ''
        for a in authors if a.strip()
    )
    print(f"{all_authors}|{year}|{title}|{journal}|{doi}|{volume}|{issue}|{pages}|{entry_type}||bibtex")
    count += 1
    if count >= limit:
        break
PYEOF
}

"""Check the specific textbook section assigned to each worksheet."""
from html.parser import HTMLParser
from pathlib import Path
import re
import subprocess


class Anchors(HTMLParser):
    def __init__(self):
        super().__init__()
        self.ids = set()

    def handle_starttag(self, tag, attrs):
        self.ids.add(dict(attrs).get("id"))


readme = Path("README.md").read_text()
for sheet in sorted(Path("Exercises").glob("Session*.lean")):
    session = sheet.stem[-2:]
    pattern = rf"https://pl-semantics-textbook\.moonlitwhale2\.chatgpt\.site/chapter-{session}/#(ch{session}-s\d+)"
    match = re.search(pattern, readme)
    if not match or str(sheet) not in readme:
        raise SystemExit(f"Missing reading or sheet link for {sheet}")
    url, anchor = match[0].split("#")
    html = subprocess.check_output(["curl", "-fsSL", "--retry", "2", "--max-time", "20", url],
                                   text=True)
    parser = Anchors()
    parser.feed(html)
    if anchor not in parser.ids:
        raise SystemExit(f"Missing section {match[0]}")

"""Elaborate the worksheets and check the dependencies of every named solution proof."""
import json
from pathlib import Path
import re
import subprocess


def messages(args, source=None):
    result = subprocess.run(["lake", "env", "lean", "--json", *args], input=source,
                            text=True, stdout=subprocess.PIPE)
    rows = [json.loads(line) for line in result.stdout.splitlines() if line.strip()]
    if result.returncode:
        raise SystemExit("\n".join(str(r["data"]) for r in rows) or "Lean failed")
    return rows


for path in sorted(Path("Solutions").glob("Session*.lean")):
    sheet = Path("Exercises") / path.name
    for row in messages([str(sheet)]):
        if row["severity"] == "warning" and row["kind"] != "hasSorry":
            raise SystemExit(f"{sheet}: {row['data']}")

    text = path.read_text()
    namespace = re.search(r"^namespace (Lab\d+)$", text, re.M)[1]
    names = re.findall(r"^theorem (\w+)\b", text, re.M)
    if not names:
        raise SystemExit(f"No named exercise found in {path}")
    proofs = {f"{namespace}.{name}" for name in names}
    reports = messages(["-DwarningAsError=true", "--stdin"],
                       text + "\n".join(f"#print axioms {p}" for p in sorted(proofs)) + "\n")
    for row in reports:
        match = re.fullmatch(r"'([^']+)' (?:does not depend on any axioms|depends on axioms: \[([^\]]*)\])",
                             row["data"], re.S)
        if match and match[1] in proofs:
            dependencies = {a.strip() for a in (match[2] or "").split(",") if a.strip()}
            unexpected = dependencies - {"propext", "Classical.choice", "Quot.sound"}
            if unexpected:
                raise SystemExit(f"{match[1]} depends on {sorted(unexpected)}")
            proofs.remove(match[1])
    if proofs:
        raise SystemExit(f"Missing axiom reports for {sorted(proofs)}")
    print(f"{sheet}: starter checked; {len(names)} worked proofs audited")

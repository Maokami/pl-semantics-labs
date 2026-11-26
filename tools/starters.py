"""Render exercise sheets from the marked tactic blocks in the worked files."""
from argparse import ArgumentParser
from pathlib import Path


def render(path):
    lines = []
    indent = None
    for n, line in enumerate(path.read_text().splitlines(keepends=True), 1):
        token = line.strip()
        if token == "-- BEGIN ANSWER" and indent is None:
            indent = line[:len(line) - len(line.lstrip())]
            lines.append(indent + "sorry\n")
        elif token == "-- END ANSWER" and indent is not None:
            indent = None
        elif token in {"-- BEGIN ANSWER", "-- END ANSWER"}:
            raise ValueError(f"{path}:{n}: unbalanced answer markers")
        elif indent is None:
            lines.append(line)
    if indent is not None:
        raise ValueError(f"{path}: unterminated answer")
    return "".join(lines)


if __name__ == "__main__":
    parser = ArgumentParser(description=__doc__)
    parser.add_argument("--write", action="store_true", help="replace exercise sheets")
    write = parser.parse_args().write
    solutions = sorted(Path("Solutions").glob("Session*.lean"))
    expected = {Path("Exercises") / p.name for p in solutions}
    if not solutions or set(Path("Exercises").glob("*.lean")) - expected:
        raise SystemExit("Missing solutions or orphan exercise sheets")
    for source in solutions:
        sheet = Path("Exercises") / source.name
        content = render(source)
        if write:
            sheet.write_text(content)
        elif not sheet.exists() or sheet.read_text() != content:
            raise SystemExit(f"{sheet} differs from its solution template")

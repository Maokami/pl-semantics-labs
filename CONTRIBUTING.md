# Contributing a lab

Start from a textbook section and one question a reader can answer after completing the file.
Give a worked example, an exercise, a hint naming a useful rule, and a question that can be
discussed without Lean. Describe what students should see in the infoview. Write in English.

Edit the worked file in `Solutions/`. Keep tactics to be supplied by learners between
matching `-- BEGIN ANSWER` and `-- END ANSWER` lines. Both markers have the indentation
of the missing tactic. Include answer-specific comments inside the markers.
Run `python3 tools/starters.py --write` in the maintainer checkout to regenerate the
exercise sheets. This command overwrites local changes to those sheets.

Run the same checks as CI from the repository root:

```sh
lake build
python3 tools/starters.py
python3 tools/check_labs.py
shasum -a 256 -c tools/upstream.sha256
```

Open a draft PR for one learning objective. Identify the section, describe what the reader
must do, and report the checks you ran. A human reviews the changed sheet as a learner.
Keep each retained commit conventional (for example `feat(lab01): derive an addition`).
Update a stale branch, recheck the tip, and use rebase-and-merge. Document changes to the
shared semantics or merge policy in a decision issue. Publishing an exercise link in the
book follows acceptance of the corresponding sheet.

## Optional reading audit

A maintainer can dispatch **Lab reading audit** in GitHub Actions to compare a
worksheet, its worked proof and its reading. It stages at most one issue proposal
for review. The Lean checks run independently on every PR.

The workflow was compiled with gh-aw v1.2.2. After editing its Markdown source,
run `gh aw compile lab-audit` and review the generated lockfile. A hosted audit
uses an owner-configured `CODEX_API_KEY` or `OPENAI_API_KEY`. Enable that
credential only when the owner elects to pay for a manual run.

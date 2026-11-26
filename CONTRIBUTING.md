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

## Reading audit

Lab reading audit checks for workbook changes twice a month, on the 1st and 16th
at 02:17 UTC. A maintainer can also dispatch a run to revisit a reading or a
changed textbook section. It stages at most one issue proposal in the run output.
The Lean checks run independently on every PR.

Set the repository Actions secret `ANTHROPIC_API_KEY` for the Claude Haiku audit.
Without a key the preflight skips inference. Each main agent session has an
eight-turn limit and a USD 0.50 CLI budget. Review the run summary and staged
finding in Actions. Recompile the workflow with gh-aw v1.2.2 using
`gh aw compile lab-audit` whenever its Markdown changes.

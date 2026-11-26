# PL Semantics Labs

Start with the integer result of an expression, then build the tree that justifies it.
These Lean 4 labs accompany [Programming Languages](https://pl-semantics-textbook.moonlitwhale2.chatgpt.site/).
Each exercise uses the IMP language of the book. No additional Lean libraries are required.

| Session | Question | Read | Work | Compare afterward |
| --- | --- | --- | --- | --- |
| 01 | Which two rules justify the value of `x + 4`? | [Evaluation judgments](https://pl-semantics-textbook.moonlitwhale2.chatgpt.site/chapter-01/#ch01-s4) | [Exercise 01](Exercises/Session01.lean) | [Solution 01](Solutions/Session01.lean) |
| 02 | Which state does the second assignment read? | [Sequencing](https://pl-semantics-textbook.moonlitwhale2.chatgpt.site/chapter-02/#ch02-s3) | [Exercise 02](Exercises/Session02.lean) | [Solution 02](Solutions/Session02.lean) |
| 03 | Why must the intermediate states agree? | [Comparing two derivations](https://pl-semantics-textbook.moonlitwhale2.chatgpt.site/chapter-03/#ch03-s2) | [Exercise 03](Exercises/Session03.lean) | [Solution 03](Solutions/Session03.lean) |

## Open the project in a browser

[Open or resume your workspace](https://codespaces.new/Maokami/pl-semantics-labs?quickstart=1).
GitHub opens a personal Codespace with the Lean extension, builds the shared modules,
and opens this guide. Select **Exercise** for the current session in the table above.
Use the file explorer to follow imports and the terminal to check the finished sheet.
Stop the Codespace when finished. GitHub applies your account’s Codespaces allowance.

## Working on a sheet

1. Install [Lean 4 and its editor support](https://lean-lang.org/install/). Open the repository root, the directory containing `lean-toolchain`.
2. Run `lake build` once to build the shared definitions. Open `Exercises/Session01.lean` and place the cursor after a `#eval` command to see the result in the Lean infoview.
3. Replace each `sorry`. Put the cursor after a tactic to read the remaining goals. When a hint names a rule, use `#check` to read its conclusion and premises. Check the finished sheet with `lake env lean -DwarningAsError=true Exercises/Session01.lean`.

A fresh sheet type-checks with warnings at the unfinished proofs. A completed sheet passes the last command with none. Save experiments in your own working copy. [Sources and further exercises](UPSTREAM.md) · [Contributing](CONTRIBUTING.md)

# Source provenance

The language and the Lean toolchain are verbatim snapshots of textbook commit
`3b590bc1052595db9cfdbe6a406c7717d5d0f548`. The original path of
`PLBook/IMP/Language.lean` is `verso/PLBook/IMP/Language.lean`. Its header credits
Wojciech Różowski’s Lean port of Leroy’s IMP. Its accompanying
[LGPL 2.1 text](PLBook/IMP/LICENSE.md) is included verbatim.
`Labs/Evaluation.lean` takes the import, namespace and inductive declaration
`Evaluates` from `verso/PLBook/IMP/Arithmetic.lean`, ending before `occurs`.
[Textbook Lean sources](https://pl-semantics-textbook.moonlitwhale2.chatgpt.site/lean/) ·
[Leroy port](https://github.com/leanprover/LeroyCompilerVerificationCourse/tree/a2730e7f9228b9d7ecf4510f1f8652f2cae7ba01)

To update, compare these files with the new textbook revision, copy the language,
license, judgment and toolchain together, and regenerate `tools/upstream.sha256`.
Include the source diff and both revisions in the PR. The ordinary build has no
dependency on the textbook repository.

The exercise-sheet and worked-solution pairing follows *The Hitchhiker’s Guide
to Logical Verification* (2026). Its numbered tasks and local hints in
[Exercise 6](https://github.com/lean-forward/logical_verification_2026/blob/460f6be0846eefc3d9441e4e48d75753fcfe1709/lean/LoVe/LoVe06_InductivePredicates_ExerciseSheet.lean)
provide additional practice reading inductive evidence. For a language where
the branches of a choice can give different results, see
[Exercise 9](https://github.com/lean-forward/logical_verification_2026/blob/460f6be0846eefc3d9441e4e48d75753fcfe1709/lean/LoVe/LoVe09_OperationalSemantics_ExerciseSheet.lean).
The three IMP exercises use this textbook’s rules and examples.

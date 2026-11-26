# Repository rules

Use the textbook’s pinned IMP declarations. Document any source update in UPSTREAM.md.
Use English and the chapter’s notation; match the Lean execution relation exactly.
Keep worked files independent of each other and generate the learner files from them.
Export exercise proofs as named theorems in the session namespace. Keep one theorem
name per declaration line so the axiom audit can find it.
Never import the answer to an exercise or add an axiom to complete it.
Open a draft PR with one learning objective and conventional commits. Humans merge after
review and CI on the current revision. Follow CONTRIBUTING.md for checks.

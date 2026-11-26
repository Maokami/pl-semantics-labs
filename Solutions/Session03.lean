import PLBook.IMP.Language

/-! # Lab 03 · Why two executions agree

Read Theorem 3.2. Suppose `c; d` has two terminating executions from the same state.
Draw both trees. Give the intermediate state of each tree a different name.
On paper, connect the two subderivations you would compare first.
-/
namespace Lab03
open PLBook.IMP

-- Worked example: inspecting a skip derivation leaves one possible final state.
example (h : cexec σ .SKIP τ) : τ = σ := by
  cases h
  rfl

/-- 1. Warm-up. Which execution rule can have an assignment as its conclusion? -/
theorem assignmentResult (h : cexec σ (.ASSIGN x e) τ) :
    τ = update x (aeval σ e) σ := by
  -- BEGIN ANSWER
  cases h
  rfl
  -- END ANSWER

/-- 2. Complete the sequence case. Place the cursor after the second `cases` to see
`left` and `right`. Which one fits `ihLeft`? Use the equality it returns to identify
the intermediate states. Then check the type of `ihRight` again. -/
theorem deterministic (first : cexec σ c τ) (other : cexec σ c υ) : τ = υ := by
  -- Keeping υ general lets each induction hypothesis compare with a new final state.
  induction first generalizing υ with
  | cexec_skip => cases other; rfl
  | cexec_assign => cases other; rfl
  | cexec_seq _ _ ihLeft ihRight =>
    cases other with
    | cexec_seq left right =>
      -- BEGIN ANSWER
      -- Both left subtrees start at σ, so comparing them identifies the middle states.
      cases ihLeft left
      exact ihRight right
      -- END ANSWER
  | cexec_ifthenelse _ ih =>
    cases other with
    | cexec_ifthenelse branch => exact ih branch
  | cexec_while_done guard =>
    cases other with
    | cexec_while_done => rfl
    | cexec_while_loop guard' _ _ => simp_all
  | cexec_while_loop guard _ _ ihBody ihLoop =>
    cases other with
    | cexec_while_done guard' => simp_all
    | cexec_while_loop _ body rest =>
      cases ihBody body
      exact ihLoop rest

-- Discuss: suppose there is no terminating run from σ. Which hypothesis of
-- deterministic could you supply? Could this theorem establish that a run exists?
end Lab03

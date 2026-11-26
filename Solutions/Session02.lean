import PLBook.IMP.Language

/-! # Lab 02 · Two assignments and an intermediate state

Read §2.2 and Proposition 2.2. The program is `x := 1; y := x + 3`.
Predict the value of each variable before, between and after the assignments.
-/
namespace Lab02
open PLBook.IMP

def initial : store := fun _ => 0
def writeX : com := .ASSIGN "x" (.CONST 1)
def rhs : aexp := .PLUS (.VAR "x") (.CONST 3)
def writeY : com := .ASSIGN "y" rhs
def middle : store := update "x" 1 initial
def finish : store := update "y" 4 middle

#eval (aeval initial rhs, aeval middle rhs)
#check cexec.cexec_seq

-- Worked example: the assignment rule computes its own final state.
example : cexec initial writeX middle := cexec.cexec_assign

/-- 1. Supply the intermediate state, then justify both assignments.
Try using `initial` in place of `middle`. Which premise fails? -/
theorem sequenceRun : cexec initial (.SEQ writeX writeY) finish := by
  -- BEGIN ANSWER
  apply cexec.cexec_seq (s' := middle)
  · exact cexec.cexec_assign
  · exact cexec.cexec_assign
  -- END ANSWER

/-- 2. Now the execution is given. Recover its intermediate state and the evidence
for its two parts. Hint: inspect `run` with `cases`; the sequence constructor
has precisely two premise derivations. -/
theorem splitSequence (run : cexec σ (.SEQ c d) τ) :
    ∃ μ, cexec σ c μ ∧ cexec μ d τ := by
  -- BEGIN ANSWER
  cases run with
  | cexec_seq left right => exact ⟨_, left, right⟩
  -- END ANSWER

/-- 3. Reverse the commands. Decide which integer replaces `k` in the final
update by choosing an existential witness. Prove that the resulting run ends
with 3 at y. Hint: name the state reached just after writeY. -/
theorem reversed : ∃ k : Int,
    cexec initial (.SEQ writeY writeX) (update "x" 1 (update "y" k initial)) ∧ k = 3 := by
  -- BEGIN ANSWER
  refine ⟨3, ?_, rfl⟩
  apply cexec.cexec_seq (s' := update "y" 3 initial)
  · exact cexec.cexec_assign
  · exact cexec.cexec_assign
  -- END ANSWER

-- Discuss: what changes if y's right-hand side is the literal 4?
-- Why does splitSequence work for arbitrary commands and starting states?
end Lab02

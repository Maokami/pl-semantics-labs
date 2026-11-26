import Labs.Evaluation

/-! # Lab 01 · Arithmetic expressions

Read §§1.2 and 1.4. Put your cursor after a command to see its output or proof goals
in the Lean infoview. Replace each exercise hole with a proof step.
-/
namespace Lab01
open PLBook.IMP

-- The book writes σ for a state. Lean calls its type `store`.
def zero : store := fun _ => 0
def σ : store := update "x" 3 zero
def e : aexp := .PLUS (.VAR "x") (.CONST 4)

#check aeval
#check Evaluates.plus

-- 1. Predict all three integers before running these commands.
#eval aeval σ e
#eval aeval (update "y" 8 σ) e
#eval aeval (update "x" 8 σ) e

-- A worked leaf: the literal rule needs no premise about σ.
example : Evaluates σ (.CONST 2) 2 := Evaluates.literal 2

/-- 2. Build the tree for x + 4. Read the two goals immediately after `apply`.
Which leaf consults the state? `m` and `n` specify the two operand values. -/
theorem plusFour : Evaluates σ e 7 := by
  apply Evaluates.plus (m := 3) (n := 4)
  ·
    sorry
  ·
    sorry

/-- 3. Change the literal. Choose the two premise values yourself. -/
theorem plusTwo : Evaluates σ (.PLUS (.VAR "x") (.CONST 2)) 5 := by
  sorry

-- Discuss: if the lookup and literal premises are reversed, which expression does the
-- new derivation describe? What must Theorem 1.3 establish beyond these examples?
end Lab01

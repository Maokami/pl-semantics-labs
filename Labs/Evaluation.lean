import PLBook.IMP.Language

namespace PLBook.IMP

/-- The evaluation judgment of Definition 1.5, on the shared IMP syntax. -/
inductive Evaluates (s : store) : aexp → Int → Prop where
  | literal (n) : Evaluates s (.CONST n) n
  | lookup (x) : Evaluates s (.VAR x) (s x)
  | plus : Evaluates s e m → Evaluates s f n → Evaluates s (.PLUS e f) (m + n)
  | minus : Evaluates s e m → Evaluates s f n → Evaluates s (.MINUS e f) (m - n)

end PLBook.IMP

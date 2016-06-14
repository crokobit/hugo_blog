datatype exp =   Constant of int
               | Multiple of exp * exp
               | Add of exp * exp
               | Negate of exp

fun max_constant e =
  case e of
      Constant(e) => e
    | Multiple(e1, e2) => Int.max(max_constant(e1),  max_constant(e2))
    | Add(e1, e2) => Int.max(max_constant(e1), max_constant(e2))
    | Negate(e) => max_constant(e)

val tree = Multiple(Add(Constant(3), Constant(5)),Negate(Multiple(Constant(44),Constant(34))))

val ans = max_constant(tree)

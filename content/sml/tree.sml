datatype exp = Multiply of exp*exp
             | Constant of int
             | Add of exp*exp
             | Negate of exp

fun eval e =
  case e of
    Constant i => i
  | Negate e => eval e
  | Add (i1,i2) => (eval i1) + (eval i2)
  | Multiply (i1,i2) => (eval i1) * (eval i2)

val tree = Add(Constant 19, Negate (Multiply (Constant(3),Constant(4))))
val ans = eval tree

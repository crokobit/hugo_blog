datatype tree = Node of tree*tree
              | Negate of tree
              | Constant of int

fun sum_of_tree e =
  case e of
    Node(b1, b2) => sum_of_tree(b1) + sum_of_tree(b2)
  | Negate(e) => sum_of_tree(e)
  | Constant(e) => e
 
val test = sum_of_tree(Node((Negate(Constant(5))), Constant(6)))

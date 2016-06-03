+++
date = "2016-01-10T17:11:33+08:00"
draft = true
title = "PL"

+++
PL
bindings, expressions, types, values, environments

code component = syntax + type check logic + evaluate logic

variable binding is a kind of code component

function binding

syntax:

```
  fun x0 (x1:t1, x2:t2) = e
```

type checking: type of x0 is type of e with [static env + variable within () with type defined]
evaluate:
  A function is a value  ??

Function calls:
```
 fun x0 (e1,e2...)
```

type rule: type of en = tn
evaluate rule:

we use the environment at the point of
the call to evaluate e0 to v0, e1 to v1, ..., en to vn. Then v0 must be a function (it will be assuming the
call type-checked) and we evaluate the function’s body in an environment extended such that the function
arguments map to v1, ..., vn.
Exactly which environment is it we extend with the arguments? The environment that “was current” when
the function was defined, not the one where it is being called. This distinction will not arise right now, but
we will discuss it in great detail later



Integer... data type, Case When Else, IF Else ..., comparison... is code component.

value => expression that have no other logic to evaluate.

syntax =>  how you write sth down

ML type check in static env, evaluate in dynamic env

when type checking, ML use the binding of all static env(aka context) to determine what the type of expression, then the set the type of binding variable to the type of expresstion
when evaluate, ML use the binding of all dynamic env to determine what the value of expression, then set the value of binding variable to the value of expresstion

semantics (how it type-checks and evaluates)

variable binding
only can use previous binding

in dynamic envirement, fetch variable by previous data binding

before dynamic-> static env

expression

z < 0 (expression)

type checking


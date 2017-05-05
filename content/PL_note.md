+++
date = "2016-06-04T12:51:17+08:00"
draft = true
title = "PL_note"

+++

# How to define the programing language

We can define every program language in three spect: syntax, type checking rule, and eveluate rule.

Functional programming is a series of binding.

static environment(context) is the environment with previous type binding.

dynamic environment is the environment with previous value binding.

The type checking execute in static environment. The evaluation is triggered in dynamic environment.

# variable binding

syntax: `val x0 = e0`

type checking: Based on previous type binding in static environment, determine the type of e0. x0 is the type of e0.

evaluation: In dynamic environment with all previous binding values, determine the value of e0. the value of x0 is e0.

Data With Type, Variable, Case When Else(Conditionals), If Else... all can defined by syntax, type checking rule, and evaluation rule.

# How to add a sequence of binding in a file

`use "foo.sml";`

# Variables is immuatable
Can not assign value to a variable, which is defined with binding.
Can bind same variable to another new value. This is called 'shadow'

# function binding

syntax:

fun x0 (x1:t1, x2:t2... xn:tn) = e

## Type checking

- xn is of the type tn. 
- The syntax of a function type is “argument types” -> “result type” where the argument types are separated by * 
- x0 is the type of (t1 * t2 * ... * tn) => t
- Determination of e type t is in the static environment extended (previous type binding) with the all xn type binding. 
- A function is a value — we simply add x0 to the environment as a function that can be called later. As expected for recursion, x0 is in the dynamic environment in the function body and for subsequent bindings ??? (but not, unlike in say Java, for preceding bindings, so the order you define functions is very important).

- ??? Exactly which environment is it we extend with the arguments? The environment that “was current” when the function was defined, not the one where it is being called. This distinction will not arise right now, but we will discuss it in great detail later.

# Pairs and Other Tuples

pairs, tuples

## Syntax:

```
(e1, e2, e3, .. ,en)
```

## Type checking

```
en -> tn

the type of typle = (t1 * t2 * ... * tn)
```

## Evaluation

```
It is value.
```

# Access tuple

## Syntax
  - #1 e

  - Using pair to return an answer that has two parts. This is quite pleasant in ML, whereas in Java (for example) returning two integers from a function requires defining a class, writing a constructor, creating a new object, initializing its fields, and writing a return statement.

# List

- Arbitrary data length, but need to be same data type, write the type of list as `t list`
- Functions that make and use lists are almost always recursive because a list has an unknown length. To write a recursive function, the thought process involves thinking about the base case — for example, what should the answer be for an empty list — and the recursive case — how can the answer be expressed in terms of the answer for the rest of the list.

# Empty List

- syntax: []
- type checking:
```
  ’a list
  ’a = any type t
  can be any type t list.
```

# value(element) onto list (cons)

- syntax: e1 :: e2
- type checking rule: 
```
  e1 -> t1
  e2 -> t2
```
  * e2 is a list with type `t list`
  * e1 has type t

- evaluate rule:
```
e1 -> v1
e2 -> v2
```
  * return a list with first element is v1 and others is the elements of v2 list.

# functions of list

- null, list == [] ? true : false
- hd, first element of list, raise execption if it is empty.
- tl, list without first element, raise execption if it is empty.
- e1::e2    e1 cons on e2, e1 has type t, e2 has type t list.

# Let (local bindings)

- it lets us have local bindings of any sort, including function bindings. Because it is a kind of expression, it can appear anywhere an expression can. WHY?
- This is the concept of local variable and scope comes in.

- syntax: let b1 b2 ... bn in e end
- type checking:
```
  bn(binding n) -> tn
```
  * b2 can use b1 type binding
  * extend static environment with bn, determine e type in this environment.
  * the let expresstion has type same as e.


- evaluate:
```
  bn(binding n) -> vn
```
  * b2 can use b1 variable binding
  * extend dynamic environment with vn, determine e value in this environment.
  * the let expresstion has value same as e.

# Option NONE

syntax:
  NONE

type checking:
  a' option

evaluate
  It is a value.


# Option SOME

syntax:
  SOME e

type checking:
  e -> t
  t option

evaluate
  e -> v
  v

# Option valOf

syntax:
  valOf e

type checking:
  e -> t
  t must be option type
  if e is NONE -> raise exception?
  if e is SOME (t option) -> type is t

evaluate
  SOME has value v
  v

# Option isSome

syntax:
  isSome e

type checking:
  e -> t
  t must be option type

evaluate
  if e is NONE -> false
  if e is SOME -> true

# boolean operation
syntax:
e1 orelse e2
type check:
e1 -> t1 must be bollean type
e2 -> t2 must be bollean type
evaluation:
if e1
then true
else e2

andalso

# the benefic of no mutation

## aliasing v.s. copy

A function may return a aliasing data or a copy of data. We can not knowing which it is in a mutation language.

If that languange have mutation, programmer need to consider that changing a value may effect other code, or the value may be changed by other code.

In mutation language it will not like this.

# datatype binding

# three data type

- each-of-type
  * `int*bool`
- one-of-type
  * `option int`
- recursive
  * `int list` == `int` .. `list of (tl xxx)`

# record type / expression ( each-of type )

syntax:

{ f1 = e1, f2 = e2 ... , fn = en }

f1, f2... fn must be uniq

type check:

en -> tn
the type of whole -> { f1:t1, f2:t2 ... fn:tn }

evaluation

en -> vn

the value of whole -> { f1:v1, ... fn:vn }

acessing

`#f1 e`

will raise error if no f1 key in e.

# syntax suger

A syntax that can be transform to another basic syntax.

Advantage: readibility, easier implementation

## tuple  == resords

(11,22,33) == { 1:11, 2:22, 3:33 }

# data type binding, customize one of type

syntax:

datatype dt1 = c1 of t1
             | cn of tn

cn is constructor, it is a function turn the data to dt1 type.
e.g. c1 : t1 -> dt1

# define datatype (one of type)
datatype dt1 = c1 of t1
             | cn of tn

cn is a constructor of type tn -> dt1
if no 'of tn', just 'cn', then cn is a value of type dt1

syntax:

e1 = c1 ev

type checking:

e1 has type dt1

value:

e1 has value "c1 ev"
c1 as tag

# pattern matching case with data type binding (customized one of type) (constructor pattern)

syntax:

case e0 of
    p1 => e1
  | pn => en

type checking:

  pn is pattern n, using constructor and variable to define
  pn can set variable type binding in en
  e1 .. en should have same type

evaluation
  e0 => v0
  if pn is the first pattern to match vn, then result is evaluation of en, in environment 'extended by the match'

  if pn == Cn(x1,...,cn)
  en is evaluated in a extended environment, x1 to v1 ... xn to vn is added. environment

# alias

syntax:

  type at1 = t1;

  at1 is type alias name;
  t1 -> type 1

# value binding with type checking (strange~ no use?)

syntax:
  
  val t : x = e

type checking:

  e has type x

evaluation:

  e -> v

# NONE and SOME are constructor of option type !

case intoption of
  NONE => 0
  SOME i => i

# [] and :: are constructor of list type

# list are option are constructor that take parameter to construct type(value?)

# polymorphic datatype

datatype that take more than two constructor(parameter?)

  
  e.g.

  datatype 'a option = NONE | SOME of 'a

  datatype 'a mylist = Empty | Cons of 'a * 'a mylist

  datatype 'a ('a, 'b) tree = 
    Node of 'a * ('a, 'b) tree * ('a , 'b) tree
  | Leaf of 'b

# val binding pattern matching

syntax:
  val v(p) = e

In fact, variable is a pattern.

can use this for extract all pieces out of an each of type.

pool style to do this in constructor style. (case ...)

e.g.

 val (x, y, z) = (1, 2, 3)

# equality type

  ''a list * ''a -> boo;

  ''a must be a equality type(Can use equal to compare things.).

# case expresstion without constructor, only data type matching

syntax:

  case e0 of
    p1 => e1
    pn => en

type checking:

  if e0 match pn then execute en in extract environment ( val pn = en; is added).
  e0 => t
  all branch en must have t type.

evaluation:

  if e0 match pn then execute en in extract environment ( val pn = en; is added)
  e0 => v0

# _ can represent random type in case expresstion

# special patern

a::b::c::d
a::b::c::[]
((a,b),(c,d))::e


# fun in ML always take only one argument, usng pattern matching to do extended variable into environment
  
# function pattern (syntax suger)

fun f x =
  case x of
   p1 => e1
   pn => en

all equal except no x can be use in en

fun f p1 => e1
    | pn => en

# exception binding

exception Ex1 of type1

raise (Ex1(e))
e must have type1 

e1 handle Ex1 => e2

# call stack
# tail call


# Elixir

Unlike SML, Elixir list can have different type. 

Elixir Tuples, syntax: {}, save in memory. So it will be faster than list.

Execute some method on list may need to traverse whole list, such as length.

## bollean operation

and == &&
or == ||

For elixir, both are short-circuit operators. They only execute the right side if the left side is not enough to determine the result.


#h/k
1. max value of +-*/ tree
2. sum of link structure
undecreasing?
zip, unzip, multign

+++
date = "2016-06-04T12:51:17+08:00"
draft = true
title = "PL_note"

+++

# How to define the programing language

We can define every program language in three spect: syntax, type checking rule, and eveluate rule.

Functional programming is a series of binding.

static envirement(context) is the envirement with previous type binding.

dynamic envirement is the envirement with previous value binding

The type checking execute in static envirement. The evaluate execute in dynamic envirement.

# variable binding

syntax: `val x0 = e0`

type checking: on the base of the previous type binding of the static envirement, determine the type of e0. x0 is the type of e0.

evaluate:  in dynamic envirement, with all previous binding values. determine the value of e0. the value of x0 is e0.

Data With Type, Variable, Case When Else(Conditionals), If Else... all can defined by syntax, type checking rule, and evaluate rule.

# How to add a sequence of binding

`use "foo.sml";`

# Variables is immuatable
Can not assign value to a variable, which is defined with binding.
Can bind a same variable to a new value, that called 'shadow'

# function binding

syntax:

fun x0 (x1:t1, x2:t2... xn:tn) = e

type checking: 

xn is of the type tn. 

The syntax of a function type is “argument types” -> “result type” where the argument types are separated by * 

Determine e type t in the static envirement extended (previous type binding) with the all xn type binding. 

x0 is the type of (t1 * t2 * ... * tn) => t

A function is a value — we simply add x0 to the environment as a function that can be called later. As expected for recursion, x0 is in the dynamic environment in the function body and for subsequent bindings (but not, unlike in say Java, for preceding bindings, so the order you define functions is very important).

Exactly which environment is it we extend with the arguments? The environment that “was current” when the function was defined, not the one where it is being called. This distinction will not arise right now, but we will discuss it in great detail later.

# Pairs and Other Tuples

pairs, tuples

syntax:

(e1, e2, e3, .. ,en)

type checking rule:

en -> tn

the type of typle = (t1 * t2 * ... * tn)

evaluate rule:

It is value.

# access tuple

syntax: 

 #1 e

# return using pair

Using pair to return an answer that has two parts. This is quite pleasant in ML, whereas in Java (for example) returning two integers from a function requires defining a class, writing a constructor, creating a new object, initializing its fields, and writing a return statement.

# list

Arbitrary data length, but need to be same data type, write the type of list as `t list`

Functions that make and use lists are almost always recursive because a list has an unknown length. To write a recursive function, the thought process involves thinking about the base case — for example, what should the answer be for an empty list — and the recursive case — how can the answer be expressed in terms of the answer for the rest of the list.

# Empty List

syntax:

[]

type checking:
 
’a list
,a = any type t
can be any type t list.

# value(element) onto list

syntax: e1 :: e2

type checking rule: 

e1 -> t1
e2 -> t2

e2 is a list with type `t list`

e1 has t

evaluate rule:

e1 -> v1
e2 -> v2

return a list with first element is v1 and others is the elements of v2 list.

# functions of list

null, list == [] ? true : false
hd, first element of list
tl, list without first element

# Let

it lets us have local bindings of any sort, including function bindings. Because it is a kind
of expression, it can appear anywhere an expression can.

This is the concept of local variable and scope comes in.

syntax:

let b1 b2 ... bn in e end

type checking:

bn(binding n) -> tn

b2 can use b1 type binding

extend static environment with bn, determine e type in this environment.

the let expresstion has type same as e.

evaluate:

bn(binding n) -> vn

b2 can use b1 variable binding

extend dynamic environment with vn, determine e value in this environment.

the let expresstion has value same as e.

# Let

This technique — define a local function that uses other variables in scope — is a hugely common and convenient thing to do in functional programming. It is a shame that many non-functional languages have little or no support for doing something like it.

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
  if e is NONE -> 
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

Also, in mutation language

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

{ f1: e1, f2: e2 ... , fn:en }

f1, f2... fn must be uniq

type check:

en -> tn
the type of whole -> { f1:t1, f2:t2 ... fn:tn }

evaluation

en -> vn

the value of whole -> { f1:v1, ... fn:vn }

acessing

`#f1 e`

# syntax suger

A syntax that can be transform to another basic syntax.

Advantage: readibility, easier implementation

## tuple  == resords

(11,22,33) == { 1:11, 2:22, 3:33 }

# data typing, customize one of type

syntax:

datatype dt1 = c1 of t1
             | cn of tn

cn is constructor, it is a function turn the data to dt1 type.
e.g. c1 : t1 -> dt1


# Elixir

Unlike SML, Elixir list can have different type. 

Elixir Tuples, syntax: {}, save in memory. So it will be faster than list.

Execute some method on list may need to traverse whole list, such as length.

## bollean operation

and == &&
or == ||

For elixir, both are short-circuit operators. They only execute the right side if the left side is not enough to determine the result.



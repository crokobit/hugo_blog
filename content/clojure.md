# variable binding
- (def variable value)
# statement
- (function params)
# function binding
- (defn name [params] body)
# function pattern maching
- Functions can be defined to take different numbers of arguments (different "arity"). --> function pattern maching
```
(defn messenger
  ([]     (messenger "Hello world!"))
  ([msg]  (println msg)))
```
# Variadic functions `& params` -->  in ruby  def some_method(*p); end
- &
- Functions may also define a variable number of arguments - this is known as a "variadic" function. The variable arguments must occur at the end of the argument list.
- ??? looks like the params would be a Lists.
```
(defn hello [greeting & who]
  (println greeting who))

user=> (hello "Hello" "world" "class")
Hello (world class)
```

# return value?
- Many languages have both statements, which imperatively do something and do not return a value, and expressions which do. Clojure has only expressions that return a value. 
- Expressions that exclusively perform side-effects return nil.

# fn anonymous function
```
(fn [name] (str "hello" name))
same as 
[name] (str "hello" name)
```
# ()
- Many languages have both statements and expressions, where statements have some stateful effect but do not return a value. In Clojure, everything is an expression that evaluates to a value. Some expressions (but not most) also have side effects.
- return a value
# anonymous function without fn (syntax suger)
- `(fn [args] body)` same as `#(body)`
- % %1 %2 ... %& to reference variable
- %& to reference variadic args
```
;; Equivalent to: (fn [x] (+ 6 x))
#(+ 6 %)

;; Equivalent to: (fn [x y] (+ x y))
#(+ %1 %2)

;; Equivalent to: (fn [x y & zs] (println x y zs))
#(println %1 %2 %&)
```
# local variable binding
```
;;      bindings     name is defined here
;;    ------------  ----------------------
(let  [name value]  (code that uses name))
```

# ??? ()
```
user=> (defn triplicate [f] (f) (f) (f))

user=> (defn triplicate2 [f & args]
  #_=> (triplicate (fn [] f args)))
#'user/triplicate2
user=> (triplicate2 println 1 2 3)
(1 2 3)
user=> (defn triplicate2 [f & args]
  #_=> (triplicate (fn [] (f args))))
#'user/triplicate2
user=> (triplicate2 println 1 2 3)
(1 2 3)
(1 2 3)
(1 2 3)
```

# apply
- pass list into function as seperate args
```
(apply f '(1 2 3 4))    ;; same as  (f 1 2 3 4)
(apply f 1 '(2 3 4))    ;; same as  (f 1 2 3 4)
(apply f 1 2 '(3 4))    ;; same as  (f 1 2 3 4)
(apply f 1 2 3 '(4))    ;; same as  (f 1 2 3 4)

(defn plot [shape coords]   ;; coords is [x y]
  (plotxy shape (first coords) (second coords)))
```

# Vector -- like Tuples in SML
- methods: get, count, conj, vector(same as [], to create vector)

# immutablility
- Any function that "changes" a collection returns a new instance. 

# Lists
- create by '()
- methods: first, rest, conj(added at front), peek(as stack), pop(as stack)

# Sets
- Sets are like mathematical sets - `unordered` and with `no duplicates`. Sets are ideal for efficiently checking whether a collection contains an element, or to remove any arbitrary element.
- #{a,b...}
- method: conj, disj(remove element), contains, into(put set tinto another set)

# Maps -> Records in SML
- can be treat as function name to get value
- You should not directly invoke a map unless you can guarantee it will be non-nil:
```
user=> (def directions {:north 0
                        :east 1
                        :south 2
                        :west 3})
#'user/directions

user=> (directions :north)
0

user=> (directions :foo)
NullPointerException
```

- { k1 v1 k2 v2 }
- sorted-map( (sorted-map k1 v1 k2 v2) )
- methods: assoc(adding one pair of key, value), dissoc(remove by key), get, contains?, find, keys, values, zipmap(two set to one map with key value together), merge(merge maps), sorted-map(default using compare), get-in(nested get), assoc-in, update-in
- `merge-with` If both maps contain the same key, the rightmost one wins. Alternately, you can use merge-with to supply a function to invoke when there is a conflict:
```
user=> (merge-with + scores new-scores)
```

# Field accessors for Map
- (get map1 :xxx)
- (map1 :xxx)
- (:xxx map1) ; can set default value (:xxx map1 default)

# Record in Clojure
- consturcted by specific record constructor (a new type) for specific Map structure
```
defrecord Person [first-name last-name age occupation]
(->Person "Kelly" "Keen" 32 "Programmer")
#user.Person{:first-name "Kelly", :last-name "Keen", :age 32, :occupation "Programmer"}

# flow control
- (if XXX then-statement else-statement)
- only nil or false is false
- `do` to create larger block for side effect?
```
(if (even? 5)
  (do (println "even")
      true)
  (do (println "odd")
      false))
```
- when is an if with only a then branch. It checks a condition and then evaluates any number of statements as a body (so no do is required). The value of the last expression is returned. If the condition is false, nil is returned.
- cond is a series of tests and expressions. Each test is evaluated in order and the expression is evaluated and returned for the first true test. if no test is satisfied, nil is returned. A common idiom is to use a final test of :else. Keywords (like :else) always evaluate to true so this will always be selected as a default.

```
(let [x 11]
  (cond
    (< x 2)  "x is less than 2"
    (< x 10) "x is less than 10"
    :else  "x is greater than or equal to 10"))
```
- case compares an argument to a series of values to find a match. This is done in constant (not linear) time! However, each value must be a compile-time literal (numbers, strings, keywords, etc). Unlike cond, case will throw an exception if no value matches. Can have else branch.
```
user=> (defn foo [x]
         (case x
           5 "x is 5"
           10 "x is 10"))
#'user/foo

user=> (foo 10)
x is 10

user=> (foo 11)
IllegalArgumentException No matching clause: 11

user=> (defn foo [x]
         (case x
           5 "x is 5"
           10 "x is 10"
           "x isn't 5 or 10"))
#'user/foo

user=> (foo 11)
x isn't 5 or 10
```



# get
- can set default value

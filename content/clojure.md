# variable binding
- (def variable value)
# statement
- (function params)
# function binding
- (defn name [params] (body))
# function pattern maching
- Functions can be defined to take different numbers of arguments (different "arity"). --> function pattern maching
```
(defn messenger
  ([]     (messenger "Hello world!"))
  ([msg]  (println msg)))
```
# Variadic functions --> splash in ruby 
- Functions may also define a variable number of arguments - this is known as a "variadic" function. The variable arguments must occur at the end of the argument list.
```
(defn hello [greeting & who]
  (println greeting who))

user=> (hello "Hello" "world" "class")
Hello (world class)
```
# fn anonymous function
- Many languages have both statements, which imperatively do something and do not return a value, and expressions which do. Clojure has only expressions that return a value. 
```
(fn [name] (str "hello" name))
same as 
[name] (str "hello" name)
```
# ()
- Many languages have both statements and expressions, where statements have some stateful effect but do not return a value. In Clojure, everything is an expression that evaluates to a value. Some expressions (but not most) also have side effects.
- return a value
# anonymous function without fn (syntax suger)
- % %1 %2 ... %&
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

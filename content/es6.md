+++
date = "2017-02-10T16:07:42+08:00"
draft = true
title = "es6"

+++

[egghead es6](https://egghead.io/courses/learn-es6-ecmascript-2015)

# arrow function

```
function(x1, x2){
  statement
}

(x1, x2) => statement
```

- can ignore () if just have one parameter.

- when defining multi line function, we can have no return keyword by change {} to (), () is treated as a expression
e.g.
```
  f1 = () => { 
    return 'A' 
  }
```
is same as 
```
  f1 = () => ( 
    'A' 
  )
```

# let, const

- var defined global variable
- let defined local variable
- const defined local varialbe that can not change its reference
  - but can change it's related reference. e.g. value inside array.

# object enhancement

- variable name as object key name.

```
  let name = 'ivan'
  let object = {
    name: name
  }
```

```
  let name = 'ivan'
  let object = {
    name
  }
```

- `function` keyword is ignorable...

```
let company = {
  persons,
  go: function(){
    console.log('as');
  }
}
```

```
let company = {
  persons,
  go(){
    console.log('as');
  }
}
```

```
let company = {
  persons,
  ['go']: function(){
    console.log('as');
  }
}
```

all can call go function by `company.go()`

# spread operator

- `...`
- ...[1,2,3] => 1,2,3
- use when adding array together or passing n parameter into a `function(n1, n2..., n)`

# template literal

https://egghead.io/lessons/ecmascript-6-string-templates

- ``${js statements}``
- ???
```
var string = `s1${33}s2`;

function tag(strings, ...values){
  console.log(strings);
  console.log(values);
}

tag(string);

//strings will be ['s1', 's2']
//values will be [33]
```

# Destructuring Assignment with object or array
- related to element name in object
- related to order in array

# module import export (named export)
- export
  - add `export` before function or var
  - add `export {function_1, var_1}` at last line
- import
  - `import * as additon from ''`         used by `addtion.function_1`
  - `import {function_1, var_1}`
  - `import {function_1 as addTwo, var_1}`

# defaule export (one per module)
- The operand of the default export declaration is an expression, it often does not have a name. Instead, it is to be identified via its module’s name.
- export
  - `export default function () { ... };`
- import
  - `import default as function_x, { named_function } from ''`
  - `import function_x, { named_function } from ''`

# Array.from
- turn Array Like obj into Array for using `forEach` and `filter` etc.
- [ref](https://egghead.io/lessons/ecmascript-6-converting-an-array-like-object-into-an-array-with-array-from#/tab-discuss)
  - Array.from() lets you convert an "iterable" object (AKA an array-like object) to an array. In this lesson, we go over grabbing DOM nodes and turing them into an array so that we can use methods like Array.filter() and Array.forEach() on them.
  - Some more background. NodeList, HTMLCollection, etc. are both Iterable (they implement [Symbol.iterator] on their prototype, and ArrayLike (they have an integer length property). The cool thing about Array.from is that is handles both cases, so anything that you might previously have done [].slice.call(ArrayLike) on is covered, as are Iterables (the result of generators, along with Map, Set, TypedArray, etc) It turns out that most ArrayLike objects (such as arguments) are also Iterable in ES6, and projects are following suit (e.g. jQuery returns Iterable collections now).
- [](https://developer.mozilla.org/zh-TW/docs/Web/API/Document/querySelectorAll)
  - return NodeList

- WebApi
  [](https://developer.mozilla.org/en-US/docs/Web/API)

# Promise
[](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/promise)
```
var d = new(Promise(resolve, reject) => {
});

d.then(function_fire_by_resolve);
d.catch(function_fire_by_reject);

d.then(function_fire_by_resolve, function_fire_by_reject);

```
# Generator

```
  function* gen() {
    yield 'haa'
    var param = yield 'sese'
    yield 'susu'
    yield 'hehoho'
  };

  let greet = gen();
  green.next(); // { value: 'haa', done: false}
  green.next('momo'); // { value: 'sese', done: false}
  green.next(); // return 'momo' from previous yield (param will be 'momo'), then go executing code to next yield, { value: 'haa', done: false}
  green.next(); // { value: undefined, done: true} when yield to yield.
```

# Map


# JS
[undefined is undefined](https://pjchender.blogspot.tw/2015/12/javascript-undefinedundefined.html)
  - `undefined` is a value.
  - declaration without assign value will cause that the variable value is `undefined`.
  - will get `Uncaught ReferenceError, xxx is not defined` if xxx is.
  - `not defined` is different from `undefined`
[hoisting](https://pjchender.blogspot.tw/2015/12/javascript-hoisting.html)
  - js will move all declation to top of the codebase.
  - below are declations
    - var a;
    - var a = 'xxd'; // declaration is placed to top but assign part isn't.
    - function b(){}; // this is a function statement. to the top, code included. calling b() before declaration will get result.
[function statements and function expressions](https://pjchender.blogspot.tw/2016/03/javascriptfunction-statements-and.html)
  - function expression
    ```
      var sayGreet = function(){ console.log(hi); }
    ```
    - The variable will be hoisting but the code will not be hoisting. Calling sayGreet() before defining it will get `Uncaught TypeError: SayHello is not a function`. # NEED CHECK
  - function statement
    ```
      function sayGreet(){ console.log(hi); }
    ```
  - sayGreet return code, sayGreet() return execute result
  - function as function
    ```
      function log(a) { a() }
      log(function(){ console.log('...'); });
    ```
[IIFES](https://pjchender.blogspot.tw/2016/05/javascriptiifesimmediately-invoked.html)
  - var xxx = function(){}();
  - return anonymous function instantly
  - (function(){}());



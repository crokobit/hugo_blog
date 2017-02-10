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

- `${js statements}`
- have stange passing parameter behaviour?

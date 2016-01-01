+++
date = "2016-01-01T17:10:40+08:00"
draft = true
title = "lambda_and_proc"

+++

Differences between Procs and Lambdas

- received parameter behavior with wrong number parameter
  - Proc -> no error 
  - lambda -> error
- return behavior
  - Proc -> return to outside where Proc be called
  - lambda -> return to where lambda be called

Proc.new == lambda, can parameterize

{} == do ... end, only can be used by putting after the function.
Still generating a Proc object when doing this.

&block for passing Block(Proc) into function

yield = block.call

proc is object.
block( do..end, {}, &block) isn't.
So block can not be assigned to variable.

can only pass one block to function(syntax constraint),
but can have multiple proc parameter.

can pass parameter to yield or &block.call.

"code block has the scope where it is defined, it can use the variable can be found when defining itself" 
From Eloquent Ruby

can use varaible excute the block and catch the return value for excute arround purpose.

The whole idea of execute around is that the caller is guaranteed that this will happen before the code block fires and that will happen after.
From Eloquent Ruby

execute around make your code a bit easier to read. 
e.g. say_with_block{ "something" }

r.f.
http://awaxman11.github.io/blog/2013/08/05/what-is-the-difference-between-a-block/
http://railsfun.tw/t/method-block-yield-proc-lambda/110


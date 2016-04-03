+++
date = "2016-03-24T06:43:19+08:00"
draft = true
title = "working_with_ruby_thread"

+++

# Introduction
  - ||= is not thread safe ? XD

# Threads of Execution
  - It's harder to grasp that there can be multiple threads of execution operating on the same code at the same time. This is precisely the case in a multi-threaded environment. Multiple threads of execution can be traversing their own paths, all at the same time.
  - It's harder to grasp that there can be multiple threads of execution operating on the same code at the same time. This is precisely the case in a multi-threaded environment. Multiple threads of execution can be traversing their own paths, all at the same time.
  - can ask top(1) how many threads this process has: `top -l1 -pid 8409 -stats pid,th`
  - when we create 100 threads, those 100 threads are handled directly by the operating system.
  - Any time that you have two or more threads trying to modify the same thing at the same time, you're going to have issues. This is because the thread scheduler can interrupt a thread at any time.

# ch3
  - Calling #join on the spawned thread will join the current thread of execution with the spawned one. In other words, where there were previously two independent threads of execution, now the current thread will sleep until the spawned thread exits.
  - When one thread has crashed with an unhandled exception, and another thread attempts to join it, the exception is re-raised in the joining thread.
  - you can see that it properly places the site of the exception on line 2, rather than on the line where the join occured.
  - 

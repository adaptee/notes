============================
Coroutines and Concurrency
============================

------------------------------
A Curious Course
------------------------------


Coroutines - The most *obscure* Python feature?

Concurrency - One of the most *difficult* topics in computer science
(usually best avoided)

This tutorial *mixes them together* .

Most of the groundwork for coroutines occurred in the 60s/70s and then *stopped*
in favor of *alternatives* (e.g., *threads*, *continuations*)


Part 1. Introduction to Generators and Coroutines
==================================================

One of the most powerful applications of generators is setting up
*processing pipelines*.

You can stack a series of generator functions together into a pipe and
*pull* items through it with a for-loop


All coroutines must be "*primed*" by first calling `.next()` (or `send(None)`)
This advances execution to the location of the first `yield` expression.

You can use `.close()` to shut down a coroutine.

coroutine can detect that shutdown operation by catching `GeneratorExit`. but
the only legal action is to clean up and return.

You can also use `.throw()` to throw a exception into coroutine.

Despite some similarities, Generators and coroutines are basically
two **different** concepts

    - Generators **produce** values, and are often used with iteration.

    - Coroutines **consume** values, and are not related with iteration.

    - You *should* **NOT** mix the two concepts together.

        Bad idea::

            ...
            ret = (yield item)
            ...

Part 2. Coroutines, Pipelines, and Dataflow
==================================================

Coroutines can be used to set up pipes, through chaining together with `send()`.

That pipeline needs an initial *source* (producer), which is typically **NOT**
a coroutine.

It also needs an *end-point* (sink) to collect all data sent to it and process
them, which is typically **NOT** a coroutine.


- Generators **pull** data through the pipe with *iteration*.

- Coroutines **push** data into the pipeline with `send()`.


With coroutines, you can send data to multiple destinations, i.e,
*mutiplexing* and *broadcasting*.


Part 4. From Data Processing to Concurrent Programming
=======================================================

A Common Theme:

- You *send* data to coroutines
- You *send* data to threads (via queues)
- You *send* data to processes (via messages)

Coroutines **naturally** tie into problems involving threads and processes.

You can **package** coroutines inside threads or subprocesses.

With coroutines, you can **separate** the implementation of a task from
its execution environment:

- The coroutine is the **implementation**.
- The **environment** is whatever you choose (threads, subprocesses,
  network, etc.)


Calling `send()`  on a coroutine must be *properly synchronized*. If you call
`send()` on an already-executing coroutine, your program will *crash*.

Example : Multiple threads sending data into the same target coroutine.


Stacked sends will build up a kind of call-stack, because `send()`
doesn't return until the target `yields` .


Part 5. Coroutines as Tasks
=======================================================

In concurrent programming, one typically subdivides problems into "tasks"

Tasks have a few *essential* features:

-  *Independent* control flow
-  *Internal* state
-  Can be *scheduled* (suspended/resumed)
-  Can *communicate* with other tasks


**Coroutines are tasks**.


Part 7. Let's Build an Operating System
=======================================================


Part 8. The Problem with the Stack
=======================================================

`yield` can only suspend current function; it won't suspend those who call this
function.


Part 9. Some Final Words
=======================================================

Python generators are **FAR MORE powerful** than most people realize.

Coroutines were initially developed in the 1960's and then just sort of
died quietly. Maybe they *died for a good reason*.

If you are going to use generators/coroutines it is critically important to
**NOT MIX** programming paradigms together.


There are three main uses of yield:

    - Iteration (a producer of data)
    - Receiving messages (a consumer of data)
    - A trap (cooperative multitasking)











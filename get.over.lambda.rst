Chp 1. Introduction
===============

Once the features are fully understood, the correct styles are obvious. An auxiliary theme of this book, one that applies to any programming language, is that in programming, style is not something to pursue directly. Style is necessary only where understanding is missing1 A corollary to this is that sometimes the only way to effectively use something you don't understand is to copy styles observed elsewhere. .

ecognising where to apply macros is an acquired skill that comes directly from writing them.

without careful planning and lots of effort, large portions of any programs will have redundant patterns and inflexible abstractions littered throughout.

It is not enough to understand how to write macros; a professional lisp programmer needs to know why to write macros.

C programmers who are new to lisp often make the mistake of assuming that the primary purpose of a macro is to improve the efficiency of code at run-time2 C programmers make this mistake because they are used to a "macro system" that is good for little else. . While macros are often very useful for this task, by far the most common use of a macro is to make the job of programming a desired application easier.

this book focuses heavily on combinations of macros. This topic has a frightening reputation and is well understood by few, if any, programmers. Combinations of macros represent the most vast and fertile area of research in programming languages today. Academia has squeezed out most of the interesting results from types, objects, and prolog-style logic, but macro programming remains a huge, gaping black hole.

A language without lisp macros is a Blub.

Chp 2. Closures
================


Closures are one of those few curious concepts that are paradoxically difficult because they are so simple. Once a programmer becomes used to a complex solution to a problem, simple solutions to the same problem feel incomplete and uncomfortable.

The difference between C environments and lisp environments is that unless you explicitly tell lisp otherwise it always assumes you mean to use indefinite extent.

Variables don't have types. Only values have types.

2.3 Lexical and Dynamic Scope
------------------------------

Although the scoping methods provided by C-like languages are limited, C programmers need to program across different environments too. To do so, they often use an imprecisely defined scoping known as pointer scope.

Lexical scope is the enabling feature for closures. In fact, closures are so related to this concept of lexical scope that they are often referred to more specifically as lexical closures to distinguish them from other types of closures.

In addition to lexical scope, COMMON LISP provides dynamic scope. This is lisp slang for the combination of temporary extent and global scope.

In COMMON LISP we deliberately choose to call attention to variables accessed with dynamic scope by calling them special variables. These special variables can be defined with defvar.

Only special variables can be unbound--lexical variables are always bound and thus always have values.

Just as with lexical variables, we can assign a value to special variables with setq or setf.

Special variables are most interesting when they are re-bound, or shadowed, by new environments.

pecial variables are perpetually associated with the symbol used to name them. This is in direct contrast to lexical variables. Lexical variables are only indicated with symbols at compile-time. Because lexical variables can only be accessed from inside the lexical scope of their bindings, the compiler has no reason to even remember the symbols that were used to reference lexical variables so it will remove them from compiled code.

Dynamic scoping used to be a defining feature of lisp but has, since COMMON LISP, been almost completely replaced by lexical scope.

2.4 Let It Be Lambda
--------------------

Essentially, lambda is just a symbol, which only has a special meaning when it appears as the first element of a list. When it appears there, the list is referred to as a lambda form . But this form is not a function. This form can be converted into a function using the `function` special form::

    (function '(lambda (x) (+ 1 x)) )

COMMON LISP provides us a convenience shortcut for this with the #' read macro::

    #'(lambda (x) (+ 1 x))

As a further convenience feature, lambda is also defined as a macro that expands into a call to the function special form above.

Thanks to the lambda macro, there are rarely good reasons to prefix your lambda forms with #' .

lisp compilers can often optimise lambda expression out of existence completely, which is calld lambda folding.

The use of a let enclosing a lambda expression is very important

2.5 Let Over Lambda
--------------------

In a let over lambda scenario, the last form returned by a let statement is a lambda expression. It literally looks like let is sitting on top of lambda::

    (let ((x 0))
        (lambda () x))

One way of thinking about closures is that they are functions/procedures with state.

2.6 Lambda Over Let Over Lambda
--------------------------------

Lambda over let over lambda forms can be called **anonymous classes**.

2.7 Let Over Lambda Over Let Over Lambda
-----------------------------------------------

Let and lambda are fundamental; objects and classes are derivatives.

Chp 3. Macro Basics
====================

3.1 Iterative Development
------------------------------

Because macro programming requires the programmer to think about multiple levels of code executed at multiple points in time, the complexity issues scale more rapidly than other types of programming.


3.2 Domain Specific Languages
------------------------------

A symbol in lisp exists mostly to be something not eq to other symbols. symbols provide a very fast and convenient way to let two or more different lisp expressions know you're referring to the same thing.

Numbers and strings and some other primitives evaluate to themselves; Symbols, however, don't typically evaluate to themselves. When lisp evaluates a symbol it assumes you are referring to a variable and tries to look up the value associated with that variable in the given lexical context.

Some symbols do evaluate to themselves, for example: t, nil, and keywords.

Macros are good enough for implementing the COMMON LISP language and they are good enough for implementing your own domain specific languages.

3.3 Control Structures
--------------------------

Sometimes to understand a macro it helps to macroexpand an example use of this macro.

`mapcar` turns up quite often in macros.

3.4 Free Variables
--------------------

free variable capture vs free variable injection

3.5 Unwanted Capture
--------------------

The real solution to unexpected variable capture is known as the generated symbol, or `gensym` for short.


COMMON LISP's wise design decision to separate the variable namespace from the function namespace eliminates an entire dimension of unwanted variable capture problems.

There are two ways to look at the arguments regarding macros and namespaces. The first is that a single namespace is of fundamental importance, and therefore macros are problematic. The second is that macros are fundamental, and therefore a single namespace is problematic.

When dissecting any macro, the first step is to stop. Don't think of a macro as a syntax transformation or any other such nonsense abstraction. Think of a macro as a special function. A macro is a function underneath, and works in nearly the exact same way. The function is given the unevaluated expressions provided to it as arguments and is expected to return code for lisp to insert into other expressions.

Nested backquotes in macro definitions are notoriously difficult to understand.


3.6 Once Only
---------------

The point of once-only is make sure the argument is evaluated only once when executing the results of macro expansion.

3.7 Duality of Syntax
-----------------------

One of the most important concepts of lisp is called duality of syntax.

Referential transparency is sometimes defined as a property of code where any expression can be inserted anywhere and always have the same meaning.

Introducing syntactic duals is the conscious violation of referential transparency

COMMON LISP uses the same syntax for accessing both of its major types of variables, dynamic and lexical.

The purpose of dynamic scope is to provide a way for getting values in and out of lisp expressions based on when the expression is evaluated, not where it is defined or compiled.

without external context in the form of a declaration, you can't tell which type of variable an expression is referring to. This dual syntax violates referential transparency, but rather than being something to avoid, lisp programmers welcome this because just as you can't differentiate an expression without context, neither can a macro.

Some early lisps did support dynamic closures, but COMMON LISP  only support lexical closure.

So lexical and dynamic variables are actually completely different, deservedly distinct concepts that just happen to share the same syntax in COMMON LISP code. Why on earth would we want this so-called duality of syntax? The answer is subtle, and only consciously appreciated by a minority of lisp programmers, but is so fundamental that it merits close study. This dual syntax allows us to a write a macro that has a single, common interface for creating expansions that are useful in both dynamic and lexical contexts.

A traditional convention in COMMON LISP code is to prefix and postfix the names of special/dynamic variables with asterisk characters.


Chapter 1. Introduction
=====================================

1.1. A Tour of Ruby
-------------------------------------


Ruby is a completely object-oriented language. Every value is an object, even
simple numeric literals and values such as `true`, `false`, and `nil`.

In many languages, function and method invocations require parentheses.In Ruby,
*parentheses* are usually *optional* and commonly *omitted*, especially when the
method being invoked takes no arguments.

The use of `iterators` and `blocks` is another notable feature of Ruby.

`Hashes` use `[ ]`, like `arrays` do, to query and set values in the hash.

`Symbols` are *immutable*, *interned* strings. They can be compared by *identity*
rather than by textual content (because two distinct Symbol objects will never
have the same content).

Double-quoted strings can include arbitrary Ruby expressions delimited by `#{}` .
The value of the expression is converted to a string, which si then used to
replace the expression and its delimiters.  This substitution is usually called
`string interpolation`.


Ruby's syntax is `expression-oriented`. Control structures such as `if` that
would be called statements in other languages are actually expressions in Ruby.
They have values like other simpler expressions do.

Many of Ruby's `operators` are implemented as `methods`.

Methods are defined with the `def` keyword. The *return value* of a method is
the value of the *last expression evaluated* in its body.

classes and modules are "open" and can be modified and extended at runtime.

Ruby supports `parallel assignment`, allowing more than one value and more than
one variable in assignment expressions.

Methods are allowed to return multiple values, and parallel assignment is
very useful in conjunction with such methods.

Methods whose name end with `=` are special because Ruby allows them to be
invoked using `assignment syntax`.

Method names can also ends with `?` and `!`
    - `?` is used to mark predicators,
    - `!` is used to mark methods to be used with caution


A number of core Ruby classes define pairs of methods with the same name,
except that one ends with an exclamation mark and one does not. Usually,
the method without the exclamation mark returns a modified copy of the object
it is invoked on, and the one with the exclamation mark is a `mutator` method
that alters the object **in place**.

Global variables are prefixed with `$` , instance variables are prefixed with
`@`, and class variables are prefixed with `@@`.

`Regex` and `ranges` have a literal syntax in Ruby:

    - /regex/
    - 1..5

Ruby's strings are `mutable`.

Because strings are mutable, `string literals` are not unique objects.

You call the `freeze` method on a string (or on any object) to prevent any
future modifications to that object.

`nil` is treated as `false`, and **any** other value is tread as `true`.

1.2. Try Ruby
-------------------------------------

`print` does not append a newline.

`p` is silimar to `puts`, but its output is more friendly to programmers.

Chapter 2. The Structure and Execution of Ruby Programs
========================================================

2.1. Lexical Structure
-------------------------------------

`embedded document` s a convenient way to write comments of multiple lines.

**Never** put a space between method name and the opening parenthesis.

Always run the Ruby interpreter with the `-w` option

2.2. Syntactic Structure
-------------------------------------

Ruby codes are, by convetions, indented by 2 spaces.

There are two kinds of blocks :

    -   `block`: the chunks of code associated with `iterator methods`

    -   `body`: body of class/method defintition, while/for loop


2.3. File Structure
-------------------------------------

Ruby Programs use `require` to load code from another file.

`__END__`, when residing alone in a line, infomr ruby interpreter to stop
processing this file; remainder of the file is regarded as data.

2.4. Program Encoding
-------------------------------------

By default, Ruby interpreter assumes source code is encoded in ASCII.

It is important to understand the difference between the `source encoding` of
a Ruby file and the default `external encoding` of a Ruby process.

The source encoding of a file affects the encoding of the `string literals`
in that file, which is **specific** to each file.

The default external encoding is the encoding that Ruby uses by default when
reading from files and streams, which is **global** to the Ruby process.


2.5. Program Execution
-------------------------------------

`BEGIN` and `END` blocks

Chapter 3. Datatypes and Objects
========================================================

3.1. Numbers
-------------------------------------

All numeric objects are `immutable`.


3.2. Text
-------------------------------------


Ruby supports a **generalized** quoting syntax for string literals:

    -%q begins a string literal that follows `single-quoted` string rules
    -%Q introduces a literal that follows `double-quoted` string rules

`Here documents` begin with `<<` or `<<-`.

Since strings are mutable,  Ruby creates a new object each time encountering
a string literal.

For efficiency, you should **avoid** using literals within loops.

`character literal`: single characters can be included literally  by preceding
the character with a `?`.

`+` is used to concatenate strings; `<<` is similar, but it modifies in-place.

Ruby does not throw an exception if you try to access a character beyond the end
of the string; it simply returns `nil` instead.

More often than not, you want to retrieve `substrings` from a string. To do this,
use two comma-separated operands between `[ ]`. The first operand specifies an
`index` (which may be negative), and the second specifies a `length` (which must
be nonnegative). The result is the substring that begins at the specified index
and continues for the specified number of characters.

You can also use `range(..)` inside `[ ]`, which specifies two `indexes`.

It is also possible to index a string with another string,  or a `regex`.

Ruby provide 3 methods to `iterate` string in different ways:

    - each_byte : iterate by byte
    - each_char : iterate by char
    - each_line : iterate by line

3.2.6. String Encodings and Multibyte Characters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Method `size` and `length` return the number of characters in string, while
`bytesize` returns the number of bytes of underlying representaion of string.

Method `encoding` returns the encoding of a string.

It is impossible to concatenate a UTF-8 string and an SJIS string: the
encodings are `not compatible`, and an exception will be raised.

Method `force_encoding` can be used to change the way ruby interpretating one
specific string; It won't return a new string nor change the underlying bytes.

On the contrast, method `encode` will return a new string, which represent the
same sequence of characters in specified encoding.

Method `Encoding.list` will list all available encodings.

Method `Encoding.default_external` will return the default external encoding.

Method `Encoding.locale_charmap` will return the encoding used by locale.

3.3. Arrays
-------------------------------------

If you attempt to access an element out of the range of an array, Ruby simply
returns `nil` and does not throw an exception.

Ruby's arrays are **untyped** and **mutable**

You can also create arrays with the `Array.new` constructor.

3.4. Hashes
-------------------------------------

A `hash literal` is written as a comma-separated list of key/value pairs,
enclosed within `{ }`. Keys and values are separated with a `=>` .

In general, `Symbol` objects work more **efficiently** as keys than strings do.

Ruby 1.9 supports a  succinct hash literal syntax when keys are symbols.
In this case, `:` is moves to the end of  key and replaces `=>` . This make it
more like python and javascript. Note that there may not be any space between
the key and `:`.

Example::
    numbers = { one: 1, two: 2, three: 3 }

Objects used as keys in a hash must have a method `hash` that returns a
`Fixnum` hashcode .

The Hash class compares keys for equality with the `eql?` method. For most
classes, eql? works like the `==` operator . If you define a new class that
overrides `eql?` , you must also override `hash` method, or else instances
will not work as keys in a hash.

`mutable` objects are **problematic** as hash keys.

Because strings are mutable but commonly used as keys, Ruby treats them as
a special case and makes **private copies** of all strings used as keys.


3.5. Ranges
-------------------------------------

`..` measn **inclusive**, while `...` means **exclusive**.

Range implies the notation of `ordering` ; Ruby use the `<=>` operator to
calculate ralative ordering between 2 objects.

The primary purpose of range is `comparison`: determine wherther a value is in
or out of the range; the second purpose is `iteration`.

3.5.1. Testing Membership in a Range
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Range membership can be defined in two **different** ways:

    -   continuous membership:

        begin <= x <= end

    -   discrete membership:

        It treats a `begin..end` as a set that includes: begin, begin.succ,
        begin.succ.succ , and so on.

testing for discrete membership is potentially much more **expensive** than
testing for continuous membership.

Ruby 1.9 provide several methods for testing membership:

    -   `cover?` :

        **always** test `continuous` membership

    -   `include`:

        test `continuous` membership if endpoint is number, otherwise test
        `discrete` membership

3.6. Symbols
-------------------------------------

A typical implementation of a Ruby interpreter maintains a `symbol table`
in which it stores various names. This allows avoiding most string comparisons:
it refers to method names (for example) by their position in this symbol table.
This turns a relatively expensive string operation into a relatively cheap
integer operation.

A `Symbol` object refers to a symbol.

`symbol literal` is written by **prefixing** an identifier or string with `:`

`Symbols` are often used to refer to method names in `reflective` code.

`String` and `Symbol` can be converted into each other.

Two strings with the same content will both convert to exactly the same
Symbol object. Two distinct Symbol objects will always have different content.

Whenever you write code that uses strings `not for their textual content` but
as a kind of unique identifier, consider using symbols instead.

Comparing two Symbol objects for equality is **much faster** than comparing
two strings for equality. For this reason, symbols are generally preferred to
strings as hash keys.

3.7. True, False, and Nil
-------------------------------------

When Ruby requires a Boolean value, `nil` behaves like `false`, and any value
other than nil or false behaves like `true`.

3.8. Objects
-------------------------------------

It is not the object itself we manipulate but a reference to it.

Every object has an unique identifier, which can be obtained through
method `object_id`.

Method `class` and `superclass` can be used to obtain class info.

Method `instance_of?` can be  used to check the class.

Method `is_a?` is similar, but it take `subclassing` into consideration.

The `type` of an object is related to its `class`, but the class is only part
of an object's type.

That the type of an object is the **set of methods** it can respond to.

3.8.5. Object Equality
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ruby has a surprising number of ways to compare objects for equality.

    -   `equal?`

        wheter 2 value refer to the `same object`, defined in `Object`

    -   `==`

        simply a synonym for `equal?` , defined in `Object`

        Most classes **redefine** it to allow distinct instances to be
        tested for equality.

        When Ruby sees `!=` , it normally just uses the `==` operator and
        then inverts the result.

    -   `eql?`

        simply a synonym for `equal?`, defined in `Object`

        Classes that override it typically use it as a **strict** version
        of `==` that does no type conversion.

    -   `===`

        More commonly, its use is simply implicit in a `case` statement.

    -   `=~`

        defined by `String` and `Regexp` to perform pattern **matching**

3.8.7. Object Conversion
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`to_s` is intended to return a human-readable representation, while `inspect`
is indended for debugging and should return a representation helpful to
developers.

3.8.8. Copying Objects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Both `clone` and `dup` return a **shallow** copy .

There are some important **differences** between `clone` and `dup` :

    -   `clone` copies both the `frozen` and `tainted` state  of an object,
        whereas `dup` only copies the `tainted` state;

    -   with a frozen object, `clone` return a frozen object, wheras `dup`
        return a non-frozen object.

    -   `clone` copies any `singleton methods` of the object, whereas `dup` not.

3.8.9. Marshaling Objects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`Marshal.dump` and `Marshal.load` can be used to save and restore object.

One useage is to create deepcopy of object, Example::

    def deepcopy(o)
        Marshal.load(Marshal.dump(o))
    end

3.8.11. Tainting Objects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Any object may be marked as tainted by calling its `taint` method.

User input, such as command-line arguments, environment variables, and
strings read with gets, are **automatically tainted**.

Copies of tainted objects made with `clone` and `dup` **remain tainted**.

A tainted object may be untainted with the `untaint` method. You should only
do this after you have examined the object and are convinced that it presents
no security risks.

Chapter 4. Expressions and Operators
=====================================

Many languages distinguish between low-level `expressions` and higher-level
`statements`. In these languages, statements are executed rather than evaluated

Ruby makes no clear distinction between statements and expressions; everything,
including class and method definitions, can be evaluated as an expression and
will return a value.

4.2. Variable References
-------------------------------------

Ruby has four kinds of variables: `local` variables, `global` variables,
`instance` variables, and `class` variables.


4.3. Constant References
-------------------------------------

Constants have the `visibility` of global variables.

`::` is used to **separate** the name of the constant from the class or module
in which it is defined.


4.4. Method Invocations
-------------------------------------

Ruby has a very **pure** OOP model:

    -   objects expose **only methods** .

    -   objects have no real attribute.

Most of Ruby's operators are defined as method innocations.


4.5. Assignments
-------------------------------------

The value of an assignment expression is the value (or an array of the values)
assigned.

Assignment operator is `right-associative`.

**Caution**: ambiguity between local variable names and method names.


We say that m= is a `setter` method and m is a `getter` method.  When an object
has this pair of methods, we say that it has an attribute named as m.

Parallel assignments are really performed **in parallel**, not sequentially.

In parallel assignments, extra rvalues will just be **discarded** silently,
while extra lvalues will be set as `nil`.

lefthand of parallel assignments can use `( )` for `subassignment`. Example::

    x, (y,z) = [1, [2,3]]

The return value of a parallel assignment is the array of rvalues.

4.6. Operators
-------------------------------------

`and`, `or`, and `not` are low-precedence versions of `&&`, `||`, and `!`

`defined?` can be used to check whether variable is defined or not.


`rescue`, `if`, `unless`, `while`, and `until` can also be used as
`statement modifiers`, such as::

    print x if x


Chapter 5. Statements and Control Structures
==============================================

5.1. Conditionals
--------------------


The return value of an if "statement" is the value of the last expression
in the code that was executed.

`unless`, as a statement or a modifier, is the **opposite** of `if`.

`case` statement tests each of its `when` expressions in the order they are
written until it finds one that evaluates to `true`. Once a `when` clause that
evaluates to true has been found, no other `when` clauses are considered(
no fall-through).

The important thing about the `case` statement is how the values of the `when`
clauses are compared to the expression that follows the `case` keyword. This
comparison is done using the `===` operator.

5.2. Loops
--------------------

`until` is the reverse of `while`.

`for` only works for iterating over objects that have `each` methods.


5.3. Iterators and Enumerable Objects
----------------------------------------

`times`, `each`, `map`, and `upto` methods are all `iterator methods`.

The control structure behind this is `yield`.

The `yield` statement is like a method invocation; it is followed by zero or
more expressions whose values are assigned to the `block parameters`.

In Java, the client code  is in control and `pulls` values from the
iterator object.

In Ruby, the `iterator method` is in control and `pushes` values to the block
that wants them.

In method, use `block_given?` to check whether there is a block associated
with this invocation.

An enumerator is an `Enumerable` object whose purpose is to enumerate another
object.

The built-in iterator methods automatically return an enumerator when invoked
with no block associated.

5.3.5. External Iterators
~~~~~~~~~~~~~~~~~~~~~~~~~~~

A fundamental issue is deciding which party controls the iteration, the
iterator or the client that uses the iterator. When the client controls
the iteration, the iterator is called an `external iterator` , and
when the iterator controls it, the iterator is an `internal iterator`
. Clients that use an external iterator must advance the traversal and
request the next element explicitly from the iterator. In contrast,
the client hands an internal iterator an operation to perform, and the
iterator applies that operation to every element....

External iterators are more `flexible` than internal iterators. It's
easy to compare two collections for equality with an external iterator,
for example, but it's practically impossible with internal iterators.
But on the other hand, internal iterators are `easier` to use, because
they define the iteration logic for you.

In Ruby, `iterator methods` like `each` are `internal iterators`; they
control the iteration and `push` values to the block of code associated
with the method invocation. Enumerators have an `each` method for
internal iteration, but they also work as `external iterators`; client
code can sequentially `pull` values from an enumerator with `next`.

5.4. Blocks
----------------------------------------

Blocks may not stand alone; they are only legal following a method invocation.

Blocks are delimited with `{ }` or with `do` and `end`

Block parameters are separated with commas and delimited `| |` .

You should not use `return` keyword to return from a block, use `next` instead.

Blocks define a new variable scope.

Caution: local variables in a method are available to any blocks assocaited with
that method.


5.5. Altering Control Flow
----------------------------------------

`return` is remarkably consistent: always causes the `enclosing method` to return

`next` is similar to `continue` in C, which transfer control to the **end** of
a loop or block.

`redo` restart **current** iteration of a loop or iterator, by transfering
control back to the top of the loop or block. However, it **does not reset**
the loop condition nor loop var.

`retry` is normally used in a `rescue` clause to **reexecute** a block of code
that raised an exception. It re-evaluate the whole iterator expression, not just
restart current iteration.

`throw` and `catch` are used for multi-level-break, not for exceptions. They are
not commonly used in practice.

5.6. Exceptions and Exception Handling
----------------------------------------

`raise` and `rescue` are used to raise and handle exceptions.

Exception objects are instances of the `Exception` class or subclasseses. Most
of these subclasses extend a class known as `StandardError`.

`Exception` class provide 2 methods returning more details:

    -   `message` :  return a human-readable detail for diagnosing
    -   `backtrace` :  return a array of strings representing the call stack.

Most commonly, a `rescue` clause is attached to a `begin` statement.

Example code::
    rescue ArgumentError, TypeError => error

`ensure` is like `finally` in many other languages.

`rescue` can also be used as a statement modifier, like `if`.

5.7. BEGIN and END
----------------------------------------

`BEGIN` and `END` are reserved words in Ruby, which declare code to be executed
at the **very beginning** and **very end** of a Ruby program.

They are not commonly used in Ruby. They are inherited from Perl, which in turn
inherited from the awk.

5.8. Threads, Fibers, and Continuations
----------------------------------------

5.8.1. Threads for Concurrency
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ruby's use of blocks makes it very easy to create new threads. Simply call
`Thread.new` and associate a block with it.

Example code::

    def readfiles(filenames)
        threads = filenames.map do |f|
            Thread.new { File.read(f) }
        end

        threads.map {|t| t.value }
    end

5.8.2. Fibers for Coroutines
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The name "fiber" has been used elsewhere for a kind of lightweight thread, but
Ruby's fibers are better described as `coroutines` or, more accurately,
`semi-coroutines`.

The most common use for coroutines is to implement `generators`.

In Ruby, the `Fiber` class is used to enable the automatic conversion from
`internal iterators`, such as the `each` method, into enumerators or
`external iterators`.

5.8.3. Continuations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Because they are no longer well supported, continuations should be considered
as a curiosity, and new Ruby code should not use them.

Chapter 6. Methods, Procs, Lambdas, and Closures
=================================================

global functions are actually implicitly defined as `private methods`
of `Object` class.

`Method` class is used to represent `method`, while `Proc` class is used to
represent `block`.

6.1. Defining Simple Methods
------------------------------

`return` is used to force returning prior to the end of the method.

`def` statement may include exception-handling code in the form of `rescue`,
`else`, and `ensure` clauses, just as a `begin` statement can.


Within a method, `self` refers to the object on which the method was invoked.

If we don't specify an object when invoking a method, then the method is
`implicitly` invoked on self.

6.1.4. Defining Singleton Methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-   `instance method`:

    defined within class, usable to **all** its instances

-   `singleton method`:

    defined on specific object, usable to that object **only**

-   `class methods`

    actually are singleton methods, such as `Math.sin` and `File.delete`

6.1.5. Undefining Methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Methods are undefined with `undef` statement.

`undef` can be use to undefine inherited methods in subclasses.


6.2. Method Names
--------------------

By convention, method names begin with a lowercase letter, and use `_` to
separate words rathan using camelCase.

Ruby provides 3 conventional naming prefix:

-   `=`
    commonly used for `setter method`, which can be invoke through assignment
    syntax.

-   `?`
    commonly used for `predicator method`, which is expected to return `Boolean`
    value

-   `!`
    commonly used for `mutator method`, which typically change the internal state
    of object and should be used with caution.

6.2.2. Method Aliases
~~~~~~~~~~~~~~~~~~~~~~~~~~

`alias` can be used to define a new name for an existing method, such as::

   alias new-name existing-name

Method aliasing is one of the things that makes Ruby an expressive and natural
language.

Aliasing Is **Not** Overloading, and Ruby does **NOT** support overloading.

6.3. Methods and Parentheses
-----------------------------

Ruby allows parentheses to be omitted from most method invocations.  In
complex cases, however, it causes syntactic ambiguities and should be avoided.

6.4. Method Arguments
-----------------------------

6.4.1. Parameter Defaults
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Argument defaults need not be constants: they may be **arbitrary** expressions.

This implies defaults are evaluated **on-the-fly** when the method is invoked,
rather than when the method is defined.

This is quite **different** from other language, e.g, Python.

6.4.2. Variable-Length Argument Lists and Arrays
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-   In method definition, prefix `*` is used to `collect` multiple arguements
    into a array.

-   In method invocation, prefix `*` is used to `scatter` one array into
    multiple arguments.

6.4.4. Hashes for Named Arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ruby does not support the `argname=argvalue` syntax in method invocation, but
that can be **approximated** if you write a method that expects a hash as its
argument.


6.4.5. Block Arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

One of the features of blocks is their **anonymity**. They are not passed to
method in a traditional sense: **no name**, and they are invoked through `yield`
instead of method invocation.

If you prefer more explicit control, add a final argument to method definition,
and prefix that name with an `&`. Then, when this method is invokded, that final
arguemnt will **refer to the block** associated with the method.

The value of the argument will be a `Proc` object, and invoking the block is
through `Proc.call` , rather than the normal `yield`.

Like prefix `*`, prefix `&` can be used in **both** method definition and method
invocation.


6.5. Procs and Lambdas
-----------------------------

Blocks are `syntactic` structures in Ruby; they are **NOT** objects.

It is possible, however, to create an object that **represents** a block.

Depending on how such object is created, it is called a `proc` or a `lambda`.

procs have `block-like` behavior and lambdas have `method-like` behavior.

Both, however, are instances of `class Proc`.

6.5.1. Creating Procs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`Proc` objects have a `call` method, which will run the code contained in the
block based upon which this `Proc` object is created.

when `Proc.new` is invoked with an associated block, it will return a `proc`
which represent that block.

global function `proc` is an alias for `Proc.new`.

Method `lambda` return a `lambda`, not a `proc`.

`lambda literal` is another way to create `lambda`.

Invoking `call` on Proc objects would execute the code in the original block;

    -   the arguments passed to `call` would become arguments to the block,
    -   the return value of the block would become the return value of `call`.

Merely having the same source code is not enough to make two procs or lambdas
equal to each other. The `==` method returns true only if one `Proc` is a clone
or duplicate of the other.

6.5.5. How Lambdas Differ from Procs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You can check whether a Proc object is a proc or a lambda with the instance
method `lambda?`.

A `return` statement in a `proc`, like in a block , does not just return **to**
its invoker, it returns **from** the enclosing invoker.

A `return` statement in a `lambda`, however, returns from the lambda **itself**.

Invoking a `proc` uses `yield semantics` (parallel assigement) , while invoking
a lambda uses `invocation semantics`.

6.6. Closures
-----------------------------
`procs` and `lambdas` are all closures.

Method `Proc.binding` return a `Binding` object which represent the binding
for that Proc object.

6.7. Method Objects
-----------------------------

Ruby's methods and blocks are `executable` language constructs, but they are
**not** objects.

`Method` objects can be used to represent method, just as `Proc` objects can be
used to represent blocks.

`Method` class is **not** a subclass of `Proc`, but it behaves much like it.

`Method` objects behave like `lambdas`, not `procs`

6.8. Functional Programming
-----------------------------


Chapter 7. Classes and Modules
==============================

Class can inherit methods not only from `Class`, but also from `Module`.

A pair of `getter` and `setter` accessor methods are known as `attribute`.

Objects are strictly encapsulated, while Classes are very open.

7.1. Defining a Simple Class
------------------------------

Depending on the context, `self` may refer to different entity:

    -   within instance methods, it refers to the **instance** being invoked on.

    -   in other parts of class, it refers to the **class** being defined.

instance variables are **ALWAYS** resolved in the context of `self`,
**implicitly**.

`assigement expression` will invoke setter method **ONLY** when invoked through
an object.

Ruby provides `attr_reader` and `attr_accessor` to simplify the process of
defining simple getter and setter methods, which maps directly to a instance
variable with the same name.

`Class` is a subclass of `Module`.

A **non-mutating** version of a `mutator` is often written simply by creating
a copy of self and invoking the mutator on the copied object.

`Struct` is a core Ruby class that generates other classes. These generated
classes will have accessor methods for the named fields you have specifyd.

`class method` is invoked through that class itself, not through its instances.

Since all classes in Ruby are also instances of `class Class`, defining `class
method` is really just defining `singleton method` of classes. Example code::

    class Point
        # Define accessor methods for our instance variables
        attr_reader :x, :y
        def Point.sum(*points)
        # def self.sum(*points)  # less clear, but Do Not Repeat Yourself!
            x = y = 0
            points.each {|p| x += p.x; y += p.y }
            Point.new(x,y)
        end
        # ...the rest of class omitted here...
    end

class variables are `shared` and `visible` to all class methods, instance methods
and the whole body of class definition, and can be accessed in the same form.

class variables are fundamentally **diffrent** than instance variables:

    -   instance variables are always resolved in reference to `self`
    -   class variables are always resolved in refence to enclosing class.

7.1.16. Class Instance Variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since classes are also instances, so they also can have instance variables.

An instance variables defined outside of instance methods are called as
`class instance variable`.

Though quite similar, `class instance variable` are not the same as
`class variable` :

    -   `class instance variable` use `@` as prefix, while `class variable` use
        `@@`

    -   `class instance variable` can't be used inside instance methods, while
        `class varible` can

    -   when it comes to subclassing, `class instance variable` has advantage
        over `class variable`


7.2. Method Visibility: Public, Protected, Private
--------------------------------------------------

Method are public by default. `initialize` are always priate, however.

`Private methods` are **ALWAYS** invoked `implicitly` on self , and may not be
invoked explicitly on an object.  If m is a private method, then you **MUST**
invoke it in `functional style` as m. You cannot write `o.m` or even `self.m` .


`Protected methods` are the **least** commonly defined and also the **most**
difficult to understand. They can be invoked `explicitly` on object.

`public`, `private`, and `protected` are meaningful **ONLY** to methods; instance
and class variables are always strictly encapsulated and `effectively private`,
while `constants`  are `effectively public`.


7.3. Subclassing and Inheritance
--------------------------------------------------

Ruby does **NOT** support `multi-inheritance`, so one class can only have one
`superclass`.

7.3.1. Inheriting Methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

subclasses also inherits `initialize` method of superclass, which is quite
different from those in C++/Java.

7.3.2. Overriding Methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Overriding private methods should always be done with great **caution**.

Private methods are often used as `helper methods`, and they are not part of
public API but are implementation details.

If you happen to define a method (whatever its visibility) in subclass that
has the same name as a private method in the superclass, you will **inadvertently**
overridden the superclass's internal utility method, and this will almost
certainly cause unintended behavior.

you should subclass **ONLY** when you are familiar with the implementation of the
superclass. If you only need to depend on the public API of a class and not
implementation detail, then you should extend the functionality of the class
by **delegating** to it, not by inheriting from it.

7.3.3 Augmenting Behavior by Chaining
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`super` can be used to to call `overridden` method from `overriding` method.

7.3.4. Inheritance of Class Methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When it comes to inheriting and overridding, class methods and instance methods
works the **SAME** way.

7.3.5. Inheritance and Instance Variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

instance variables are **NOT** created by class defintion in `compiling time`,
but created by instance method at `runtime`.

Therefore, instance variables have **NOTHING** to do with subclassing and
inheritane mechanism.

The reason why they sometimes **APPEAR** to be inherited is that those instance
methods which would create them are often inherited or chained.

Again, since `class instance variable` are also `instance variable`, they are
**NOT** inherited, either.

7.3.6. Inheritance and Class Variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Class variables are **shared** by a class and all of its subclasses. But this is
**NOT** inheritance.

If class A use `class variables`, then any subclass of class A can alter the
behavior of the class A and all descendants of class A, by changing the value
of the shared class variable.

This is a **strong argument** for **prefering** `class instance variables` over
`class variables`.

7.3.7. Inheritance of Constants
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Constants are inherited and can be overridden.

However, constants are looked up in the **lexical scope** of the place they
are used, before they are looked up in the inheritance hierarchy.

7.4. Object Creation and Initialization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

method `new`  has 2 jobs: allocate space for new object and initialize that
new jobs. It delegate these jobs to method `allocate` and method `initialize`
, respectively.

You can never override method `allocalte`, because Ruby always invoke the
defatult one.

method `intialize` is an `instance method` (implictly private).

`clone` and `dup` perform **shallow copy** by default. If you really need
**deep copy** then you should define `initialize_copy` to perform necessary
actions.

7.4.5. The Singleton Pattern
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Singleton** pattern is an useful **alternative** to `class methods` and
`class variables`.

`Singleton` module in the standard library make it very easy to implement
Singleton pattern.

7.5. Modules
----------------------------------------

Modules are used as `namespaces` and as `mixins`.

7.5.1. Modules as Namespaces
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

7.5.1. Modules as Namespaces
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Modules provide a good way to **group** related methods to reduce name-collision
when OOP is not necessary.

These methods should be defined as `class methods` in module.

modules, including classed, can be **nested**, which will create nested namespace.

7.5.2. Modules As Mixins
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Modules are **MORE** powerful when used as mixins.

use `include` to mix other modules into current module/class, which will
**copy** all instance methods of specified modules into current module/class.

`class` can **NOT** be mixed.

`include` will affects method `is_a?` and `===`.

`extend` works similarly, but it make the instance methods of specified modules/
classes into `single methods` of the receiver object.

7.5.3. Includable Namespace Modules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The trick is first define methods as `instance methods`, then use `method_function`
to create `class method` copyies.

when defining `instance methods` of module, you should avoid using `self`,
because what `self` refers will depend on how it is invoked.

7.6. Loading and Requiring Modules
----------------------------------------

`require` is used more commonly than `load`, and they have some important
differences:

    -   `require` also works with binaray extension, while `load` not

    -   `require` expect library name without extension, while `load` expect
        filename

    -   `require` try to avoid repeated loading, while `load` always load
        specified file.

`autoload` allow lazy loading on as-needed basis.

7.7. Singleton Methods and the Eigenclass
--------------------------------------------

The singleton methods of an object are implemented as instance methods of the
anonymous `eigenclass` associated with that object.

7.8. Method Lookup
--------------------------------------------

name resolution for obj.m works as follow step:

    1)  check `singleton method` of obj
    2)  check `instance method` of the class of obj
    3)  check `insantce method` of modules included by the class of obj
    4)  move up in the inheritance hierarchy, and repeat step 2 and 3.
    5)  invode a special method named as `method_missing`.

7.9. Constant Lookup
--------------------------------------------

constants are resolved **MUCH** differently than methods.

    1)  first tries to resolve it in the **lexical scope** of the reference
    2)  then tries to resolve it in the inheritance hierarchy .
    3)  then check top-level/global constants.
    4)  invoke a special method named as `const_missing`







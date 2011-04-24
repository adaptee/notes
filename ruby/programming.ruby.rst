Chp 2. Ruby.new
========================

By convention, multiword instances variables are written in **under_score**,
and multiword class names are written in **MixedCase**.

`%w` is a shortcut for writing array literal of strings, Example code::

    a = [ 'ant', 'bee', 'cat', 'dog', 'elk' ]
    a = %w{ ant bee cat dog elk }

`hash` by default returns `nil` when indexed by a non-existing key.

use `{ }` for single-line blocks, and use `do/end` for multi-lines blocks.

methods and blocks should be thought of as a pair of **coroutines**.

Chp 3. Classes, Objects, and Variables
=======================================

classes are **NEVER** closed for enhancement.

You can think of `:artist` as meaning the **name** of the variable artist, and
plain artist as meaning the **value** of the variable artist.

class methods are **distingushed** from instance methods by the form of how they
are defined.


Access control is checked **dynamically**, as the program runs, not statically.
You will get an access violation **only when** the code attempts to call
the restricted method.

Access to `protected methods` is kept within the family.

Access to `private methods` is kept within per-object. it is **never** possible
to invoke another object's private method, even if caller and callee are in the
same family. This is **different** from C++, where access to `private methoed`
is restricted per-class, not per-object.

A variable is simply a reference to an object. Objects float around in a big
pool somewhere (the heap, most of the time) and are pointed to by variables.


Chp 4. Containers, Blocks, and Iterators
========================================

Iterators and code blocks are among the most attractive features of Ruby.

The `each` iterator has a special place, because it's used as the basis of
the `for` loop.

Ruby provides iterators **internal** to collections, while C++/Java provides
iterators **external** to collections.

Chp 5. Standard Types
========================

Underscores are **ignored** in the digit literal(some folks use them as
delimiter for larger numbers).

Ruby provide 3 shortcuts for string literals: `%q`, `%Q` and `here document`.

Ruby use Range to implement 3 features: `sequences`, `conditions` and `intervals`.

Ruby can create ranges based on objects that you provide. The only requiments
are the objects must respond to `succ` by returning the next object in sequence
and the objects must be comparable using `<=>`.

Range can also act as a kind of **toggle switch**.

A final use of the Range is as an interval test by `===` : seeing if some value
falls within the interval represented by the range.

`=~` is used to match regex against, which have the **side effects** of setting
a group of global values.

Chp 6. More about Methods
==============================

If `receiver` is ommit in invoking a method, it **defaults** to `self`.

Chp 7. Expressions
==============================

A pair of **backticks** can be use to execute command provide by OS.

`%x{...}` has the same utility.

The exit code of the command is stored in the global value `$?`.

`parallel assignments` are effectively performed in **parallel**, so the values
assigned are not affected by the assignment itself. The values on the right side
are evaluated, in the order in which they appear, **before** any assignment is
made to variables or attributes on the left.

Extra rvalues are **discarded**, missing rvalues are taken as `nil`.

`for` is actually just syntactic sugar.

`retry` can e used to wind the **whole** loop right back to the **very**
beginning.

`while`, `until`, `for` do **NOT** introduce new scope.

A good convention is to use **different** naming schemes for `local variables`
and `block parameters`.

Chp 8.Exceptions, Catch, and Throw
========================================

Within `rescue` clause,  `retry` can be used to re-execute the begin/end block.
This is a feature to be used with **caution**, because it may cause **infinite**
loop.

`throw` and `catch` is not related with exception, but is used for jumping out
deeply nested construct. You can think of them as 'goto improved'.

Chp 9. Modules
========================================

With mudules used as mixins, the need for multiple inheritane is pretty much
**eliminated**.

`instance methods` of modules will suddenly be accessible as instance methods
of classes once they **include or mix** the modules. In other words, modules
behaves effectively as `superclasses`.

`include` has **NOTHING** to do with loading files, which is the job of `load`
or `require`.

`include` do **NOT** copy instance methods of module, but just create a
**reference** from the class to the module. If multiple classes include the
same module, then they all refer the same thing.

The true power of mixins comes out when the code in the mixin starts to
**interact** with code in the class that uses it. For example, as a class
writer, you define one method, `<=>`, include `Comparable`, then get six
comparison functions for free.

A good practice is modules should **NOT** create their own instance variables;
they should use accessors to retrieve data from the client object. This is to
avoid `name collision` by accident.

If a class have multiple modules mixed in, the **last** one included takes
**higher* priority** over the first one included in the process of name
resolving.

Since `load` will loads the source unconditionally, you can use it to **reload**
a source file that may have changed since the program began.

Chp 11. Threads and Processes
==============================

Ruby threads are totally in-process, implemented within the Ruby interpreter.
That makes the Ruby threads completely portable and indepednet upon OS.

However, that portability comes with a few penalty:

    -   if **deadloack** among thread happens, the whole process hangs

    -   if some thread make a **system call** which takes a long time to
        complete, all threads will hang until that moment.

    -   Ruby thread can't take advantage of **multi-processor**, because they
        run in a single native thread which is constrained to use one processor.

Chp 13. When Trouble Strikes
==============================

Ruby comes with a debugger. Example::

    ruby -r debug <ruby-script> <arguments>

It's a good practive to run ruby scripts with **warnings** enbaled (-w option)

Chp 15. Interactive Ruby Shell
==============================

You can use `irb` to  run a script and watch the blow-by-blow description
as it runs,

Within `.irbrc`, you can write any valid Ruby code.

You can effectively extend irb by writing new `top-level` methods.

Chp 23. Duck Typing
==============================

The lack of static typing is not a problem when it comes to writing
**reliable** applications.

static type systems in most mainstream languages do **NOT** really help that
**much** in terms of program **security**.

Static typing can help **compiler** for **optimizing** code, and it can help
**IDEs** do clever things, but we have **NOT** seen much evidence that it
promotes more **reliable** code.

safety in `type safety` is often illusory and turns out to be a false promise.

the type of an object is defined more by **what** that object can do, rather
than only by its class.

Even if you need to perform safety check on some object, do the check based upon
its capabilities, rather than its class.











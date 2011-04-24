=================
Pro Python
=================
---------------------------------------
Advanced coding techniques and tools
---------------------------------------

Chp 1. Principles and Philosophy
=====================================

* **Beautiful Is Better Than Ugly**

    One obvious application of this philosophy is in Python's own language
    structure, which minimizes the use of **punctuation**, instead preferring
    English **words** where appropriate.

* **Explicit Is Better Than Implicit**

    In general, Python asks you to declare your intentions explicitly.

    On the contrast, regular expressions in the Perl automatically assign
    values to special variables any time a match is found.

* **Simple Is Better Than Complex**

    This guideline is mainly targeted at interface of libraries. The goal is
    to keep the interface as **straightforward** as possible.

* **Complex Is Better Than Complicated**

* **Flat Is Better Than Nested**

    The goal is to keep things as relationships of **peers** as much possible,
    rather than parents and children.

* **Sparse Is Better Than Dense**

    This principle largely pertains to the visual appearance of Python code,
    favoring the use of **whitespace** to differentiate among blocks of code.

    However, you should also try **avoiding extra spaces** .

* **Readability Counts**

    A focus on readability requires you to always look at your code as a
    human being would, rather than only as a computer would.

* **Special Cases Aren't Special Enough to Break the Rules**

* **Although Practicality Beats Purity**

    Typically, it's preferable to maintain greater **overall consistency** at
    the expense of a few small areas that may be less than ideal.

* **Errors Should Never Pass Silently**

    Exceptions are typically considered less disruptive than errors and thus
    more acceptable, but they both amount to the same thing: a violation of
    some kind of expectation.

* **Unless Explicitly Silenced**

* **In the Face of Ambiguity, Refuse the Temptation to Guess**

* **There Should Be One, and Preferably Only One Obvious Way to Do It**

    This one is generally applied **only** to development of libraries.

    Every interface adds a burden on developers who have to use it.

* **Although That Way May Not Be Obvious at First Unless You are Dutch**

* **Now Is Better Than Never**

* **Although Never Is Often Better Than Right Now**

    It's valuable to get started quickly, but it can be very dangerous
    to try to finish immediately.

* **If the Implementation is Hard to Explain, It's a Bad Idea**

* **If the Implementation is Easy to Explain, It May Be a Good Idea**

* **Namespaces Are One Honking Great Idea!  Let's Do More of Those**


Chp 2. Advanced Basics
=====================================


2.1 General Concepts
--------------------------------

* **Iterations**

    Most code that uses sequences can be placed in one of two categories:
    those that actually use the sequence as a whole and those that just need
    the items within it.

    Most functions use both approaches in various ways, but the **distinction**
    is important for us to understand what tools Python makes available
    and how they should be used.

2.2 Control Flow
--------------------------------

* **Exception Chains**

    What if another exception is raised when executing the except block?

    Even though this new exception is important, there was already an exception
    in play that shouldn't be forgotten. To retain the original information,
    each exception object has one attribute called __context__, which holds
    the original exception object.

    This attribute builds an implicit chain of exceptions. Python allow you to
    build this chain explictyly by using the **from** keyword at the end of
    the **raise** statement::

        >>> def validate(value, validator):
        ... try:
        ...     return validator(value)
        ... except Exception as e:
        ...     raise ValueError('Invalid value: %s' % value) from e

* **Proceeding Regardless of Exceptions**

    Python allows the use of a **finally** block, which gets executed
    every time the associated **try**, **except** and **else** blocks finish.


2.3 Iteration
--------------------------------

    There are generally two ways of looking at sequences:

        - as a collection of items
        - as a way to access a single item at a time.

    These two aren't mutually exclusive, but it's useful to separate them
    in order to understand the different features available in each case.

    Working on the collection as a whole requires that all the items be in
    memory at once, but accessing them one at a time can often be done much
    more efficiently.

* **Generator Expressions**

    This is very similar to list comprehension, except using **( )** instead
    of **[ ]**


    Once the iteration is complete and there are no more values left to
    iterate, the generator **does not restart**.

    Instead, it simply returns an **empty list** each time called thereafter.


* **Set Comprehensions**

    This is very similar to list comprehension, except using **{ }** instead
    of **[ ]**

    Example::

        >>> {str(value) for value in range(10) if value > 5}
        {'6', '7', '8', '9'}

* **Dictionary Comprehensions**

    **:** is what distinguish dict comprehensions from set comprehensions.

    Example::

        >>> {value: str(value) for value in range(10) if value > 5}
        {8: '8', 9: '9', 6: '6', 7: '7'}


* **Chaining Iterables Together**

    **itertools.chain()** accept any number of iterables and returns a new
    generator which will iterate over each iterables in turn.

* **Zipping Iterables Together**

    **zip()** is used to combine multiple iterables together, side by side.

    It is particularly useful in creating dictionaries, because one sequence
    can be used to supply the keys, while another supplies the values.

    Example::

        >>> keys = map(chr, range(97, 102))
        >>> values = range(1, 6)
        >>> dict(zip(keys, values))
        {'a': 1, 'c': 3, 'b': 2, 'e': 5, 'd': 4}

2.4 Collections
--------------------------------

* **Sets**

    Sets are concerned solely with **memebership**.

    The representation of an empty set is **set()**, rather than {}, because
    Python needs to maintain a distinction between sets and dictionaries.

    The union of two sets is a lot like a bit-wise OR operation, so Python
    represents it with the **pipe** (|).

    Similarly, Pytho use **ampersand** (&) to represent intersection of sets,
    and **minus** (-) to represent difference of sets, and **caret** (^) to
    represent symmetric difference of sets.

    Example::

        >>> example = {1,2,3}
        >>> example.add(4)
        >>> example.remove(4)
        >>> example.discard(3)
        >>> example.pop()
        >>> example.update({5,6,7})
        >>> example.clear()

        >>> {1, 2, 3} | {4, 5, 6}
        {1, 2, 3, 4, 5, 6}
        >>> {1, 2, 3}.union({4, 5, 6})
        {1, 2, 3, 4, 5, 6}

        >>> {1, 2, 3, 4, 5} & {4, 5, 6, 7, 8}
        {4, 5}
        >>> {1, 2, 3, 4, 5}.intersection({4, 5, 6, 7, 8})
        {4, 5}

        >>> {1, 2, 3, 4, 5} - {2, 4, 6}
        {1, 3, 5}
        >>> {1, 2, 3, 4, 5}.difference({2, 4, 6})
        {1, 3, 5}

        >>> {1, 2, 3, 4, 5} ^ {4, 5, 6}
        {1, 2, 3, 6}
        >>> {1, 2, 3, 4, 5}.symmetric_difference({4, 5, 6})
        {1, 2, 3, 6}

* **Named Tuples**

    Named tuple is an trade-off between tuples and dictionaries.

    It can be created by calling **collections.namedtuple**. It creates
    a new class, customized for a given set of names.

* **Ordered Dictionaries**

    **collections.OrderedDict** provides dictionaries with reliable sorting
    of keys.

* **Dictionaries with Defaults**

    **collections.defaultdict**  provide dictionaries with default values for
    missing keys.

2.5 Importing Code
--------------------------------

* **Using __all__ to Customize Imports**

    The **ONLY** time __all__ comes into play is in ``"from xxxx import *"``

* **Relative Imports**

    "."  allows you to refer to **current package**, while ".." allow you to
    refer to package higher by one level.

    For example, if the *acme.shopping.cart* module needs to import from
    *acme.billing*, the following import patterns are identical::

        from acme import billing
        from .. import billing

* **The __import__() function**

    Python allow you to import module **dynamically**, using __import__() .

    However, this function is not easy to understand and use.

* **The importlib module**

    This module provide more **intuitive interface** for importing modules,
    such as **import_module()**


Chp 3. Functions
=====================================

3.1 Arguments
--------------------------------

    When working with variable arguments, there's one difference between
    positional and keyword arguments, which may cause problems.

    Positional arguments are grouped into a tuple, which is **immutable**,
    while keyword arguments are grouped into a dictionary, which is **mutable**.

* **Preloading Arguments**

    This concept is officially called **partial application**.

    The difference between **partial application** and **currying** is
    **subtle**, but **important**.

    With a truly curried function, you must call it as many times as necessary
    to fill up all of the arguments. If a function accepts three arguments and
    you call it with just one argument, you would get back a function that
    accepts two more arguments. If you call that new function, it still won't
    execute your code, but return another function that one argument. Calling
    that function will finally satisfy all the arguments, so the actual code
    will be executed and return a useful value.

    Python provides **functools.partial()** to create
    partially applied functions.

* **Introspection**

    **inspect.getfullargspec()** can be used to obtain info of one function's
    formal arguments.

3.2 Decorators
--------------------------------

* **Closures**

* **Wrappers**

    In the context of closure , a **wrapper** is the **inner** function
    returned by outer function, while the **wrapped function** is passed in
    as an argument to the **outer** function.

    Unfortunately, wrapping a function means some useful information is lost.
    Those info include its name, docstring and argument list.

    we can use a decorator called **functools.wraps()** to bring
    those info back. It copies name, docstring and other info from wrapped to
    wrapper.

* **Decorators with Arguments**

    What does python do when it encounter the form of "**@xxxx**" ?

    it will first evaluate "**xxxx**", then use its result as the decorator.

* **Decorators with or without Arguments**

    Ideally, a decorator with optional arguments would be able to be used
    without parentheses if no arguments are provided, while still being able
    to provide the arguments when necessary.

    This means supporting **two different flows** in a single decorator, which
    can get tricky if you are not careful.

    The main problem is that the outermost function must be able to accept
    arbitrary arguments or a single function, and it must be able to tell the
    difference between the two and behave accordingly.


    Example::

        def suppress_errors(func=None, log_func=None):
            """Automatically silence any errors that occur within a function"""

            def decorator(func):

                @functools.wraps(func)
                def wrapper(*args, **kwargs):
                    try:
                        return func(*args, **kwargs)
                    except Exception as e:
                        if log_func is not None:
                            log_func(str(e))

                return wrapper

        if func is None:
            # get called when evaluating @suppress_errors(log_func=xxx)
            # so just return the decorator for later usage.
            return decorator
        else:
            # get called to decorate another function
            return decorator(func)


* **A Decorator to Create Decorators**


3.3 Function Annotations
--------------------------------

    Each **argument**, as well as the **return value**, can have an expression
    attached to it, which describes a detail that can't be conveyed otherwise.

    Annotation can by **ANY** expression, not just type or class.

    Example::

        def prepend_rows(rows:list, prefix:str) -> list:
            return [prefix + row for row in rows]


    Massive contents are **SKIPPED**!


3.4 Generators
--------------------------------

    Generators are set aside from other functions by their use of the
    **yield** statement.

3.5 Lambdas
--------------------------------

    Only a **SINGLE** expression is allowed in lambda .


3.6 Introspection
--------------------------------

    All functions and classes have a **__module__** attribute, which contains
    the name of the module in which it is defined.

    **inspect.getdoc()** can be used to retrieve and format docstring.

Chp 4. Classes
=====================================

4.1 Inheritance
--------------------------------

* **Multiple Inheritance**

    **Mixin** classes don't provide full functionality on their own; they
    instead supply just a small add-on feature that could be useful on a wide
    range of different classes.

* **Method Resolution Order (MRO)**

    When looking up attribute, the first namespace Python looks at is always
    the instance object. If the attribute isn't found there, it goes to the
    actual class of that instances.

    These two namespaces are always the first two to be checked.

* **C3 Algorithm**

    Detail **SKIPPED**

* **Using super() to Pass Control to Other Classes**

    super() is all too often **misunderstood**.

    super() take two argument: a class and a instance, and return a **object**.

    The MRO used by that **object** is a subset of the MRO used by the given
    **instance**, i.e, those entries coming after the given **class**.

    One **common mistake** of using super() is to use it on a method that won't
    always have the same signature across all the various classes.

* **Introspection**

    isinstance(obj, cls) == issubclass(type(obj), cls)

    **__bases__** vs **__subclasses__()**


4.2 How Class Are Created
--------------------------------

    The process of creating class has more **in common with** creating function
    than you may realize.

    classes are **created at runtime**, not at compiling time.

    type() need 3 pieces of info to create a class:

        - name of the new class
        - base classes of the new classes
        - namespace dictionary populated when executing the class body

* **Metaclasses**

    By subclassing **type**, you can create your own metaclass.

    Python allow specify the metaclass in class declaration, e.g::

        >>> class Example(metaclass=SimpleMetaclass):
        ...     pass

* **Example: Plugin Framework**

    Every plugin system has 3 core features in common:

        - defines where plugins can be pluged.
        - defines what a plugin should implement.
        - provides a easy way to access all plugins

    Since plugins are really a form of extension, it makes sense to have them
    extend a base class.

* **Controlling the Namespace**

    By supplying __prepare__() method on your metaclass, you can get early
    access to the class declaration.

    In fact, this **happens so early** that the body of the class definition
    hasn't even been processed/executed yet.

    The __prepare__() method receives just class name and a tuple of base
    classes.  Rather than **getting** the namespace dictionary as an argument,
    __prepare__() is responsible for **returning** that dictionary itself.


4.3 Attributes
--------------------------------

    The syntax for accessing attributes doesn't offer the same flexibility as
    dictionary keys in providing variables instead of literals.

     *setattr()*

     *getattr()*

     *delattr()*


* **Properties**

    Example::

        class Person:
            def __init__(self, first_name, last_name):
                self.first_name = first_name
                self.last_name = last_name

            @property
            def name(self):
                return '%s, %s' % (self.first_name, self.last_name)

            @name.setter
            def name(self, value):
                self.first_name, self.last_name = value.split(',')

            @name.deleter
            def name(self):
                del self.first_name
                del self.last_name

* **Descriptors**

    Properties are **implemented as descriptors** behind the scenes, as are
    class methods.

    This makes descriptors one of the most **fundamental aspects** of
    advanced class behavior.

    unlike __get__(), __set__() is called **only** when the attributes is
    accessed **through instance**, but not class.

    Assignment through the form of "class.attribute = xxxx" will always
    overwrite existing descriptor. This is **intentional**, because otherwise
    there would be no way to remove a descriptor attribute from class.

4.4 Methods
--------------------------------

    All functions are **non-data** descriptors.

    There are actually only functions; methods are just **wrapper functions**.

* **Unbound Methods**

    unbound method is just the function itself.

* **Bound Methods**

    bounded method is another function as wrapper of the original function.

    You can get the origal function through **__func__** attribute of method.

* **Class Methods**

    The first argument 'cls' will always refers to whatever class was used to
    call that method, rather than just the one in which the method was defined.

    Class methods can also be created in another, slightly more indirect way.
    Because all classes are really just instances of metaclasses, you can
    define a method on a metaclass. All classes created by that metaclass then
    have access to that method as a standard bound method.

* **Static Methods**

    statci methods are really normal function, only happen to sit in a class.

* **Assigning Functions to Classes and Instances, dynamically**

    An function assigned to class dynamiclly works the same as other methods.

    An function assigned to instance dynamiclly works like a static method.

4.5 Magic Methods
--------------------------------

* **Creating Instance**

    -   *__new__()* is for creating.
    -   *__init__()* is for initializing,

* **Dealing with Attributes**

    -   *__getattr__()*: called **only** when reading **non-existing** attributes.
    -   *__setattr__()*: called **any** time you assign value to a attribute.
    -   *__delattr__()*: called **any** time you delete attribute.

    -   *__getattribute__()*: called **any** time you read any attribute.

* **String Representations**

    -   *__str__()*  : for str() and print()
    -   *__repr__()* : for repr() and interactive interpreter


Chp 5. Common Protocols
=====================================

    This chapter is a reference for those methods that
    **aren't so obvious** because they'e masked by syntactic sugar.

5.1 Basic Operations
--------------------------------
    *__bool__()* :  for bool()

    Division come in two flavors: **true** division and **floor** division.

    divmod() : get the result of floor division and remainder at the same time.

    Big table is **SKIPPED**

5.2 Numbers
--------------------------------

    Python requires index be integers. **__index__()** is provided to
    **coerce** an object into integer.

    "**is**" and "**is not**" are generally used for comparison with known
    constants, such as *True*, *False*, and *None*.

    If you implement __eq__(), always remember to also implement __ne__(),
    because these two methods are not connected as reversion .

    *__cmp__()* is *deprecated* and removed in Python 3.0

    *__int__()*     : for int()

    *__float__()*   : for float()

    *__complex__()* : for complex()


    *__floor__()*   : for math.floor()

    *__ceil__()*    : for math.ceil()

    *__round__()*   : for round()


    *__neg__()*     : for operator '-'

    *__pos__()*     : for operator '+'

    *__abs__(*)     : for abs()


    *__eq__()*      : for operator '=='

    *__ne__()*      : for operator '!='


5.3 Iterables
--------------------------------

    An object is *iterable* is passing it into *iter()* returns an iterator.

    Iterator should always be iterable on their own as well, so they must
    implements *__iter__()*, typically just returning itself.

    Iterator should also implements *__next__(),* which return another item
    each time called.

    By raising **StopIteration** from __next__(), iterator inform  others that
    there are no more items.

    if __iter__() is not defined but *__getitem__()* is defined, Python will
    create a special iterator designed to work with *__getitem__()*. This
    iterator will call __getitem__() again and again, until __getitem__()
    raise **IndexError**.

5.4 Sequences
--------------------------------

    *__len__()*  : for len()


    *reversed()* : take a sequence and return a iterator iterating reversely.

    *__reversed__()* : for reversed()


    *__getitem__()* : for *sequence[index]* syntax

    *__setitem__()* : for *sequence[index] =* syntax

    *__delitem__()* : for *del sequence[index]* syntax


    When *slicing* syntax is used, __getitem__() will receive a *slice*  object,
    instead of the normal integer.

    *slice* object has 3 dedicated attribute: *start*, *stop*, and *step*. It
    is **unhashable**, so can't be used as the key of dictionary.

5.5 Mappings
--------------------------------

    Python use the **same** set of methods to support the *dict[key]* syntax.

5.6 Callable
--------------------------------

   *__call__(),*   the key to be callable !


5.7 Context Manager
--------------------------------

    If the *with* statement includes an *as* clause, the return value of
    *__enter__()* will be **binded** to the name in that clause.

    *__exit__()* will always be called, even if exeption is raised.

    if *__exit__()*  complete without returning a value, the original
    exception( if any) will be **re-raised** automatically.


Chp 6. Object Management
=====================================

    Python consider an object as the combination of 3 things:

    * **identity**
        - **unchangable** and **unique**
        - use by operator *is* to perform strict comparison.

    * **type**
        - **unchangable** and **shared** among brothers

    * **value**
        - **changable**
        - the value is actually provided by a namespace dictionary.

6.1 Namespace
--------------------------------

* **Borg Pattern**

    This pattern means ensuring all instances of one class always has the same
    value.

    Essentially, this is done by storing a dictionary in the class, and assign
    the dictionary to each instance's *__dict__* attribute when the instance is
    being created/initialized.


* **Self-caching properties**

    Descriptors *do not* known the name they are given.

    Example code(contains memory leak)::

        def cachedproperty(func):
            values = {}

            @property
            @functools.wraps(func)
            def wrapper(self):
                if self not in values:
                    values[self] = func(self)
                return values[self]

            return wrapper

    *Hint*: can we use weak reference to solve the cyclical reference?


6.2 Garbage Collection
--------------------------------

    Effective garbage collection first requires the ability to reliably
    identify an object as garbage.

* **Cyclical References**

    Python's garbage collection comes with code designed to spot
    cyclical references.

    But Things get really tricky if those objects implement __del__(). In this
    context, the only predictable and reliable action Python can take is to
    leave thoses objects in memory, i.e, **memory leak**.

    *gc.collect()* can be used to run garbage collecter **manually**.

    *gc.garbage* is an special list containing all objects that are otherwise
    unreachable but are part of a cycle that includes __del__() somewhere
    along the line.


* **Weak References**

    This allow you to get a reference to another object **without** increasing
    its reference count.

    *weakref.ref()* can be used to create weak reference to whatever object
    passwd in.

    A weak reference is an callable object which take no argument and return
    the original object, or None if the original object has gone.


    one of the most common pitfalls with weak references::

        >>> ref = weakref.ref(Example())
        >>> ref
        <weakref at ...; dead>
        >>> ref()
        >>>


6.3 Pickling
--------------------------------

    Pickle means exporting Python object to bytes, or restore Python objects
    from bytes.

    *pickle.dumps()* : for exporting

    *pickle.loads()* : for restoring

    You can implement __getstate__() and __setstate()__ to control what would
    be exported and what to do when restoring.

    Pitfall:  When unpickling an object, Python would not call __init__(),
    because that object has been initialized before packling.


6.4 Copying
--------------------------------

* **Shallow Copy**

    When you make a shallow copy of an object, what you're really doing is
    creating a new object with the **same type**, but with a **new identity**
    and a **new but equal** value.

    For mutable objects, its value typically contains references to
    other objects; The value of the copied object may have a new namespace,
    but it contains all the same references.

    Beyond the object's own namespace, **only references get copied**, not
    the objects referenced themselves.

    Typically, shallow copies are useful when the first layer is the only part
    of a value you need to change,

    *__copy__()* : for copy.copy()

* **Deep Copy**

    *copy.deepcopy()* copies not only the original structure but also the
    objects that are referenced by it.

    **copy.deepcopy()** is not an truly recursive operation, because full
    recursion would sometimes make for infinite loops if the data structure
    had a reference to itself somewhere.

    Once a particular object is copied, Python makes a note of it, so that
    any future references to that same object can simply be changed to refer
    to the new object, rather than create a brand new one every time.

    This means that any time the same object is found more than once in the
    structure, it'll only be copied once and referenced many times.

    Example code::

        >>> a = [1, 2, 3]
        >>> b = [a, a]
        >>> b
        [[1, 2, 3], [1, 2, 3]]
        >>> b[0].append(4)
        >>> b
        [[1, 2, 3, 4], [1, 2, 3, 4]]
        >>> c = copy.deepcopy(b)
        >>> c
        [[1, 2, 3, 4], [1, 2, 3, 4]]
        >>> c[0].append(5)
        >>> c
        [[1, 2, 3, 4, 5], [1, 2, 3, 4, 5]]


    **__deepcopy__()** : for copy.deepcopy


Chp 7. Strings
=====================================

7.1 Bytes
--------------------------------

    Python considers numbers and characters to be two different things, but
    their underlying values can be equivalent.

    *ord()* : convert character to number
    *chr()* : convert number to character

* **Struct Module**

    *struct.pack()*   : convert objects into bytes
    *struct.unpack()* : convert bytes into object


    Upper-case fommatter assumes an *unsigned* value, while lower-case formatter
    assumes a *signed* value.

    If you place a *<* before the formatter, you explicitly declare it to be
    **little-endian**. Conversely, using *>* will mark it as **big-endian**.

7.2 Text
--------------------------------

    In Python 3.0, *encode()* is available only on *str*, while *decode()*
    is only available on *bytes*.

7.3 Simple Substitution
--------------------------------

    "*%s*" will cause Python to refer to *__str__()*

    "*%r*" will cause Python to refer to *__repr__()*

    The string formatting facility provided by operator % is considered
    **obsolete**, and is superseded by more flexbile and rebost formatting
    facility provided by *format()* method of string.


7.4 Formatting
--------------------------------

    *format()* expects its placeholders to be surrounded by *{ }* .

    You *do not need* to refer all arguments passed to format() in the
    formatter string. This make it much more robust than operator %.



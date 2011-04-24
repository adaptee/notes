(http://www.freedesktop.org/wiki/IntroductionToDBus)

There's a long list of words that have special meanings in the D-Bus world, and
not all of them are completely standardized.

1. Introduction to D-Bus
==============================

D-Bus is meant to be **fast** and **lightweight**.

D-Bus is **non-transactional**.

However, it is **stateful** and **connection-based**, making it "smarter" than
UDP. On the other hand, it does carry messages as **discrete items**--not
continuous streams of data as is the case with TCP. Both **one-to-one**
messaging and **publish/subscribe** communication are supported.


D-Bus has a **structured view** of the data it carrie. Because data is not just
"raw bytes" to D-Bus, messages can be **validated** and ill-formed messages
**rejected**. In technical terms, D-Bus behaves as an **RPC mechanism** and
provides its own marshaling.

2. Language Bindings
====================

Using D-Bus should feel more like object-oriented programming than like
communication.


3. Buses
===============

There are **two major components** to D-Bus:

-   a point-to-point communication **library**, which in theory could be used
by any two processes to exchange messages among themselves

-   a dbus **daemon**. The daemon runs an actual bus, a kind of "street" that
messages are transported over, and to which any number of processes may be
connected at . Those processes connect to the daemon using the library.


3.1 Addresses
--------------------

Every bus has an address describing how to connect to it. A bus address will
typically be the filename of a Unix-domain socket such as "/tmp/.hiddensocket"


3.2 Configuration and Startup
------------------------------

Bus daemons are started using the `dbus-launch` command, which in turn
runs `dbus-daemon`. The standard buses have `/etc/dbus-1/system.conf` and
`/etc/dbus-1/session.conf` as their respective configuration files.


3.3 Connections
--------------------

Every connection to a bus can be addressed on that bus under **one or more
names**. These names are known as **the connection's bus names**. (Note that bus
names are the names of connections on the bus, not names of buses.)

Bus names consist of a series of identifiers separated by dots, e.g.
"org.kde.kwin".

When a connection is set up, the bus immediately **assigns** it an **immutable**
bus name that it will **retain** for as long as the bus exists. This bus name
is called a **unique connection name**, because no other connection will ever
have that same name on the same bus--even if the connection is closed down and
other ones are created. It can be **recognized** by the fact that it starts with
a **colon**, which is otherwise not possible: ":34-907".

A connection may also request additional names, e.g. to **offer services**
under **well-known names** that are agreed upon by convention. These names must
consist of two or more dot-separated elements, such as "org.kde.kwin"

4. Object Model
====================

Many terms such as "object" and "method" have more **specific** meanings in the
context of D-Bus, and may have **nothing** to do with whatever else is going on
in client applications.

4.1 Objects
--------------

One end of any message exchange on a bus will always be a communications
endpoint that in D-Bus terminology is called an object. An object is created by
a client process and exists within the **context** of that client's connection to
the bus.

The bus imposes an **object-centric view** of communications, where any message
carried by the bus is of one of three kinds:

-   **Requests** sent to objects by client processes.
-   **Replies** to requests, going from an object back to a requesting process.
-   One-way messages emanating from objects, **broadcast** to any connected
clients that have registered an interest in them.


Thus at a higher level of abstraction, the bus supports two forms of
communication that we could call "1:1 request-reply" going to an object, and
"1:n publish-subscribe" coming from an object.

Every bus has at least one object, **representing the bus itself**. Clients
can obtain information about the status of the bus by sending requests to this
object.

4.2 Proxies
--------------------

a proxy is a **local representation** inside your own program of an object that is
really accessed through the bus, and typically lives outside your program: you
literally access the object "by proxy."

A proxy exists only **inside the client**, and the details of how it works depend
entirely on the binding you use.

Objects have **names**, also called **paths** because they look like Unix-style,
slash-separated filesystem paths.

An object's name needs to be **unique** only within the **context** of its
connection to the bus.

Since any object "lives within" the context of a connection, it takes a
**combination** of that connection's bus name and the object's own name to find
it.

4.3 Methods
---------------

When a client sends a request to an object, it sees this request as invoking a
method on the object: the object is asked to perform a specific, named action.

The method's definition may require certain information to be passed with the
request as arguments (**input parameters**). For every request, a reply message
carries the result back to the requester, along with either result data (**output
parameters**) or, if the action could not be performed, exception information.

Most D-Bus bindings make all this fit in with their environment's native
mechanisms.

4.4 Signals
--------------------

Called signals, these **one-way** communications come from an object and go
nowhere in particular.

Client processes can **register an interest** in signals of a particular
name coming from a particular object. Whenever an object emits a signal, all
interested clients will receive a copy of the signal.

There are **no replies** to signals.

Signals can carry parameters, just like method invocations. More recent versions
of D-Bus also allow clients to **restrict** their interest to cases where certain of
the signal's parameters match given values


4.5 Interface
---------------

So every object supports particular methods and may emit particular signals.
These are **known collectively** as the object's members.

Any object may implement a given interface, just as in Java any number of
classes may implement the same interface. Conversely, a single object may
implement any number of interfaces.

The combination of all interfaces supported by the object is called the object's
**type**.

When a client invokes a method or listens for a signal, it **must** indicate the
object and the member it is referring to. In addition to object and member, the
client **may also** name the interface in which that member was specified.


5. Addressing
====================

This detailed example is really very  **helpful** !


6. Message Ordering
====================


7. Activation
====================

So far we've assumed that objects are created by active clients. There is
another way of offering services on the bus: the **bus daemon** can be
instructed to **activate** clients automatically **when needed**.

Activation of a client can be triggered in two ways, both keyed by a well-known
bus name that the activated client must obtain:

- Through an explicit request to the object representing the bus itself

- By invoking a method on an object in the context of the client's well-known
bus name





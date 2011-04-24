Part 1. Introduction to Iterators and Generators
------------------------------------------------

The behavirou of a *generator function* is quite *different*
from normal functions.

Calling a *generator function* creates an *generator object*.

However, that *generator function* does not start running
until you call the next() method on that *generator object*.


In some perspective, a generator function is merely a more
*convenient* way of writing an *iterator*; You do not need to
worry about the iterator procotol(__iter__ and __next__() ),
it just works.

Part 2. Processing Data Files
------------------------------------------------

The generator solution was based on the concept of *pipelining*
data between different components.

This sounds familiar to The *Unix philosophy*.

Part 3. Fun with Files and Directories
------------------------------------------------

Generators *decouple* iteration from the code that uses
the results of the iteration.

Part 4. Parsing and Processing Data
------------------------------------------------

Part 5. Processing Infinite Data
------------------------------------------------

Tailing a log file results in an "*infinite*" stream.

It constantly watches the file and yields lines as soon as
new data is written

But you don't know how much data will actually be written
in advance, and log files can often be enormous.


Part 6. Feeding the Pipeline
------------------------------------------------

Part 7. Extending the Pipeline
------------------------------------------------

Can you extend a processing pipeline *across* processes and machines?

Easy. Just *pickle/unpickle* the data on each side.


Can you extend a processing pipeline *across* threads?

Yes, if you connect them with a *Queue* object














Chp 1. Characters as Data
==============================

1.2. What's in a Character?
------------------------------

The **abstract** concept of character is essential in Unicode.

Note that by the term character, we do **NOT** mean a glyph, a name, a phoneme,
nor a bit combination. A character is simply an atomic unit of communication.
It is typically a symbol whose various representations are understood to mean
the same thing by a community of people.

Unicode do **NOT** unify characters **across** writing system boundaries.

We do not define characters individually but as parts of a collection.

Unicode identifies a character by:

    -   assigning a **unique** number, which will **never** change
    -   assigning a **unique** name, which will **never** change
    -   provide description to clarify its meaning
    -   specify a set of properties
    -   showing a representative glyph


Unicode and ISO-10646 are **fully** in accordance,  but Unicode contains a lot
of additional information.

You may wonder why Unicode assigns **two** immutable identifiers for a character:
a number and a name. If each of them is unique and guaranteed to remain
unchanged, what do you need the other one for?

People **tend** to use characters on the basis of their **visual** appearance.
Unicode has strengthened such tendencies. People browse tables or menus of
Unicode characters and pick up the first one that looks right for the purpose
they have in their mind. Since Unicode has so many morecharacters than most
old standards, there are far more opportunities forgetting lost: it is easy to
find a Unicode character that more or less looks like the one you need.

1.4. Glyphs and Fonts
------------------------------------

It is important to **distinguish** the character concept from the glyph concept.

A font is an **organized** set of glyphs. Usually, Glyphs are **identified** by
their code numbers, which typically correspond to code point of the characters
represented by the glyphs. Thus, a font  is character-code dependent.

A font may contain the same glyph for distinct characters. In fact, this applies
for most fonts.

1.6. Numbering Characters
------------------------------

Unicode use the term "**code point**" to refer the number assigned to characters.

1.7. Encoding Characters as Octet Sequences
----------------------------------------------

An **octet** is a small unit of data with a numerical value between 0 and 255,
inclusively.

The word "byte" is more common than "octet", but the octet is a more **definite**
concept. In Unicode, the term octet is normally used.

An encoding **maps** code numbers of characters into octet sequences.

Character encodings are often called character sets, and the abbreviation
**charset** is used in Internet protocols to denote a character encoding.
This is **confusing** because people often understand "set" as "repertoire".
So It is advisable to **avoid** the phrase "character set" whenever possible.

Chp 3. Character Sets and Encodings
========================================

Some related but **different** concept:

    -   character repertoire: A collection of characters
    -   character code: A mapping of characters into the set of numbers
    -   character encoding: A mapping of numbers into sequences of octets

The **misnomer** "8-bit ASCII" is used to refer to various character codes,
which are **extensions** of ASCII and mutually more or less incompatible

ISO-8859 is a family of character code standards. They were largely developed
by ECMA.

Windows Latin-1 is the Microsoft-specific version of ISO-8859-1.The main
**difference** is that some code positions which are **reserved** for control
characters in ISO-8859-1 are **assigned** to various printable characters,
especially punctuation marks, in Windows Latin-1.

ISO-2022 defines a general framework for switching between 8-bit codes, though
its use is much more **limited** than one might think.

The most widely used encoding for Russian is **KOI8-R**, where letter "K" stards
for Cyrillic and letter "R" stands for Russian.

The number in names of UTF-32, UTF-16, UTF-8, and UTF-7 indicates the **size**
of the **code unit** in bits.

Chp 4. The Structure of Unicode
========================================

4.1. Design Principles
------------------------------

The designing goal of unicode : **University**, **Efficiency**, **Unambiguty**.

University **implies** complexity rather than simplicity.

The efficiency goal needs to be understood with the implicit reservation:
"to the extent possible, given the universality goal with higher priority."

Unambiguity also means unambiguity **across** time and version.

**Unification** means treating different appearances and uses of a symbol as
one character rather than several characters. Unicode performs **extensive**
unification, although with many exceptions.

Generally, unification will **NOT** be applied **across** different writing
systems.

ISO 10646 and the Unicode standard are **NOT identical** in content but they
are **fully equivalent** in matters covered by both standards.

ISO 10646 is more **theoretical** and the Unicode standard is more **practical**

The range of possible Unicode numbers has been defined so that the numbers can
be expressed using 21 bits.  If you need to characterize Unicode as an "n-bit"
code, the best choice for n is **21**.

The Unicode name is called the **formal name** in the Unicode standard, to
distinguish it from an **alternative name** (alias).

4.2. Versions of Unicode
------------------------------

There is a **firm policy** that no characters will be removed, no code numbers
changed, and no Unicode names changed. Annotations, including alternate names,
and properties of characters may change.

4.3. Coding Space
------------------------------

The coding space of Unicode has been divided into 17 parts called planes.

code points can be expressed in 21 bits, with the first 5 bits specifying the
plane and the rest the position inside a plane.

Until recently, the use of Unicode has mostly been **limited** to **BMP**
consisting of the range 0..FFFF

Between planes and rows, there is an **auxiliary** and informal structuring
level caleed allocation areas . The areas are mainly an organizational device
for Unicode **development**.

Each plane can be divided into 256 parts called **rows**. This term can be
**misleading**, since such a row is often presented visually as an matrix
with 16 rows and 16 columns.

There is a more **important** concept of a block.  A block is a **contiguous**
range of code points, which have **similar** characteristics and which has a
name assigned to it in the Unicode standard.

Rows and blocks are two **different** ways of dividing a plane into parts:
a **mathematical** way and a **logical** way.

The range U+0000 to U+00FF has thus been directly **copied** from
ISO-8859-1, although it has been divided into blocks: **Basic Latin**
(U+0000 to U+007F) and **Latin-1 Supplement** (U+0080 to U+00FF).

The last two code points of the BMP, namely U+FFFE and U+FFFF, have been
explicitly defined as **forbidden** in Unicode data. By definition, they
do not denote any character or control function, and their occurrence in
character data may be treated as an **error**. However, they may appear
in a data stream that contains character data; they would then indicate
**noncharacter** data.

Moreover, code points U+FDD0..U+FDEF have been defined as noncharacters.
a function that normally returns a character may return one of these values
to **signal** "no character"

Not all code points correspond to characters. There are 4 possibilities:

    -   assigned
    -   private use
    -   non-character
    -   unsigned/reserverd

Do **NOT** use unassigned code points for **anything** out of any reason.

**surrogates** are not to be used as characters. Instead, one particular
encoding, **UTF-16**, uses code units in the surrogate ranges as a method of
**encoding characters** outside the BMP.

4.4. Unicode Terms
--------------------

A **digraph** is a **combination** of two successive characters treated as a
unit in some sense. A digraph is normally written as two **separate** characters
in Unicode. Treating them as a unit is up to an **application**.

4.7. Criticism of Unicode
------------------------------

Unicode is **complex** because it deals with **complex phenomena**.

The large number of characters in Unicode is a much **smaller burden** than you
might expect. A program that supports Unicode may well support only a **subset**
of Unicode characters.

**Han Unification** has been a topic criticized of **culture discrimination**
for a long time.


Some Unicode names of characters are **misleading**, **misspelled**, or even
completely **wrong**, when considered as a descriptive name.  This has caused
many protests. It is understandable that when you find a character that you
know well and you notice an error in its name, you want it to be fixed. Yet,
the response is always: Unicode names are **fixed** and will **never** change.


Chp 5. Properties of Characters
===================================

The Unicode standard designates some properties as **normative**.  Such a
property is prescriptive in the sense that if a conforming implementation
uses the property, it must do so in accordance with its definition. The
non-normative properties are called **informative**.

Character properties, even normative properties, are **NOT guaranteed**
to remain stable, and in practice, some properties have been changed
between Unicode versions.

5.1. Character Classification
------------------------------

One important property is called  "**General Category**".

The General Category property, defined for all characters, constitutes a
fundamental **classification** into letters, numbers, punctuation, mathematical
symbols, etc.

When writing pattern-matching routines, you often need to work with concepts
like "letter" or "digit." Instead of dealing with a huge amount of letters
individually, you work with the classification.

The classification is **hierarchical**: the General Category property indicates
both a **major class** of a character and a **subclass**. The property is
expressed with a **two-letter** code such as `Lu`, which means `letter in
uppercase`.  Example Code::

    while(<>)
    {
        if (m/\p{Lu}/)
        {
            print;
        }
    }


Chp 6. Unicode Encodings
==============================

The encodings UTF-8, UTF-16, and UTF-32 are all **self-synchronizing** . This
feature means that if malformed data is encountered, only one **code point**
needs to be **rejected**. The start of the representation of the next code
point can be recognized easily.


Although UTF-32 is not efficent for external storage, it is quite **suited**
for **in-memory** data processing, bacause it allows **fast data access**. To
address the nth character of a string, a program would just add 4 x ( n - 1)
to the base address of the string.

6.2. UTF-32 and UCS-4
------------------------

UCS-4 is effectively the ISO 10646 **equivalent** of UTF-32. They were once
different in history, but now are actully the same.

6.3. UTF-16 and UCS-2
-------------------------

UCS-2 is by definition **limited** to **BMP**. It is therefore not a full
Unicode encoding.

UTF-16 is basically UCS-2 **enhanced** with the mechanism of **surrogate pairs**
for representing Unicode characters outside **BMP**.

Because of existence of surrogate pairs, UTF-16 is **not** a **fix-length**
encoding.  This means UTF-16 does **NOT** support fast access(constant time)
as UTF-32 does.

6.4. UTF-8
--------------------

UTF-8 is **fully** compatible with ASCII, but it is **NOT** compatbile with
ISO-8859-1.

UTF-8 does NOT support fast access, neither.

6.5. Byte Order
--------------------

Filesystems often **lack** methods for saving information about encoding and
byte order. Indicating the byte order in the data itself, using a BOM, helps
quite a lot.

In general, there's no reason not to use BOM in UTF-16 and UTF-32.

In UTF-8, using BOM serves no purpose and is generally **discouraged**. The
most common situation for its presence is that data has been converted from
UTF-16 or UTF-32 without removing BOM.


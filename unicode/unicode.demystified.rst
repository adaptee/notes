Chapter 1. Language, Computers, and Unicode
=============================================

Unicode **prefers** the give-the-marks-their-own-codes approach, but in many
cases it also provides unique codes for the more common **letter-mark**
combinations.

Standards documents are written by and for people who will **implement** the
standard. They **assume** extensive **domain knowledge** and are designed to
define as **precisely** as possible every aspect of what is being standardized.

Standards **tend** by their very nature to be **dry**, **turgid**, legalistic,
and highly **technical** documents.

Chapter 2. A Brief History of Character Encoding
=================================================

Unicode is **NOT** the **first** attempt to solve the problem it addresses.

2.1 Single-Byte Encoding Systems
----------------------------------------

ISO 646 left the definitions of 12 characters **open**, the so-called
**national-use** code positions

ISO 2022 sets forth a method of **organizing** the code space for various
character encoding methods.

2.2 Character Encoding Terminology
----------------------------------------

It's useful to think of the mapping of a sequence of written characters to a
sequence of bits as taking places in a **series** of stages, or levels, rather
than **all at once**.

The Internet Architecture Board (IAB) proposed a **three-level** encoding model.
The Unicode standard proposes a **five-level** model, as listed below:

    1. abstract character repertoire：a collection of **characters**

    2. coded character set: mapping between characters in abstract repertoire
       and a collection of numbers called as **code points**.

    3. character encoding form: map abstract code points to sequences of
       integers of a specific size, called **code units**.

    4. character encoding scheme: map code unit into actuall sequence of
       **bits**.

    5. transfer encoding syntax: such as **Base64**

2.5 ISO 10646 and Unicode
------------------------------

The connection between 10646 and 646 is **not accidental**: the number signifies
that 10646 is an **extension** of 646.

Chapter 3. Architecture: Not Just a Pile of Code Charts
============================================================

3.2 Character Positioning
------------------------------

Unicode strings stores characters in the order they'd be spoken or typed by a
native speaker of one language, known as **logical order**.

3.3 The Principle of Unification
---------------------------------

Unicode encodes **semantics**, not appearances.

The **philosophy** of encoding semantics rather than appearance leads to another
important Unicode principle: the **principle of unification**.

Generally, characters are **not unified across** writing system boundaries.It
makes more sense to keep each writing system **distinct**.

One big **exception** exists: respect for **existing practice**.

It was important for Unicode to be interoperable with various encoding systems
that came before it. In particular, for a subset of "legacy" encodings, Unicode
is specifically designed to preserve **round-trip compatibility**.

Many characters that would have been unified in Unicode actually aren't because
of the need to preserve round-trip compatibility with a legacy encoding.

The biggest, most complicated, and most **controversial** instance of character
unification in Unicode involves the Han ideographs.

One interesting situation is a character with multiple glyphs needs to be drawn
with a **particular** glyph in certain situation.

Unicode 3.2 introduces 16 general-purpose **variation selectors**, which act as
**hints** to the rendering process.

3.4 Multiple Representations
------------------------------

There are two broad categories of **decomposing characters**:

    -   those with canonical decompositions,  often referred to as
        "precomposed characters" or "canonical composites")

    -   those with compatibility decompositions, often referred to as
        "compatibility composite"

Most canonical decompositions are combinations of a "base character" and
one or more diacritical marks.

Because a canonical composite can be mapped to its canonical decomposition
**without losing data**, the original character and its decomposition are
freely **interchangeable**.

A character can't be substituted by its compatibility decomposition without
losing data.



3.7 Unicode Versions and Unicode Technical Reports
------------------------------------------------------

A character's **combining class** and canonical and compatibility decompositions
will never change, as that would break the **normalization guarantee**.

Various **structural aspects** of the Unicode character properties will remain
the same, as implementations depend on some of these things. For example, the
standard won't add any new general categories or any new bi-di categories.

3.9 Conforming to the Standard
---------------------------------

Conforming to the Unicode standard does **NOT** mean that you have to properly
support every single character that the Unicode standard defines.

For the characters you claim to support, you have to follow **all** the rules
in the standard.

When you compare two Unicode character strings for equality, strings that are
**canonically equivalent** should compare as equal. Thus you're **NOT** supposed
to do a straight **bitwise comparison** without normalizing first.


Chapter 10. Scripts of East Asia
========================================

This group of scripts is **fundamentally different** from the others.

The Chinese characters have no known antecedent.

10.1 The Han Characters
------------------------------

The Kangxi dictionary remains the definitive authority for classical Chinese
literature, and its system of 214 **radicals** continues to be used today to
**classify** Chinese characters. In fact, this system of radicals is used in
the **radical-stroke** index in the Unicode standard itself.

In a phonetic writing system, someone who doesn't speak a particular language
but uses the same script can still look at the writing and have at least a
**vague idea** of how the words are **pronounced**, althouth with probably
little or **no idea** of their **meanings**.

With the Han characters, someone can look at something other than his native
language written using the Han characters and get a **vague idea** of its
**meaning**, but have little or **no idea** of how it's **pronounced**.


10.3 Han Characters in Unicode
---------------------------------

Two principal rules for **Han Unification**:


    -   **Source Separation** Rule: If one encoding standard that went into the
        original set of Han characters(called as "**primary source standards**"
        by the committee) encodes two characters separately, then Unicode does
        as well.

    -   Noncognate Rule: If two characters look similar but have distinct meanings,
        they are **NOT** unified.


For Han characters, Unicode designers opted for a culturally neutral ordering
based upon the ordering of the **Kangxi dictionary**.

10.4 Ideographic Description Sequences
----------------------------------------

The **geta mark** (U+3013) gives you a **visual tip-off** that the passage
includes a character that **can't be rendered**, but it doesn't tell you
anything about that character.

Unicode 3.0 introduces a **refinement** of geta, which offers a little more
information. It's called the **ideographic variation indicator** (U+303F):

You **precede** **another** Han characters with the ideographic variation
indicator to say that the character you really want is somehow **related**
to that following character.

Unicode 3.0 also introduced a much **richer** way of expressing which character
you mean when it isn't available, called as **ideographic description sequence**

The ideographic description characters fulfill that role of indicating how
other ideographs are **joined together**.

10.8 Half-width and Full-width Characters
--------------------------------------------

**Full-width** characters are **as wide** as they are high. **Half-width**
characters are **half as wide** as they are high.

Unicode Standard Annex #11, "East Asian Width," **extends** the properties of
width to the entire Unicode character repertoire, so that applications that
treat "half-width" and "full-width" characters differently will know how to
treat every character in Unicode. It does so by **classifying** the Unicode
characters into **six categories**. An application resolves these six categories
**down to** two broad categories, "narrow" and "wide," depending on context.

    -   **Fullwidth(F)**: always treated as `wide`

    -   **Halfwidth(H)**: always treated as `narrow`

    -   **Wide(W)**: always treated as `wide`

    -   **Narrow(Na)**: always treated as `narrow`

    -   **Ambiguous(A)**: treated as `wide` in East-Asian context, otherwise as `narrow`

    -   **Neutral(N)**: practically, always treated as `narrow`.


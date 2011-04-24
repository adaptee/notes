Section 1. Overview and Scope
==============================

Line breaking, also known as word wrapping, is the process of breaking
a section of text into lines such that it will fit in the available
width of a page, window or other display area. The Unicode Line Breaking
Algorithm performs part of this process. Given an input text, it
produces a set of positions called "break opportunities" that are
appropriate points to begin a new line.

For most Unicode characters, considerable variation in line breaking
behavior can be expected, including variation based on local or
stylistic preferences. For that reason, the line breaking properties
provided for these characters are informative. On the other hand, Some
characters are intended to explicitly influence line breaking. Their
line breaking behavior is therefore expected to be identical across all
implementations. The Unicode Standard assigns normative line breaking
properties to those characters.

Section 3. Introduction
==============================

In line breaking, it is necessary to distinguish between **three** related
tasks.

The first is the **determination** of **all legal** line break opportunities,
given a string of text. This is the scope of the Unicode Line Breaking Algorithm.

The second task is the **selection** of the **actual** location for breaking a
given string of text. This selection not only takes into account the width of
the line compared to the width of the text, but may also apply an additional
prioritization of line breaks based on aesthetic and other criteria. What
defines an **optimal** choice for a given line break is outside the scope of
Unicode, as are methods for its selection.

The third is the possible **justification** of lines, once actual locations for
line breaking have been determined, and is also out of scope for the Unicode
Line Breaking Algorithm.

Three **principal** styles of context analysis determine line break
opportunities:

    1. Western: spaces and hyphens are used to determine breaks
    2. East Asian: lines can break anywhere, unless prohibited
    3. South East Asian: line breaks require morphological analysis


In bidirectional text, line breaks are determined **before** applying rule L1
of the Unicode Bidirectional Algorithm. However, line breaking is strictly
**independent** of directional properties of the characters


Section 4 Conformance
==========================

some characters have been encoded **explicitly** for their effect on line
breaking. Because users adding such characters to a text expect that they
will have the desired effect, these characters have been given required line
breaking behavior.

Section 5 Line Breaking Properties
========================================

The classification by property values defined in this section and in the data
file is used as **input** into two algorithms defined in Section 6 and Section
7.

The full classification of all Unicode characters by their line breaking
properties is available in the file **LineBreak.txt** in the Unicode Character
Database.

Section 6 Line Breaking Algorithm
========================================



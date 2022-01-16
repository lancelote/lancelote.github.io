<!--
.. title: ast.parse() Type Annotation
.. slug: astparse-type-annotation
.. date: 2022-01-14 21:31:54 UTC+03:00
.. tags: 
.. category: 
.. link: 
.. description: 
.. type: text
.. status: draft
-->

Teaser content.

<!-- TEASER_END -->

https://github.com/python/typeshed/pull/6522

- New union syntax
- What is `typeshed`?

# Plan

## Basic Signature

- What parameters does the function takes?
- Type annotate and drop non-interesting parameters
- Pre 3.8
- Why improving?

## First Naive Solution

- What literals produce what return type
- Just add the missing literals
- Pre-3.8 version
- What's wrong with the current solution?

```
Overloaded function signatures X and Y overlap with incompatible return types
```

## Throw-in More Overloads

...

## Remove Needless Overloads

- Merge with the previous part?

## Allow Non-literal Strings

- What should be returned by the new overload?

```python
@overload
def parse(
    source: str | bytes,
    filename: str | bytes = ...,
    mode: str = ...,
    *,
    type_comments: bool = ...,
    feature_version: None | int | _typing.Tuple[int, int] = ...,
) -> AST: ...
```

and

```python
@overload
def parse(source: str | bytes, filename: str | bytes = ..., mode: str = ...) -> AST: ...
```

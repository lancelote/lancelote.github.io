---
layout: post
title: Linters and PyCharm
permalink: virtualenv
---

Today's topic is linters. Not sure about you but I'm a huge fun of linters in Python. As a PyCharm user I already have great inspections and stuff you may expect from the good IDE but as a code style maniac it's absolutely not enough for me. So my "standard" pack of linters include: `pylint`, `pydocstyle`, `pycodestyle` and `mypy`. Not sure if one can call `mypy` a linter but let's live with it for now. I'll briefly describe each one of them, will touch PyCharm integration via external tools and will provide a live example from one of my repositories on github. Here we go.

## Basics

Just a few notes about linters in general and how one can benefit from using them in Python. First of all the main purpose of [linters][1] - to check your source code (not in the runtime) and find possible style, logic and all other kinds of errors (feel free to narrow down the definition to only style errors). As you probably know Python is a dynamic language which leads to a broad field of possible errors which will not be found by the compiler. Obviously linters may eliminate such errors before you or your users will find them. Another great linters advantage is to enforce style of your code (remember PEP8). Good uniform style will result in less errors, maintaining easiness, new contributes convenience, you named it.

## pylint

[pylint][2] is a well known Python linter and one of my favorite tools which I use extensively in almost every project I have. It's very strict and highly customizable. To run `pylint` against your code just type:

```
python -m pylint <some_dir>
```

By default it generates a super verbose output with code assessment, different metrics (tables) and so on. The most important here is warnings (top of the report), e.g.:

```
************* Module src.year2016.day3b
E: 27, 0: Sequence index is not an int, slice, or instance with __index__ (invalid-sequence-index)
C: 44, 8: Invalid variable name "a" (invalid-name)
```

These two tell us that I used a wrong type inside a slice and an invalid name of the variable (in terms of PEP8). As I said `pylint` is a super strict and some errors may be just false positives, in the case above I really known what I'm doing with the variable name `a` and wrong type in slice is just a Python 3.6 style type annotation that is not supported by `pylint` at all.

To mute such false positives and customize the report one may use `pylintrc` file, this is in fact very simple and useful. Just create a `pylintrc` file in the project root and add a customizations, for example one of my files:

```
[MESSAGES CONTROL]
disable=locally-disabled,
 # False positive for type annotations with typing module
 invalid-sequence-index,
 # False positive for OK test methods names and few other places
 invalid-name,
 # False positive for test file classes and methods
 missing-docstring

[REPORTS]
# Simplify pylint reports
reports=no

[SIMILARITIES]
min-similarity-lines=10
ignore-docstrings=yes
```

## pydocstyle

[pydocstyle][3] is a simple tool which goal is to check your docstrings for correct style. You're going to be surprised what errors you'll see I never thought there're such conventions in Python before I start using it.

Execution is straightforward:

```bash
python -m pydocstyle
```

And the result:

```bash
./src/year2016/day4b.py:36 in public function `solve`:
        D202: No blank lines allowed after function docstring (found 1)
./src/year2016/day4b.py:36 in public function `solve`:
        D400: First line should end with a period (not 'd')
```

Here I have two errors: first one points to a blank line after the docstring which is not allowed by the convention and the second one tells that first line of the docstring should be ended with the dot like a normal sentence does.

There's no much to elaborate on here, just try it, al least `pydocstyle` is going to enforce you to place docstring in all of your functions and classes which is kinda nice thing to do.

## pycodestyle

[pycodestyle][4]

## mypy

[mypy][5]

## PyCharm Integration

ToDo: describe basic integration with PyCharm

## Live Example

For a live example I choose my [simple project][7] with solutions for [Advent of Code][6] puzzles. It's super easy and does not use any specific configuration for linters apart of `pylintrc` and a little customisation for calls in `Makefile`.

I usually implement some kind of automation for my projects. I used several different utilities for it and now my favorite is simple `Makefile`s. The logic is very simple - `Makefile` contains commands which you can run with `make <command>`. This command will execute a bunch of predefined instructions right in your terminal, for example:

```
lint:
	python -m pylint main.py src tests
	python -m pydocstyle
	python -m pycodestyle --select E,W .
	python -m mypy .

```

`lint` command will execute all linters one by one. Each line is straightforward. If there will be errors `make` will stop and output the captured log.

For manual usage I rely on PyCharm integration but it's very useful to have such automation for continues integration, for example my `.travis.yml` related part:

```
install:
  - make update

script:
  - make test
  - make lint
```

Very concise and reusable.

## Resume

So is the linters usage is must have? I'm not 100% sure. There're few questions that bother me a little:

 - Is the type annotations in Python goes against the language dynamic nature and limits developers?
 - Are not linters force you sometimes to change the source code not because you have a bad architecture but because the new one will work better just for linters?
 - Is the linters usage profit worth spending time on?
 - ...

Feel free to decide for yourself. Meanwhile please leave any recommendations, suggestions and general feedback in the comments below - I would love to incorporate any tips in the post. Thank you for reading!

 [1]: https://en.wikipedia.org/wiki/Lint_(software)
 [2]: https://www.pylint.org
 [3]: http://www.pydocstyle.org
 [4]: http://pycodestyle.pycqa.org/
 [5]: http://mypy-lang.org
 [6]: http://adventofcode.com
 [7]: https://github.com/lancelote/advent_of_code

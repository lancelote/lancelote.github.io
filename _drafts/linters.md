---
layout: post
title: Linters and PyCharm
permalink: virtualenv
---

Today's topic is linters. Not sure about you but I'm a huge fun of linters in Python. As a PyCharm user I already have great inspections and stuff you may expect from the good IDE but as a code style maniac it's absolutely not enough for me. So my "standard" pack of linters include: `pylint`, `pydocstyle`, `pycodestyle` and `mypy`. Not sure if one can call `mypy` as a linter but let's live with it for now. I'll briefly describe each one of them, will touch PyCharm integration via external tools and will provide a live example from one of my repositories on github. Here we go.

## Basics

Just a few notes about linters in general and how one can benefit from using them in Python. First of all the main purpose of [linters][1] - to check your source code (not in the runtime) and find possible style, logic and all other kinds of errors (feel free to narrow down the definition to only style errors). As you probably know Python is a dynamic language which leads to a broad field of possible errors which will not be found by the compiler. Obviously linters may eliminate such errors before you or your users will find them. Another great linters advantage is to enforce style of your code (remember the PEP8). Good uniform style will result in less errors, maintaining easiness, new contributes convenience, you named it.

## pylint

[pylint][2]

## pydocstyle

[pydocstyle][3]

## pycodestyle

[pycodestyle][4]

## mypy

[mypy][5]

## PyCharm Integration

ToDo: describe basic integration with PyCharm

## Live Example

ToDo: advent of code project - https://github.com/lancelote/advent_of_code

## Resume

So is the linters usage is must have? I'm not 100% sure. There're few questions that bother me a little:

 - Is the type annotations in Python goes against the language dynamic nature and limits developers?
 - Are not linters force you sometimes to change the source code not because you have a bad architecture but because the new one will work better just for linters?
 - ...

Feel free to decide for yourself. Meanwhile please leave any recommendations, suggestions and general feedback in the comments below - I would love to incorporate any tips in the post. Thank you for reading!

 [1]: https://en.wikipedia.org/wiki/Lint_(software)
 [2]: https://www.pylint.org
 [3]: http://www.pydocstyle.org
 [4]: http://pycodestyle.pycqa.org/
 [5]: http://mypy-lang.org

---
layout: post
title: virualenv
permalink: virtualenv
---

# Intro

Do you use `virtualenv` guys? I hope everyone said yes, but in fact I met a lot of people who don't. Not only novice Python developers but even Middle and Senior level experts. Someone said it's a redundant tool or hard to manage itself. Well, maybe, if you do not use it right especially. Nevertheless `virtualenv` is an vital tools for every Python programmer nowadays. You should know it, you should use it and you should love it. This post will broadly present `virtualenv` and some tools from the same "ecosystem" like `virtualenvwrapper` and `pip-tools`. So take a seat and lets go.

# Standard `pip` commands

Just to be consistent - what is `pip`? `pip` is a package management system for Python. Essential tool and a part of the language today. You're probably know it. What can we do with it?

We can install new packages:

```bash
pip install some_package
```

We can install a bunch of packages from the requirements file:

```bash
pip install -r requirements.txt
```

Pretty common pattern by the way. Every self-respecting Python project has some kind of requirements list and `requirements.txt` is a convenient name for it. Some projects contain several requirement files, for example typical Django project may have separate requirements for development environment, testing, staging, production and so on. We will mention requirements files in detail later, stay tuned.

We can create a requirements file based on the list of installed packages in the current active Python environment (more details later):

```bash
pip freeze > requirements.txt
```

We can list installed packages:

```bash
pip list
```

And check for outdated packages:

```bash
pip list --outdated
```

We can also update a package:

```bash
pip install --upgrade some_package
```

And finally we can uninstall it:

```bash
pip uninstall some_package
```

This is just short list of most popular commands which one can use everyday.

# virtualenv

# virtualenvwrapper

# pip-tools

# pip-review

# Multiple requirements files

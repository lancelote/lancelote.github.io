.. title: Runtime bytecode manipulations
.. slug: bytecode
.. date: 2018-09-07 14:30:00 UTC+03:00
.. tags: python,bytecode
.. category:
.. link:
.. description:
.. type: text

Let's say you have a class with a method which raises an exception on the first
line and prints something on the second. Is it possible to reach print without
editing the source code or using ``pdb``? It is indeed, we will do it by
patching a method bytecode in the runtime.

Do not try this at home!

.. TEASER_END

Setup
=====

Lets start with a source code:

.. code:: python

    class Challenge:
        def method(self):
            raise Exception('fail')
            print('success')

Now run it:

.. code:: python

    Challenge().method()
    # Exception: fail

The goal is to get ``success`` in the output instead.

Method Bytecode
===============

To get the method byte code let's copy the method itself to a new variable:

.. code:: python

    ch = Challenge.method

we can access ``ch`` the bytecode instructions string by ``__code__.co_code``
attribute:

.. code:: python

    ch.__code__.co_code
    # b't\x00d\x01\x83\x01\x82\x01t\x01d\x02\x83\x01\x01\x00d\x00S\x00'

Meaning behind the Bytecode
===========================

Basically each byte is an instruction. So the solution is near - we have to
remove the ``raise`` part of the byte code in place and we are done.
Unfortunately, it's unclear which bytes are responsible for the line of
interest.

To figure it out let's disassemble the method source code:

.. code:: python

    from dis import dis

    dis(ch)
    #  3           0 LOAD_GLOBAL              0 (Exception)
    #              2 LOAD_CONST               1 ('fail')
    #              4 CALL_FUNCTION            1
    #              6 RAISE_VARARGS            1

    #  4           8 LOAD_GLOBAL              1 (print)
    #             10 LOAD_CONST               2 ('success')
    #             12 CALL_FUNCTION            1
    #             14 POP_TOP
    #             16 LOAD_CONST               0 (None)
    #             18 RETURN_VALUE

The first four lines are responsible for loading the ``Exception``,
``fail`` string and raising the exception. To map opcodes
(e.g. ``RAISE_VARARGS``) to bytes we can use ``dis.opmap`` dictionary:

.. code:: python

    for op in ['LOAD_GLOBAL', 'LOAD_CONST', 'CALL_FUNCTION', 'RAISE_VARARGS']:
        print('%-16s%s' % (op, dis.opmap[op].to_bytes(1, byteorder='little')))

    # LOAD_GLOBAL     b't'
    # LOAD_CONST      b'd'
    # CALL_FUNCTION   b'\x83'
    # RAISE_VARARGS   b'\x82'

The bytecode now makes sense, it's a sequence of opcode and opcode argument
bytes so first eight bytes are responsible for the exception raise:

.. code::

    t     # LOAD_GLOBAL
    \x00  # argument
    d     # LOAD_CONST
    \x01  # argument
    \x83  # CALL_FUNCTION
    \x01  # argument
    \x82  # RAISE_VARARGS
    \x01  # argument

Opcode arguments are irrelevant for our task.

Editing Method Bytecode
=======================

Knowing the meaning of each byte we can edit the original byte string. The
desired literal looks like

.. code::

    b't\x01d\x02\x83\x01\x01\x00d\x00S\x00'

i.e. without ``t\x00d\x01\x83\x01\x82\x01`` part responsible for raising an
exception.

At this point we have a problem, one can't simply change ``co_code`` value:

.. code::

    ch.__code__.co_code = b't\x01d\x02\x83\x01\x01\x00d\x00S\x00'
    # Traceback (most recent call last):
    #   File "<input>", line 1, in <module>
    # AttributeError: readonly attribute

To work around this limitation we will recreate the whole ``__code__``
object. For this purpose let's create a utility function:

.. code::

    from types import CodeType


    def patch_function(func, co_code):
        fn_code = func.__code__
        func.__code__ = CodeType(
            fn_code.co_argcount,
            fn_code.co_kwonlyargcount,
            fn_code.co_nlocals,
            fn_code.co_stacksize,
            fn_code.co_flags,
            co_code,
            fn_code.co_consts,
            fn_code.co_names,
            fn_code.co_varnames,
            fn_code.co_filename,
            fn_code.co_name,
            fn_code.co_firstlineno,
            fn_code.co_lnotab,
            fn_code.co_freevars,
            fn_code.co_cellvars,
        )

What it does is basically creates a new ``__code__`` for function by copying
all old function ``__code__`` attributes except ``co_code`` which is replaced
with the desired value. The list of ``CodeType`` arguments can be retrieved
from e.g. typeshed_.

Patching Method in Runtime
==========================

The last part, we have a new bytecode, let's patch the original method and run
it:

.. code::

    co_code = b't\x01d\x02\x83\x01\x01\x00d\x00S\x00'
    patch_function(ch, co_code)
    ch(Challenge())  # We have to pass a Challenge instance as a self parameter
    # success

Extra Links
===========

- "`Python Byte Code Hacks`_" by Vijay Kumar
- "`How to patch Python bytecode`_" by Artem Golubin

.. _typeshed: https://github.com/python/typeshed/blob/master/stdlib/3/types.pyi#L39
.. _Python Byte Code Hacks: http://www.bravegnu.org/blog/python-byte-code-hacks.html
.. _How to patch Python bytecode: https://rushter.com/blog/python-bytecode-patch/
.. title: Parallel and Remote Test Execution with pytest-xdist
.. slug: xdist
.. date: 2019-03-10 01:00:00 UTC+03:00
.. tags: python,pytest,pycharm,pytest-xdist
.. category:
.. link:
.. description:
.. type: text

2019.1 PyCharm version will come with native ``pytest-xdist`` support so I
spent some time playing with it to discover a bunch of neat features. Some were
a bit hard to get working right away so here are some notes for future
references.

.. TEASER_END

- The official docs: https://github.com/pytest-dev/pytest-xdist
- The project for tests: https://github.com/lancelote/advent_of_code

It takes ``~1m 12s`` to run the test suit on my machine. The number will be
used to compare with different execution modes below.

Utilize CPU Cores
=================

- Run ``pytest -n <number_of_cores>`` to get your test parallelled
- Use ``-n auto`` to auto detect the max number of cores and use it

I have 8 cores, so ``pytest -n 8`` gives me ``36s`` which is not 8 times faster
of course but a significant boost anyway.

Possible Problems
-----------------

I was surprised to discover that not all tests can be paralleled, for example:

.. code:: python

    @pytest.mark.parametrize('platform', {'linux', 'darwin', 'win32'})
    def test_support_os(mocker, platform, log, runner, mock_archive_project):
        mocker.patch('sys.platform', platform)
        result = runner.invoke(cli, ['archive'])
        assert result.exit_code == 0
        assert 'Wrong os' not in log.text
        mock_archive_project.assert_called_once()

The problem is a set of platforms. Set in Python is unordered collection so
when running in different processes there's no way for ``pytest-xdist`` to
ensure ``linux`` is going to be tested in process A, while ``darwin`` in
process B, it can be both ``linux``, both ``darwin`` and so on.

So to use ``pytest-xdist`` your tests case list should always be determined
between runs.

Utilizing Subprocesses
======================

- Run ``pytest -d --tx 3*popen//python=<path_to_python_executable>`` to start 3
  subprocesses and run your tests there
- ``-d`` is important as it tells ``pytest`` to load-balance tests
- Use ``--dist`` instead of ``-d`` to specify a different test distribution
  policy

It takes ``34s`` to execute tests in 8 subprocesses for the given test suit.

Test Execution Environment
==========================

- ``--tx`` defines a test execution environment
- It can either be local and remote (e.g. via SSH)
- Test execution environment uses `xspec syntax`_

Forked Subprocesses
===================

- By installing ``pytest-forked`` plugin you can use ``--forked`` to use
  forked subprocesses
- ``-n 8 --forked`` to run 8 forked subprocesses
- Not available on Windows

``37s`` to execute the test suit with 8 forked subprocesses.

Remote Test Execution
=====================

- ``pytest-xdist`` also allows running tests on the remote machines
- First let's set up ``~/.ssh/config`` to make the actual ``pytest`` calls
  shorter, here's my stripped example

.. code::

    Host windows
      HostName ...
      User ...
      Port 22
      IdentityFile /.../.ssh/windows

    Host ubuntu
      HostName ...
      User ...
      Port 22
      IdentityFile /.../.ssh/ubuntu

- Having two remote machines with Windows and Ubuntu, and local macOS I can now
  construct a one call to ``pytest`` to rule them all

.. code::

  pytest -d \
      --tx ssh=ubuntu//python=/<remote>/.virtualenvs/advent_of_code/bin/python --rsyncdir /<local>/advent_of_code \
      --tx ssh=windows//python=C:\<remote>\.virtualenvs\qa\Scripts\python.exe --rsyncdir /<local>/advent_of_code \
      --tx popen//python=/<local>/.virtualenvs/qa/bin/python

- This will execute your test suit on 3 platforms simultaneously
- Bear in mind:
    - You need an OpenSSH server running on Windows
    - You can put this to ``Makefile``, ``pytest.ini`` and so on to save you
      from typing this lengthy command

Possible Problems
-----------------

It took me awhile to configure new "native" OpenSSH server on Windows, official
docs were somewhat helpful: `OpenSSH for Windows 10`_.

.. _xspec syntax: https://codespeak.net/execnet/basics.html#xspec
.. _OpenSSH for Windows 10: https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse

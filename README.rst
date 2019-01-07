.. image:: https://requires.io/github/lancelote/lancelote.github.io/requirements.svg?branch=master
    :target: https://requires.io/github/lancelote/lancelote.github.io/requirements/?branch=master

=================
pavelkarateev.com
=================

My personal blog, hosted by `GitHub Pages`_. Check it at `pavelkarateev.com`_.

Powered by Nikola_ Python static site generator.

.. _GitHub Pages: http://pages.github.com/
.. _pavelkarateev.com: http://pavelkarateev.com/
.. _Nikola: https://getnikola.com

Usage
=====

.. code:: bash

    checkout src
    # edit files as you want
    #    nikola new_post -d  # for new post
    #    nikola new_post -p  # for new page
    nikola build
    nikola serve
    nikola github_deploy -m "commit message"

Utils
=====

.. code:: bash

    make deps    # Update dependencies in requirements.txt
    make update  # Install / Update all requirements

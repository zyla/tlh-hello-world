Code for the post [Type level Haskell, with IO](https://zyla.neutrino.re/posts/2016-09-06-tlh.html).
Requires a modified version of `hint` library, available as Git submodule.

Building:

    git submodule update --init
    stack build

Running:

    stack exec runtlh -- Hello.hs

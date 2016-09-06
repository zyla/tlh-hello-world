Code for the post "Type level Haskell, with IO".
Requires a modified version of `hint` library, available as Git submodule.

Building:

    git submodule update --init
    stack build

Running:

    stack exec runtlh -- Hello.hs

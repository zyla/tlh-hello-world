{-# LANGUAGE DataKinds, TypeOperators, TypeInType, TypeFamilies, UndecidableInstances #-}
module Hello where

import Prelude hiding (Read, IO)
import GHC.TypeLits (Nat)

-- the IO library
type Bytes = [Nat]
data IO = Exit | Write Bytes IO | Read Cont

type family Force x where Force x = x
type Write b = 'Write (Force b)

-- The program

-- "Enter your name:"
type Prompt = '[69,110,116,101,114,32,121,111,117,114,32,110,97,109,101,58]
-- "Hello, "
type Hello = '[72,101,108,108,111,44,32]
-- "!"
type Exclamation = '[33]

data Cont = HandleName

type Main                   = Write Prompt
                            $ Read
                            $ HandleName
type family Apply f x where
      Apply HandleName name = Write (Hello ++ name ++ Exclamation)
                            $ Exit

-- Utilities from plain Haskell
type family f $ x where f $ x = f x
infixr 0 $

type family xs ++ ys where
    '[] ++ ys = ys
    (x ': xs) ++ ys = x ': (xs ++ ys)

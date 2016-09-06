module Parser where

import Data.Char
import Text.Parsec
import Text.Parsec.String

type Cont = String
type Bytes = [Int]

data Operation = Exit | Read Cont | Write Bytes Cont deriving (Eq, Show)


pOperation :: Parser Operation
pOperation = (string "'" >>) $
     const Exit <$> string "Exit"
 <|> Read <$> (string "Read" *> cont)
 <|> Write <$> (string "Write" *> bytes) <*> cont

cont = ws *> many (anyChar)
bytes = ws *> string "'[" *> ((ws *> intLit) `sepBy` (ws *> char ',')) <* char ']'
ws = many (satisfy isSpace)

intLit = read {- HACK -} <$> many (satisfy isDigit)

parseOperation :: String -> Either ParseError Operation
parseOperation = parse pOperation ""

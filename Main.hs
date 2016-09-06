module Main where

import Control.Monad
import System.Environment
import Language.Haskell.Interpreter
import Parser
import Data.Function (fix)
import System.FilePath (dropExtension)

main :: IO ()
main = do
    modules <- getArgs
    result <- runInterpreter $ do
        loadModules modules
        setTopLevelModules (map dropExtension modules)
        set [languageExtensions := [DataKinds]]

        let go state = do
                ty <- normalizeType $ "Force (" ++ state ++ ")"
                case parseOperation ty of
                  Left err -> liftIO (print err)
                  Right Exit -> pure ()
                  Right op -> liftIO (execute op) >>= go

        go "Main"

    case result of
        Left (WontCompile errors) -> mapM_ (putStrLn . errMsg) errors
        Left err -> print err
        Right _ -> pure ()

execute (Write bytes k) = putStrLn (map toEnum bytes) >> pure k
execute (Read k) = do
    line <- map fromEnum <$> getLine :: IO Bytes
    pure $ "Apply (" ++ k ++ ") " ++ show line

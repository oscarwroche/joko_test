{-# LANGUAGE OverloadedStrings #-}
module Main where

import Text.Parsec (parse)
import Data.Maybe (fromMaybe)
import Data.Either
import Data.Text.Lazy (pack)
import Parsers
import Web.Scotty
import System.Environment (getEnv)

main :: IO ()
main = do
  putStrLn "Starting server ..."
  port <- read <$> getEnv "PORT"
  scotty port $ do
    get "/mol/:molecule" $ do
      molecule <- param "molecule"
      (text . pack) $ fromRight "" $ show <$> (parse generalParser "" molecule)

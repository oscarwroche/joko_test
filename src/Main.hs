{-# LANGUAGE OverloadedStrings #-}
module Main where

import Text.Parsec (parse)
import Text.Parsec.Error (ParseError)
import Data.Maybe (fromMaybe)
import Data.Text.Lazy (pack)
import Parsers
import Utilities
import Web.Scotty
import System.Environment (getEnv)

main :: IO ()
main = do
  putStrLn "Starting server ..."
  port <- read <$> getEnv "PORT"
  scotty port $ do
    get "/mol/:molecule" $ do
      molecule <- param "molecule"
      (text . pack) $ parseInput molecule

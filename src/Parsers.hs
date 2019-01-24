module Parsers where

import Text.Parsec (many, many1, digit, char, string, (<|>), choice, try, Parsec, parse)
import Text.Parsec.String (Parser)
import Data.Either
import qualified Data.Map.Strict as DM
import Elements (elements)
import Utilities

-- Parses whole user input and converts to readable format
parseInput :: String -> String
parseInput molecule = fromRight "" $ show <$> (parse generalParser "" (replaceWithParens molecule))

-- Parses entire chemical formula
generalParser :: Parsec String () MolDict
generalParser = sumConcatDict <$> many1 (moleculeParser <|> atomParser)

-- Parses a molecule group followed or not followed by a number within a chemical formula
moleculeParser :: Parsec String () MolDict
moleculeParser = do
  char '('
  inner <- many1 (moleculeParser <|> atomParser)
  char ')'
  amount <- many digit
  return $ multDict (safeReadNumber amount) (sumConcatDict inner)

-- Parse an atom followed or not followed by a number
atomParser :: Parsec String () MolDict
atomParser = do
  element <- choice . (map try) $ atoms
  number <- many digit
  return $ DM.singleton element (safeReadNumber number)

-- List of parsers for single atoms
atoms :: [Parser String]
atoms = string <$> elements

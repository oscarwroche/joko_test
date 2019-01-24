module Parsers where

import Text.Parsec (many, many1, digit, char, string, (<|>), choice, try, Parsec, parse)
import Text.Parsec.String (Parser)
import Data.Either
import qualified Data.Map.Strict as DM
import Elements (elements)
import Utilities

parseInput :: String -> String
parseInput molecule = fromRight "" $ show <$> (parse generalParser "" (replaceWithParens molecule))

generalParser :: Parsec String () MolDict
generalParser = sumConcatDict <$> many1 (moleculeParser <|> atomParser)

moleculeParser :: Parsec String () MolDict
moleculeParser = do
  char '('
  inner <- many1 (moleculeParser <|> atomParser)
  char ')'
  amount <- many1 digit
  return $ multDict (read amount) (sumConcatDict inner)

atomParser :: Parsec String () MolDict
atomParser = do
  element <- choice . (map try) $ atoms
  number <- many digit
  return $ DM.singleton element (safeReadNumber number)

atoms :: [Parser String]
atoms = string <$> elements

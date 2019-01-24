module Parsers where

import Text.Parsec (many, many1, digit, char, string, (<|>), choice, try, ParseError, Parsec, anyChar, oneOf)
import Text.Parsec.String (Parser)
import qualified Data.Map.Strict as DM
import Elements (elements)
import Utilities

generalParser :: Parsec String () MolDict
generalParser = sumConcatDict <$> many1 (moleculeParser <|> atomParser)

moleculeParser :: Parsec String () MolDict
moleculeParser = do
  char '('
  inner <- many1 (moleculeParser <|> atomParser)
  char ')'
  amount <- many1 digit
  return $ multDict (read amount) (sumConcatDict inner)

atoms :: [Parser String]
atoms = map string elements

atomParser :: Parsec String () MolDict
atomParser = do
  element <- choice . (map try) $ atoms
  number <- many digit
  return $ DM.singleton element (safeReadNumber number)
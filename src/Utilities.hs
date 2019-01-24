module Utilities where

import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)
import qualified Data.Map.Strict as DM
import Elements

-- Type alias for a dictionary with string keys and integer values
type MolDict = (DM.Map String Int)

-- Performs the union of two dictionaries, summing the values correpsonding to the same key
sumConcatDict :: [MolDict] -> MolDict
sumConcatDict = DM.unionsWith (+)

-- Multiplies all values within a dictionary by a given number
multDict :: Int -> MolDict -> MolDict
multDict n d = DM.map (* n) d

-- Returns a number or 1 if nothing is found
-- Used in case there is no numer in front of an atom / group
safeReadNumber :: String -> Int
safeReadNumber x = (fromMaybe 1 (readMaybe x))

-- Replaces brackets and curly braces by parentheses
replaceWithParens :: String -> String
replaceWithParens ('{':xs) = '(':(replaceWithParens xs)
replaceWithParens ('[':xs) = '(':(replaceWithParens xs)
replaceWithParens ('}':xs) = ')':(replaceWithParens xs)
replaceWithParens (']':xs) = ')':(replaceWithParens xs)
replaceWithParens (x:xs) = x:(replaceWithParens xs)
replaceWithParens "" = ""

-- Check if all string formed like atoms in the string are actual atoms
validateString :: String -> Bool
validateString s = foldr (\x acc -> acc && elem x elements) True $ (words . sepAtomsBySpaces) s

sepAtomsBySpaces :: String -> String
sepAtomsBySpaces (x:x1:xs) = case isLetter x of
                                      True -> case isCapitalLetter x1 of 
                                                True -> x:' ':(sepAtomsBySpaces(x1:xs))
                                                False -> x :(sepAtomsBySpaces(x1:xs))
                                      False -> ' ':(sepAtomsBySpaces(x1:xs))
sepAtomsBySpaces (x:"") = case isLetter x of
                            True -> [x]
                            False -> ""
sepAtomsBySpaces "" = ""

isLetter :: Char -> Bool
isLetter x = elem x (['A'..'Z'] ++ ['a'..'z'])

isCapitalLetter :: Char -> Bool
isCapitalLetter x = elem x ['A'..'Z']





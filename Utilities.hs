module Utilities where

import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)
import qualified Data.Map.Strict as DM

type MolDict = (DM.Map String Int)

sumConcatDict :: [MolDict] -> MolDict
sumConcatDict = DM.unionsWith (+)

multDict :: Int -> MolDict -> MolDict
multDict n d = DM.map (* n) d

safeReadNumber :: String -> Int
safeReadNumber x = (fromMaybe 1 (readMaybe x))

replaceWithParens :: String -> String
replaceWithParens ('{':xs) = '(':(replaceWithParens xs)
replaceWithParens ('[':xs) = '(':(replaceWithParens xs)
replaceWithParens ('}':xs) = ')':(replaceWithParens xs)
replaceWithParens (']':xs) = ')':(replaceWithParens xs)


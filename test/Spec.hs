module Main where

import Test.Hspec
import Parsers

main :: IO ()
main = hspec $ do
  describe "Parsing molecules" $ do
    it "can parse H2O" $ do
      parseInput "H2O" `shouldBe` "fromList [(\"H\",2),(\"O\",1)]"

    it "can parse Mg(OH)2" $ do
      parseInput "Mg(OH)2" `shouldBe` "fromList [(\"H\",2),(\"Mg\",1),(\"O\",2)]"

    it "can parse K4[ON(SO3)2]2" $ do
      parseInput "K4[ON(SO3)2]2" `shouldBe` "fromList [(\"K\",4),(\"N\",2),(\"O\",14),(\"S\",4)]"

module Test where

import           Data.Vector (Vector)
import qualified Data.Vector as V
import           Model
import Jewel

testBoard :: Board
testBoard = Board { rows = 5, cols = 3, bData = testBoardData, piece = V.fromList [Ruby, Emerald, Sapphire], piecePos = (4, 1) }

testBoardData :: Vector (Vector Cell)
testBoardData = V.fromList $ map V.fromList [
    [Nothing, Just Ruby, Just Sapphire],
    [Just Sapphire, Just Sapphire, Nothing],
    [Nothing, Nothing, Nothing],
    [Nothing, Nothing, Nothing],
    [Nothing, Nothing, Nothing]]

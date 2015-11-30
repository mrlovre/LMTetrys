module Test where

import           Data.Vector (Vector)
import qualified Data.Vector as V
import           Model
import Jewel

testBoard :: Board
testBoard = Board { rows = 2, cols = 3, bData = testBoardData, piece = V.fromList [Ruby, Ruby, Sapphire], piecePos = (4, 1) }

testBoardData :: Vector (Vector Cell)
testBoardData = V.fromList $ map V.fromList [
    [Nothing, Just Ruby, Just Sapphire],
    [Just Sapphire, Just Sapphire, Nothing]]

module Model where

import           Control.Monad.State
import           Data.Maybe
import           Data.Vector         (Vector, (!), (//))
import qualified Data.Vector         as V
import           Graphics.UI.GLUT    hiding (get)

import           Drawable
import           Jewel
import           Util

type Cell = Maybe Jewel

data Board = Board {
             rows     :: Int,
             cols     :: Int,
             bData    :: Vector (Vector Cell),
             piece    :: Vector Jewel,
             piecePos :: (Int, Int) }

(#) :: Board -> (Int, Int) -> Cell
b # (i, j) = bData b ! i ! j

updateIndex :: (Int, Int) -> Cell -> Board -> Board
updateIndex (i, j) c b = b { bData = updRow } where
    updRow = obData // [(i, updCol)]
    updCol = obData ! i // [(j, c)]
    obData = bData b

updateIndices :: Board -> [((Int, Int), Cell)] -> Board
updateIndices = foldl (\b (pos, c) -> updateIndex pos c b)

row :: Board -> Int -> Vector Cell
row b r = bData b ! r

col :: Board -> Int -> Vector Cell
col b c = V.fromList [row b i ! c | i <- [0 .. rows b - 1]]

fallAll :: Board -> Board
fallAll b = nb where
    nb = foldl (\b' pos -> execState (update pos) b') b indexes
    indexes = [(r, c) | c <- [0 .. cols b - 1], r <- [0 .. rows b - 1]]
    update pos@(r, c) = do
        cell <- (# pos) <$> get
        unless (isJust cell) $ do
            b' <- get
            case fst <$> V.find (isJust . snd) (V.drop r $ V.indexed $ col b' c) of
                Just r' -> do
                    let above = b' # (r', c)
                    modify (updateIndex pos above)
                    modify (updateIndex (r', c) Nothing)
                Nothing -> return () :: State Board ()

movePiece :: Board -> (Int, Int) -> Board
movePiece board@(Board { piecePos = (x, y) }) (dx, dy) = board { piecePos = (x + dx, y + dy) }

instance Show Board where
    show Board { bData = bd } = unlines $ V.toList $ V.reverse $ V.map (concatMap shower . V.toList) bd where
        shower (Just j) = show j
        shower Nothing = " "

instance Drawable Board where
    draw b s p = do
        V.imapM_ (\i -> V.imapM_ (\j c -> onM (drawC i j) c)) (bData b)
        V.imapM_ (\i j -> drawC (2 - i + pr) pc j) (piece b)
        where
            (pr, pc) = piecePos b
            drawC i j x = draw x s (((-0.5 :: Double) `scaleP` p) `addP` Position (fromIntegral j * s * 2) (fromIntegral i * s * 2))
            onM f x = case x of
                Just c -> f c
                Nothing -> return ()

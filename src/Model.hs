module Model where

import           Control.Monad.State
import           Data.Maybe
import           Data.Vector         (Vector, (!), (//))
import qualified Data.Vector         as V
import           Graphics.UI.GLUT    hiding (get)

import           Colors

data Config = Config {
              width  :: GLsizei,
              height :: GLsizei }

defaultConfig :: Config
defaultConfig = Config 800 600

type Cell = Maybe Jewel

data Board = Board {
             rows  :: Int,
             cols  :: Int,
             bData :: Vector (Vector Cell) }

(#) :: Board -> (Int, Int) -> Cell
b # (i, j) = (bData b) ! i ! j

updateIndex :: (Int, Int) -> Cell -> Board -> Board
updateIndex (i, j) c b = b { bData = updRow } where
    updRow = obData // [(i, updCol)]
    updCol = obData ! i // [(j, c)]
    obData = bData b

updateIndexes :: Board -> [((Int, Int), Cell)] -> Board
updateIndexes = foldl (\b (pos, c) -> updateIndex pos c b)

row :: Board -> Int -> Vector Cell
row b r = bData b ! r

col :: Board -> Int -> Vector Cell
col b c = V.fromList [row b i ! c | i <- [0 .. (rows b) - 1]]

fallAll :: Board -> Board
fallAll b = nb where
    nb = foldl (\b' pos -> execState (update pos) b') b indexes
    indexes = [(r, c) | c <- [0 .. cols b - 1], r <- [0 .. rows b - 1]]
    update :: (Int, Int) -> State Board ()
    update pos@(r, c) = do
        cell <- (# pos) <$> get
        when (not $ isJust cell) $ do
            b' <- get
            case fst <$> (V.find (isJust . snd) (V.drop r $ V.indexed $ col b' c)) of
                Just r' -> do
                    let above = b' # (r', c)
                    modify (updateIndex pos above)
                    modify (updateIndex (r', c) Nothing)
                Nothing -> return ()

data Jewel = Ruby | Sapphire

class Colored a where
    getColor :: a -> ColorFG

instance Colored Jewel where
    getColor j = case j of
        Ruby     -> red
        Sapphire -> blue

instance Show Jewel where
    show j = case j of
        Ruby     -> "R"
        Sapphire -> "S"

instance Show Board where
    show Board { bData = bData } = unlines $ V.toList $ V.reverse $ V.map (concatMap shower . V.toList) bData where
        shower (Just j) = show j
        shower Nothing = " "
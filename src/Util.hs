module Util where

import Graphics.UI.GLUT

onTuple :: (a -> b) -> (a, a) -> (b, b)
onTuple f (x, y) = (f x, f y)

addP :: Position -> Position -> Position
Position x1 y1 `addP` Position x2 y2 = Position (x1 + x2) (y1 + y2)

scaleP :: (RealFrac a) => a -> Position -> Position
d `scaleP` Position x y = Position (round $ d * fromIntegral x) (round $ d * fromIntegral y)
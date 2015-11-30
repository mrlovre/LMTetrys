module Drawable where

import Graphics.UI.GLUT (GLint, Position)

class Drawable a where
    draw :: a -> GLint -> Position -> IO ()

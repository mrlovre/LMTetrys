module Controllers where

import           Data.IORef
import           Graphics.UI.GLUT

import           Model

keyboardMouse :: IORef Board -> KeyboardMouseCallback
keyboardMouse boardVar key state mods (Position x y) = do
    boardVar $~ case key of
        SpecialKey KeyLeft  -> (`movePiece` (-1, 0))
        SpecialKey KeyRight -> (`movePiece` (1, 0))
        SpecialKey KeyUp    -> (`movePiece` (0, -1))
        SpecialKey KeyDown  -> (`movePiece` (0, 1))
        _ -> id
    postRedisplay Nothing
    undefined

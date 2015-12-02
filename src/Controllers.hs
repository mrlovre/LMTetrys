module Controllers where

import           Data.IORef
import           Graphics.UI.GLUT

import           Model

keyboardMouse :: IORef Board -> KeyboardMouseCallback
keyboardMouse boardVar key Down _ _ = do
    boardVar $~ case key of
        SpecialKey KeyLeft  -> (`movePieceConstrained` left)
        SpecialKey KeyRight -> (`movePieceConstrained` right)
        SpecialKey KeyUp    -> (`movePieceConstrained` up)
        SpecialKey KeyDown  -> (`movePieceConstrained` down)
        _ -> id
    postRedisplay Nothing

keyboardMouse _ _ _ _ _ = return ()

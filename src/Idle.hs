module Idle where

import           Data.IORef
import           Graphics.UI.GLUT

import           Model

registerBoardUpdater :: (IdleCallback -> IO ()) -> IORef Board -> IO ()
registerBoardUpdater f b = do
    b $~ fallAll
    b $~ (`movePieceConstrained` down)
    f (registerBoardUpdater f b)
    postRedisplay Nothing

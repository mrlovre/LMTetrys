module Display where

import           Control.Monad.Trans.Class
import           Control.Monad.Trans.Reader
import           Graphics.UI.GLUT

import           Colors
import           Drawable
import           SData

type DisplayReaderCallback = ReaderT SData IO ()

display :: DisplayReaderCallback
display = do
    boardVar <- asks board
    lift $ do
        b <- get boardVar
        clearScreen
        draw b 20 (Position 0 0)
        flush

clearScreen :: IO ()
clearScreen = clearColor $= blackBG >> clear [ColorBuffer]

reshape :: ReshapeCallback
reshape size@(Size w_ h_) = do
    let [w, h] = map fromIntegral [w_, h_]
    viewport $= (Position 0 0, size)
    matrixMode $= Projection
    loadIdentity
    ortho2D (-w / 2) (w / 2) (-h / 2) (h / 2)
    postRedisplay Nothing

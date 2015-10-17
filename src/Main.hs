module Main where

import           Control.Monad.Trans.Reader
import           Graphics.UI.GLUT

import           Config
import           Display
import           SData
import           Test

main :: IO ()
main = do
    initialWindowSize $= Size (width defaultConfig) (height defaultConfig)
    initialDisplayMode $= [RGBMode]
    _ <- getArgsAndInitialize
    _ <- createWindow "test"
    displayCallback $= runReaderT display (SData defaultConfig testBoard)
    reshapeCallback $= Just reshape
    mainLoop

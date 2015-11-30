module Main where

import           Control.Monad.Trans.Reader
import           Data.IORef
import           Graphics.UI.GLUT

import           Config
import Controllers
import           Display
import           Idle
import           SData
import           Test

main :: IO ()
main = do
    initialWindowSize $= Size (width defaultConfig) (height defaultConfig)
    initialDisplayMode $= [RGBMode]
    _ <- getArgsAndInitialize
    _ <- createWindow "test"
    tb <- newIORef testBoard
    displayCallback $= runReaderT display (SData defaultConfig tb)
    keyboardMouseCallback $= Just (keyboardMouse tb)
    reshapeCallback $= Just reshape
    idleCallback $= Just idle
    mainLoop

module Main where

import           Control.Monad.Trans.Reader
import           Data.IORef
import           Graphics.UI.GLUT

import           Config
import           Controllers
import           Display
import           Idle
import           Model
import           SData
import           Test

main :: IO ()
main = do
    initialWindowSize  $= Size (width defaultConfig) (height defaultConfig)
    initialDisplayMode $= [RGBMode]
    _ <- getArgsAndInitialize
    _ <- createWindow "test"
    tb <- newIORef testBoard
    registerCallbacks tb
    mainLoop

registerCallbacks :: IORef Board -> IO ()
registerCallbacks tb = do
    displayCallback       $= runReaderT display (SData defaultConfig tb)
    keyboardMouseCallback $= Just (keyboardMouse tb)
    reshapeCallback       $= Just reshape
    registerBoardUpdater (addTimerCallback 1000) tb

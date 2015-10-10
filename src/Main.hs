module Main where

import           Control.Monad.Trans.Reader
import           Graphics.UI.GLUT

import           Display
import           Model

config :: Config
config = defaultConfig

main :: IO ()
main = do
    initialWindowSize $= Size (width defaultConfig) (height defaultConfig)
    initialDisplayMode $= [RGBMode]
    _ <- getArgsAndInitialize
    _ <- createWindow "test"
    displayCallback $= runReaderT display config
    reshapeCallback $= Just reshape
    mainLoop

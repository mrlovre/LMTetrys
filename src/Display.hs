module Display where

import           Control.Monad.Trans.Class
import           Control.Monad.Trans.Reader
import           Graphics.UI.GLUT

import           Colors
import           Model
import           Util

type DisplayReaderCallback = ReaderT Config IO ()

display :: DisplayReaderCallback
display = do
    lift $ do
        clearScreen
        drawNGon yellow (Position 0 0) 7 100 (3 * pi / 14)
        flush

drawSquare :: ColorFG -> GLint -> IO ()
drawSquare c d = do
    color c
    renderPrimitive Polygon $
        mapM_ vertex [Vertex2 x y | (x, y) <- [(-d, -d), (-d, d), (d, d), (d, -d)]]

drawNGon :: ColorFG -> Position -> GLint -> GLint -> GLfloat -> IO ()
drawNGon c (Position x_ y_) n_ d_ phi = do
    let [x, y, d, n] = map fromIntegral [x_, y_, d_, n_] :: [GLfloat]
    color c
    renderPrimitive Polygon $
        mapM_ vertex $ do
            let cossin = (,) <$> cos <*> sin
            (dx, dy) <- map (onTuple (d *) . cossin . (+ phi) . ((2 * pi / n) *)) [1 .. n]
            return $ Vertex2 (x + dx) (y + dy)

clearScreen :: IO ()
clearScreen = do
    clearColor $= blackBG
    clear [ColorBuffer]

reshape :: ReshapeCallback
reshape size@(Size w_ h_) = do
    let [w, h] = map fromIntegral [w_, h_]
    viewport $= (Position 0 0, size)
    matrixMode $= Projection
    loadIdentity
    ortho2D (-w / 2) (w / 2) (-h / 2) (h / 2)
    postRedisplay Nothing

module Draw where

import           Graphics.UI.GLUT

import           Colors
import           Util

drawNGon :: ColorFG -> Position -> GLint -> GLint -> GLfloat -> IO ()
drawNGon c (Position x_ y_) n_ d_ phi = do
    let [x, y, d, n] = map fromIntegral [x_, y_, d_, n_] :: [GLfloat]
    color c
    renderPrimitive Polygon $
        mapM_ vertex $ do
            let cossin = (,) <$> cos <*> sin
            (dx, dy) <- map (onTuple (d *) . cossin . (+ phi) . ((2 * pi / n) *)) [1 .. n]
            return $ Vertex2 (x + dx) (y + dy)


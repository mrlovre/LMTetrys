module Jewel where

import           Colored
import           Colors
import           Draw
import           Drawable

import Graphics.UI.GLUT

data Jewel = Ruby | Sapphire | Emerald

instance Colored Jewel where
    getColor j = case j of
        Ruby     -> red
        Sapphire -> blue
        Emerald  -> green

instance Show Jewel where
    show j = case j of
        Ruby     -> "R"
        Sapphire -> "S"
        Emerald  -> "E"

jToNGon :: Jewel -> GLint
jToNGon j = case j of
    Ruby     -> 5
    Sapphire -> 8
    Emerald  -> 6

jAngle :: Jewel -> GLfloat
jAngle j = case j of
    Ruby     -> pi / 10
    Sapphire -> pi / 8
    Emerald  -> 0

instance Drawable Jewel where
    draw j s p = drawNGon (getColor j) p (jToNGon j) s (jAngle j)

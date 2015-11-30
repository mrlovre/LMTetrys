module Jewel where

import           Colored
import           Colors
import           Draw
import           Drawable

import Graphics.UI.GLUT

data Jewel = Ruby | Sapphire

instance Colored Jewel where
    getColor j = case j of
        Ruby     -> red
        Sapphire -> blue

instance Show Jewel where
    show j = case j of
        Ruby     -> "R"
        Sapphire -> "S"

jToNGon :: Jewel -> GLint
jToNGon j = case j of
    Ruby -> 5
    Sapphire -> 6

jAngle :: Jewel -> GLfloat
jAngle j = case j of
    Ruby -> pi / 10
    Sapphire -> 0

instance Drawable Jewel where
    draw j s p = drawNGon (getColor j) p (jToNGon j) s (jAngle j)

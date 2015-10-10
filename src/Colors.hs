module Colors where

import           Graphics.UI.GLUT

type ColorBG = Color4 GLfloat
type ColorFG = Color3 GLfloat

blackBG :: ColorBG
blackBG = Color4 0 0 0 1

white :: ColorFG
white = Color3 0.9 0.9 0.9

blue :: ColorFG
blue = Color3 0 0 0.9

red :: ColorFG
red = Color3 0.9 0 0

green :: ColorFG
green = Color3 0 0.9 0

cyan :: ColorFG
cyan = Color3 0 0.9 0.9

magenta :: ColorFG
magenta = Color3 0 0.9 0.9

yellow :: ColorFG
yellow = Color3 0.9 0.9 0

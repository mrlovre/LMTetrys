module Model where

import           Graphics.UI.GLUT (GLsizei)

data Config = Config {
              width  :: GLsizei,
              height :: GLsizei }

defaultConfig :: Config
defaultConfig = Config 800 600


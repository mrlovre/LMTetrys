module Config where

import Graphics.UI.GLUT

data Config = Config {
              width  :: GLsizei,
              height :: GLsizei }

defaultConfig :: Config
defaultConfig = Config 800 600

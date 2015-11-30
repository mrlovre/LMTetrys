module Colored where

import Colors

class Colored a where
    getColor :: a -> ColorFG

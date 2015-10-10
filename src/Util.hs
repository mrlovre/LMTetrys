module Util where

onTuple :: (a -> b) -> (a, a) -> (b, b)
onTuple f (x, y) = (f x, f y)

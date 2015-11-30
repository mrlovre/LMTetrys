module Moa where

myFunction :: String -> String -> Int -> Maybe Char
myFunction s1 s2 n = do
    c1 <- getCharAt s1 n
    c2 <- getCharAt s2 (n + 1)
    return $ min c1 c2

getCharAt :: String -> Int -> Maybe Char
getCharAt s n
    | length s > n = Just $ s !! n
    | otherwise = Nothing

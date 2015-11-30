module SData where

import           Data.IORef

import           Config
import           Model

data SData = SData {
             config :: Config,
             board  :: IORef Board }

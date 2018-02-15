
{-# language DeriveAnyClass #-}

module Disciplina.Accounts.Account
       ( module Disciplina.Accounts.Account
       ) where

import Universum

import Control.Lens

import Data.Binary

data Account hash = Account
    { _aBalance :: Amount
    , _aNonce   :: Int
    , _aStorage :: hash
    , _aCode    :: hash
    }
    deriving (Show, Eq, Generic, Binary)

type Amount = Integer

makeLenses ''Account


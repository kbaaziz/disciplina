module Disciplina.DB.Real.Types
       ( MonadRealDB
       , DB (..)
       , DBType (..)
       , NodeDB (..)
       , ndbType
       , ndbDatabase
       ) where

import Universum

import Control.Lens (makeLenses)
import qualified Database.RocksDB as Rocks
import Ether.Internal (HasLens)

-- | Set of constraints necessary to operate on real DB.
type MonadRealDB ctx m =
    ( MonadReader ctx m
    , HasLens NodeDB ctx NodeDB
    , MonadIO m
    , Monad m
    )

data DB = DB
    { rocksReadOpts  :: !Rocks.ReadOptions
    , rocksWriteOpts :: !Rocks.WriteOptions
    , rocksOptions   :: !Rocks.Options
    , rocksDB        :: !Rocks.DB
    }

data DBType = WitnessDB
            | EducatorDB
            deriving Show

data NodeDB = NodeDB
    { _ndbType     :: !DBType
    , _ndbDatabase :: !DB
    }

makeLenses ''NodeDB
